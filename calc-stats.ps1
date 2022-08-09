param (
    [Parameter(Mandatory)]
    [string]
    $Target,

    [Parameter(Mandatory)]
    [string]
    $ToolDir,

    [ValidateRange(0, 100)]
    [int]
    $Num = 50,

    [int]
    $ThrottleLimit = 5,

    [int]
    $MaxScore = 1000000
)

$Script = Join-Path -Path $PWD -ChildPath "calc-score.ps1"
$Target = Resolve-Path $Target
$ToolDir = Resolve-Path $ToolDir

function Get-Stats {
    0..($Num - 1)
    | ForEach-Object -Parallel {
        $Expr = "$using:Script -Target $using:Target -ToolDir $using:ToolDir -Num $_"
        $Score = [int](Invoke-Expression $Expr)
        [PSCustomObject]@{
            "Name"  = ("{0:0000}" -f $_)
            "Score" = $Score
            "Ratio" = [int](([double]$Score) / ([double]$using:MaxScore) * 100.0)
        }
    } -AsJob -ThrottleLimit $ThrottleLimit
    | Wait-Job
    | Receive-Job
}

$Stats = Get-Stats -Num $Num -ThrottleLimit $ThrottleLimit
$Stats | Out-Host
$Stats | Measure-Object -Property Score -Maximum -Sum -Minimum -Average | Out-Host

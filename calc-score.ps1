param (
    [Parameter(Mandatory)]
    [string]
    $Target,

    [Parameter(Mandatory)]
    [string]
    $ToolDir,

    [ValidateRange(0, 100)]
    [int]
    $Num = 0
)

$Target = Resolve-Path $Target
$ToolDir = Resolve-Path $ToolDir

$FileName = "{0:0000}.txt" -f $Num
$InDir = Join-Path -Path $ToolDir -ChildPath "in/"
$OutDir = Join-Path -Path $ToolDir -ChildPath "out/"
$InFile = Join-Path -Path $InDir -ChildPath $FileName
$OutFile = Join-Path -Path $OutDir -ChildPath $FileName

if ((Test-Path -Path $OutDir) -ne $true) {
    New-Item -ItemType "directory" -Path $OutDir
}

Push-Location $ToolDir

Start-Process -FilePath $Target -RedirectStandardInput $InFile -RedirectStandardOutput $OutFile -Wait -NoNewWindow

$Tool = Join-Path -Path $ToolDir -ChildPath "target/release/vis.exe"
if ((Test-Path -Path $Tool) -ne $true) {
    cargo build --release
}

Invoke-Expression "$Tool $InFile $OutFile"

Pop-Location

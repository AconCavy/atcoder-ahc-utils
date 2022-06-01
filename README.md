# AtCoder AHC Utils

## Environment

- PowerShell Core 7.x

## calc-score.ps1

The script calculates a score using your program and a local tool for AHC.

### Options

- Target: The path string of your AHC solver program (bin or exe) file.
- ToolDir: The path string of an AHC local tool.
- Num: The seed an AHC local tool. (default 0)

```text
./calc-score.ps1 -Target ./path/to/achxxx.exe -ToolDir ./tools/ahcxxx/ -Num 0
```

## calc-stats.ps1

The script calculates a stats using your program and a local tool for AHC.

### Options

- Target: The path string of your AHC solver program (bin or exe) file.
- ToolDir: The path string of an AHC local tool.
- Num: The number of seed counts for an AHC local tool. (default 50)
- ThrottleLimit: The number of a job for the script. (default 5)

```text
./calc-stats.ps1 -Target ./path/to/achxxx.exe -ToolDir ./tools/ahcxxx/ -Num 10 -ThrottleLimit 10
```

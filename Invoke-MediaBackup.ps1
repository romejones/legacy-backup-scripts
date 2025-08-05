<#
.SYNOPSIS
    Runs multiple Robocopy backup jobs using inline job definitions.

.DESCRIPTION
    Accepts an array of hashtables, each containing Source, Destination, and LogName.
    Uses robocopy with consistent flags and logs each job to a specified directory.

.PARAMETER Jobs
    Array of hashtables. Each hashtable must include:
      - Source: Source directory
      - Destination: Destination directory
      - LogName: Name of the log file for this job

.PARAMETER LogDirectory
    Optional directory where log files will be saved. Defaults to current directory.

.EXAMPLE
    .\Invoke-MediaBackup.ps1 -Jobs @(
        @{ Source = "D:\Media\Plex"; Destination = "E:\Backup\Plex"; LogName = "plex_backup.txt" },
        @{ Source = "D:\Media\Pictures"; Destination = "E:\Backup\Pictures"; LogName = "pictures_backup.txt" }
    ) -LogDirectory "C:\Logs"
#>

param (
    [Parameter(Mandatory = $true)]
    [array]$Jobs,

    [string]$LogDirectory = "."
)

foreach ($job in $Jobs) {
    $src = $job.Source
    $dst = $job.Destination
    $log = Join-Path -Path $LogDirectory -ChildPath $job.LogName

    if (-not (Test-Path $src)) {
        Write-Warning "⚠ Source path does not exist: $src"
        continue
    }

    Write-Host "`n🔁 Copying $src → $dst" -ForegroundColor Cyan
    robocopy.exe $src $dst /E /Z /R:2 /W:3 /MT:1 /V /NP /Log+:$log

    if ($LASTEXITCODE -le 3) {
        Write-Host "✅ Completed: $log" -ForegroundColor Green
    } else {
        Write-Warning "❌ Robocopy returned exit code $LASTEXITCODE for $src"
    }
}

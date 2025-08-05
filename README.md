# Legacy Backup Scripts

This repository contains a flexible PowerShell script for running media and document backups using Robocopy.

## 🧰 Script: `Invoke-MediaBackup.ps1`

Runs a set of backup jobs defined inline using an array of hashtables. Each job specifies a source path, destination path, and a log filename.

### 🔧 Usage Example

```powershell
.\Invoke-MediaBackup.ps1 -Jobs @(
    @{ Source = "D:\Media\Plex"; Destination = "E:\Backups\Plex"; LogName = "plex_backup.txt" },
    @{ Source = "D:\Pictures"; Destination = "E:\Backups\Pictures"; LogName = "pictures_backup.txt" },
    @{ Source = "D:\Documents"; Destination = "E:\Backups\Documents"; LogName = "documents_backup.txt" }
) -LogDirectory "C:\Logs"

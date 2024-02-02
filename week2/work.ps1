$folderPath = "$PSScriptRoot\outfolder"

if (-not (Test-Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath -Force
    Write-Host "Folder 'outfolder' created successfully."
} else {
    Write-Host "Folder 'outfolder' already exists."
}
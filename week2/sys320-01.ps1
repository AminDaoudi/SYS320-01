Set-Location $PSScriptRoot

$files = Get-ChildItem -Filter *.ps1

$folderPath = Join-Path -Path $PSScriptRoot -ChildPath "outfolder"
$filePath = Join-Path -Path $folderPath -ChildPath "out.csv"

if (-not (Test-Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath -Force
    Write-Host "Folder 'outfolder' created successfully."
} else {
    Write-Host "Folder 'outfolder' already exists."
}

$files | Where-Object { $_.Extension -eq ".ps1" } | Select-Object FullName | Export-Csv -Path $filePath -NoTypeInformation

Write-Host "List of.ps1 files saved to 'out.csv' in 'outfolder' directory."
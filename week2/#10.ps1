$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition

Set-Location $scriptDirectory 

$files = Get-ChildItem -Path $scriptDirectory -Filter *.ps1

$folderPath = Join-Path -Path $folderPath -ChildPath "out.csv"

if (-not (Test-Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath -Force
    Write-Host "Folder 'outfolder' created successfully."
} else {
    Write-Host "Folder 'outfolder' already exists."
}

$files | Select-Object FullName | Export-Csv -Path $filePath -NoTypeInformation 

Write-Host "List of .ps1 files saved to 'out.csv' in 'outfolder' directory."
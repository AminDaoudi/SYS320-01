$folder = "C:\Users\champuser\SYS320-01\week2"

if (-not (Test-Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath -Force
    Write-Host "Folder 'outfolder' created successfully."
} else {
    Write-Host "Folder 'outfolder' already exists."
}
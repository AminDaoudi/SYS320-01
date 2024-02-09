$url = "https://www.champlain.edu"

$chromeProcess = Get-Process "chrome" -ErrorAction SilentlyContinue

if ($chromeProcess -eq $null) {
    Start-Process "chrome" -ArgumentList $url
    Write-Host "Google Chrome started and directed to $url"
} else {
    
    Stop-Process -Name "chrome" -Force
    Write-Host "Google Chrome stopped"
}

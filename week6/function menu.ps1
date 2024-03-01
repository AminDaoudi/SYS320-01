
#Function 
function Get-LastApacheLogs {
    # Define the path to the Apache log file
    $logPath = "C:\xampp\apache\logs\access.log"

    # Check if the log file exists
    if (Test-Path $logPath) {
        # Display the last 10 entries from the log file
        Get-Content $logPath -Tail 10
    } else {
        Write-Error "Log file does not exist at the path: $logPath"
    }
}

function Manage-ChromeProcess {
    $chromeProcess = Get-Process "chrome" -ErrorAction SilentlyContinue

    if ($chromeProcess -eq $null) {
     Start-Process "chrome" -ArgumentList "https://www.champlain.edu"
    } else {
  
  
  
  
  
  
        Stop-Process -Name "chrome" -Force
    }
}
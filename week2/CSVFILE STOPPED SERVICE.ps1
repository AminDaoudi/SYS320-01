$stoppedServices = Get-Service | Where-Object { $_.Status -eq "Stopped" }

$stoppedServicesSorted = $stoppedServices | Sort-Object -Property DisplayName

$csvFilePath = "C:\Users\champuser\SYS320-01\week2.csv"

$stoppedServicesSorted | Export-Csv -Path $csvFilePath -NoTypeInformation

Write-Host "Stopped services have been exported to $csvFilePath"
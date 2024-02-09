﻿. (Join-Path $PSScriptRoot "login_records.ps1")
clear
$loginoutsTable = Get-LoginLogoutRecords -NumberOfDays 15
$loginoutsTable

$shutdownsTable = Get-ComputerStartShutdownRecords -NumberOfDays 25 | Where-Object { $_.Event -eq "Shutdown" }
$shutdownsTable
$startupsTable = Get-ComputerStartShutdownRecords -NumberOfDays 25 | Where-Object { $_.Event -eq "Start" }
$startupsTable

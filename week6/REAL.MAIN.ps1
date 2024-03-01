. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


# Create a user
   elseif($choice -eq 3){ 
    $name = Read-Host -Prompt "Please enter the username for the new user"
    $checkUser = checkUser $name
    if ($checkUser -eq $false) { 
        do {
            $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
  #convert SecureString into plain text
       $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
       $plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

            # Check the given password with your new function
            $passwordValid = checkPassword $plainPassword
            if (-not $passwordValid) {
                Write-Host "Password does not meet the required criteria. Please try again."
            }
        } while (-not $passwordValid)

        createAUser $name $password
        Write-Host "User: $name is created."
    }
    else { 
        Write-Host "User already exists." 
    } 
}



    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

    $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

   # TODO: Check the given username with the checkUser function.

   disableAUser $name

   Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

    $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.

     $userLogins = getLogInAndOffs 90
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

   Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

   $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.

     $userLogins = getFailedLogins 90
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

    Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

     elseif($choice -eq 9) {
      $days = Read-Host -Prompt "Please enter the number of days to check for at-risk users"
     riskUsers $days
    }

    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #  or a character that should not be accepted. Give a proper message to the user and prompt again.
    
    else {
        Write-Host "Invalid choice. Please enter a number from the menu." | Out-String
    }
}


<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}




<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params 


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

}



function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   
}



function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}
function checkUser($name) {

    $Users = Get-LocalUser | Where-Object { $_.name -ilike $name }

    if ($Users.Count -gt 0) {
        return $true
    }
    else {
        return $false
        }
} 

function riskUsers($days) {
    # Placeholder for retrieving failed login attempts within the specified number of days
    # This needs to be replaced with your actual logic for retrieving this data
    $failedLogins = getFailedLogins $days

    # Group failed login attempts by username
    $groupedLogins = $failedLogins | Group-Object User

    # Filter out users with more than 10 failed login attempts
    $atRiskUsers = $groupedLogins | Where-Object { $_.Count -gt 1 }

    # Display or return the list of at-risk users
    $atRiskUsers | ForEach-Object {
        Write-Host "User at risk: $($_.Name) with $($_.Count) failed login attempts in the last $days days."
    }
}

riskUsers 30
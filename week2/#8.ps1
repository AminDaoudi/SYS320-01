#Choose a directory where you have some .ps1 files
cd $PSScriptRoot
 
#List Files based on file name
$files=(Get-ChildItem -Path C:\Users\champuser\SYS320-01)

for ($j=0; $j -le $files.Count ; $j++){
   
    if ($files[$j].Name -ilike "*.ps1"){
        Write-Host $files[$j].Name
    }
}

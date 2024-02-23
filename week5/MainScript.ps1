. .\Functions.ps1

# Call the function and capture the output
$classTable = gatherClasses

# Print the output
$classTable = daysTranslator $classTable

#print the output in list format 
#$classTable | Format-List

# List all the classes of Instructor Furkan Paligu 
#$classTable | Where-Object { $_.Instructor -eq "Furkan Paligu" }

# List all the classes of JOYC 310 on Mondays, only display Class Code and Times
# Sort by Start Time
#$classTable | Where-Object { $_.Location -eq "JOYC 310" -and "Monday" -in $_.Days } | 
 #   Sort-Object "Time Start" | 
  #  Select-Object "Class Code", "Time Start", "Time End"


# Make a list of all the instructors that teach in at least 1 course in the given course codes
# sort by name and make it unqiue 
$ITSInstructors = $classTable | Where-Object {
    $_."Class Code" -like "SYS*" -or
    $_."Class Code" -like "NET*" -or
    $_."Class Code" -like "SEC*" -or
    $_."Class Code" -like "FOR*" -or
    $_."Class Code" -like "CSI*" -or
    $_."Class Code" -like "DAT*"
} | Sort-Object "Instructor" -Unique | Select-Object -ExpandProperty "Instructor"
$ITSInstructors

$classTable | Where-Object { $_.Instructor -in $ITSInstructors } |
    Group-Object "Instructor" | 
    Sort-Object Count -Descending | 
    Select-Object Count, Name

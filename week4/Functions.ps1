# Functions.ps1

function gatherClasses {
   
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.34/Courses.html

    # Get all the tr elements of HTML document
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    # Empty array to hold results
    $FullTable = @()

    for ($i=1; $i -lt $trs.length; $i++) { # Going over every tr element
        
        # Get every td element of the current tr element
        $tds = $trs[$i].getElementsByTagName("td")

        # Want to separate start time and end time from one time field
        $Times = $tds[5].innerText.Split("-")


        $FullTable += [PSCustomObject]@{"Class Code"  = $tds[0].innerText;                                 
                                        "Title"       = $tds[1].innerText;
                                        "Days"        = $tds[4].innerText;
                                        "Time Start"  = $times[0];
                                        "Time End"    = $times[1];
                                        "Instructor"  = $tds[6].innerText;
                                        "Location"    = $tds[9].innerText;
                                    }
    } # end of for loop

    return $FullTable
}

# Translator function to convert Days property to an array of days
function daysTranslator($FullTable){

    # Go over every record in the table
    for ($i = 0; $i -lt $FullTable.length; $i++) {
       
        $Days = @()

        # If you see "M" -> Monday
        if ($FullTable[$i].Days -ilike "*M*") { $Days += "Monday" }

        # If you see "T" followed by T,W, or F -> Tuesday
        if ($FullTable[$i].Days -ilike "*T*[W,F]*"){ $Days += "Tuesday" }
        

        # If you see "W" -> Wednesday
        if ($FullTable[$i].Days -ilike "*W*") { $Days += "Wednesday" }

        # If you see "TH" -> Thursday
        if ($FullTable[$i].Days -ilike "*TH*") { $Days += "Thursday" }

        # If you see "F" -> Friday
        if ($FullTable[$i].Days -ilike "*F*") { $Days += "Friday" }

        # Replace Days property with the array of days
        $FullTable[$i].Days = $Days 
    }

    return $FullTable
}


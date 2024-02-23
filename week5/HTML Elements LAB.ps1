# Send a web request to retrieve the content of the page
#$scraped_page = Invoke-WebRequest -Uri "http://10.0.17.34/page4.html"

# Get a count of the links in the page
#$scraped_page.Links.Count

# Display Links as HTML Element
#$scraped_page.Links 

# Display only URL and its text
$scraped_page.Links | Select-Object Href

# Extract <h2> elements from the body
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | ForEach-Object { $_.outerText }

$h2s

# Print innerText of every div element that has the class as "div-1" 
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | where {
    $_.getAttributeNode("class").Value -ilike "*div-1*"
} | select innerText

$divs1

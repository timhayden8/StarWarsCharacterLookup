#this function uses the swapi to look up a particular star wars character and list all relevant information about them.
function starwarscharacterlookup
{
    param ([string]$character)
    $Characters = invoke-restmethod https://swapi.dev/api/people
    $characters.results | where-object {$_.name -like "$character"} 
}
starwarscharacterlookup -character "Obi-Wan"
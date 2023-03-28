#this function uses the swapi to look up a particular star wars character. It then grabs its homeworld using another section of the star wars API and finally connects to a discord webhook to comment what character is from where.
function starwarscharacterlookup
{
    param ([string]$character)
    $Characters = invoke-restmethod https://swapi.dev/api/people
    $lookup = ($characters.results | where-object {$_.name -like "*$character*"}) 
    $hw = (invoke-restmethod $lookup.homeworld)
    $hw=$hw.name
    $lookup=$lookup.name
    $content="$lookup is from $hw"
    $payload = [pscustomobject]@{
        content = $content
    }
    #discord webhook
    $Hook="ENTER YOUR WEBHOOK URI HERE"
    invoke-restmethod $hook -method Post -body ($payload | convertto-json) -ContentType 'application/json'

}
starwarscharacterlookup -character "Obi-Wan"

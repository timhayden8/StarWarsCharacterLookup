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
    $Hook="https://discord.com/api/webhooks/1090132828894806126/gXsU36xyPMhyaid8htTLbh7F3NM4JsnQMNTUs4_dtZJ4nEcrjUEK3UXEiRVkzTnOmOy9"
    invoke-restmethod $hook -method Post -body ($payload | convertto-json) -ContentType 'application/json'

}
starwarscharacterlookup -character "Obi-Wan"

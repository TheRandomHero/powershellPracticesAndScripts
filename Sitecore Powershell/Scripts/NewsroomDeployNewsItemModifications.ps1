gi master: -query "fast://sitecore/content/Shared Data/discover/News//*[@@templatename='Discover News']" -language * | % {
    if ($_.NewsPublishDate) {
        $date = $_.NewsPublishDate -replace "T000000Z", ""
        $template = 'yyyyMMdd'
        $Year = [DateTime]::ParseExact($date, $template, $null).Year
    } else {
        $Year = $_.Created.Year
    }
    $Year
    #$_.Year = $Year
    #$_.NewsType = '{B498DA69-5946-4B0F-B9F5-E626290F72C7}'
}
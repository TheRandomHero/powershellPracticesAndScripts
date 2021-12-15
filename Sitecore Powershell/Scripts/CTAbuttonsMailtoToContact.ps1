Get-Item master: -Query "fast://sitecore/content/Sites/Corporate/*/Home//*[@@templatename='Buttons']" -language * | Where { ($_."First button" -like "*mailto*") -or  ($_."Second button" -like "*mailto*")} | foreach-object {
    $pageCountry = [regex]::match($_.fullpath, 'Corporate/(...)/').Groups[1].Value
    $contactPath = "/sitecore/content/Sites/Corporate/" + $pageCountry+ "/Home/Contact"
    $contactPage = Get-Item -Path $contactPath
    if ($_."First Button" -like "*mailto*") {
	    $_."First Button" = $contactPage
    }
    if($_."Second Button" -like "*mailto*" ) {
		$_."Second Button" = $contactPage
    }
    Publish-Item -Item $_ -PublishMode SingleItem
    Publish-Item -Item $_ -PublishMode Smart
    $_
} 

Get-Item master: -Query "fast://sitecore/content/Shared Data/discover//*[@@templatename='Discover Button']" -language * | Where { ($_."Link" -like "*mailto*") } | measure


Get-Item master: -Query "fast://sitecore/content/Shared Data/discover//*[@@templatename='Discover Button']" -language * | Where { ($_."Link" -like "*mailto*") } | foreach-object {
    $contactPath = "/sitecore/content/Sites/Corporate/DBE/Home/Contact"
    $contactPage = Get-Item -Path $contactPath
    
    if ($_."Link" -like "*{985457C3-D7A9-4744-999E-FEF519AA6598}*") {

	    [Sitecore.Data.Fields.LinkField]$field = $_.Fields['Link']
    	$_.BeginEdit();
    	$field.linktype = "internal"
    	$field.TargetID = "{985457C3-D7A9-4744-999E-FEF519AA6598}"
    	$field.url = ""
    	$_.EndEdit();
    	$_.Link
    }
    $_
    Publish-Item -Item $_ -PublishMode SingleItem
    Publish-Item -Item $_ -PublishMode Smart
} 
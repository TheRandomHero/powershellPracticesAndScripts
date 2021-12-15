function replaceButtonLink($item, $buttonField, $targetToReplace, $replacement) {
	[Sitecore.Data.Fields.LinkField]$field = $buttonField
	$item.BeginEdit()
	$field.Url = $field.Url -replace $targetToReplace, $replacement
	$item.EndEdit()
	$buttonField
}

Get-Item master: -Query "/sitecore/content/Sites/Corporate/DUK/Home//*[@@templatename='Buttons']" | foreach-object {
    if ($_."First Button" -like "*info.uk@delawareconsulting.com*") {
		replaceButtonLink $_ $_.Fields["First Button"] 'info.*@delaware.pro' 'info@delaware.co.uk'
    }
    if($_."Second Button" -like "*info.uk@delawareconsulting.com*" ) {
		replaceButtonLink $_ $_.Fields["Second Button"] 'info.*@delaware.pro' 'info@delaware.co.uk'
    }
	Publish-Item -Item $_ -PublishMode Smart 
}

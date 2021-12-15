function replaceButtonLink($item, $buttonField) {
	[Sitecore.Data.Fields.LinkField]$field = $buttonField
	$item.BeginEdit();
	$field.url = ""
	$field.linktype = "internal"
	$field.TargetID = "{79503B7F-3058-45AC-B964-1AB8C46E6237}"
	$item.EndEdit();
}

Get-Item master: -Query "/sitecore/content/Sites/Corporate/DFR/Home//*[@@templatename='Buttons']" -Language @('fr', 'fr-fr') | foreach-object {
    if ($_."First Button".toLower() -like "*irena.iordanova@delaware.pro*" -or $_."First Button".toLower() -like "*info@delaware.pro*") {
		$_."First Button"
		$_
		$item = Add-ItemVersion -Item $_ -language $_.language
		replaceButtonLink $item $item.Fields["First Button"];
    }
    if($_."Second Button".toLower() -like "*irena.iordanova@delaware.pro*" -or $_."First Button".toLower() -like "*info@delaware.pro*") {
        $_."Second Button"
        $_
        $item = Add-ItemVersion -Item $_ -language $_.language
		replaceButtonLink $item $item.Fields["Second Button"];
    }
	if ($item) {
	    Publish-Item -Item $item -PublishMode SingleItem 
	    $item
	    $item = null
	}
}

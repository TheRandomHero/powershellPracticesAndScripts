$countryNodes = "DBR","DCH","DFR","DHU","DLU","DNA","DNL","DPH","DSI","DUA","DUK"

foreach ($node in $countryNodes) {
	$footerPath = "/sitecore/content/Sites/Corporate/$node/Site Configuration/Footer Config"
	$footerItemLanguages = Get-Item -Path $footerPath -Language *
	$node
	foreach($footerItem in $footerItemLanguages) {
	   $newFooterItem = Add-ItemVersion -Item $footerItem -Language $footerItem.Language.Name -TargetLanguage $footerItem.Language.Name
	   $newFooterItem
	   if ($newFooterItem."Footer Title" -eq "") {
	       $newFooterItem."Footer Title" = "<strong>Global</strong> Services"
	   }
    	if ($newFooterItem."Social Call To Action" -eq "") {
    	    $newFooterItem."Social Call To Action" = "Follow Us on"
    	}
    	if ($newFooterItem."Button Link" -eq "") {
    	    $countrySpecificContactPage = Get-Item -Path "/sitecore/content/Sites/Corporate/$node/Home/Contact"
    	    $newFooterItem."Button Link" = '<link text="Contact Us" linktype="internal" class="" title="" target="" querystring="" id="' + $countrySpecificContactPage.ID + '" />'
    	}
        $footerItem.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
        $footerItem."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
        Invoke-Workflow -Item $footerItem -CommandName "Submit"
	}
} 
# TODO: 
# - get parameters from command line
# - ask for confirmation
# - don't fix for solution pages
# - workflow issue (?) Invoke-Workflow : Workflow missing or item not in workflow:

# For example DHU, DNL
$targetCountry = "DSI"

$pagesToCopy = "GLocal services"

<#
"Customer intelligence",
"Customer Strategy Disruption",
"Digital Asset Management",
"GDPR profile stores",
"How to connect with your customer",
"Marketing Automation",
"Omnichannel experience",
"Product Information Management",
"SAP on Azure"
#>



foreach ($sourcePage in $pagesToCopy) {
	$sourcePagePath = "/sitecore/content/Sites/Corporate/DBE/Home/Solutions/$sourcePage"
	$pageName = $sourcePage
	$destinationPath = (Split-Path $sourcePagePath -parent) -replace "DBE", $targetCountry
	
	if (Test-Path -Path "$destinationPath/$sourcePage") {
	    "Warning: $destinationPath already exists, skipping"
	    continue
	}
	
	Copy-Item -Path $sourcePagePath -Destination $destinationPath -Recurse

    $copiedPagePath = "$destinationPath\$pageName"
	$copiedPageItem = Get-Item -Path $copiedPagePath
	
    if ($copiedPageItem) {
	    $headerRendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Header/Header"
	    $footerRendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Footer/Footer"

    	$headerRenderingInstance = Get-Rendering -Item $copiedPageItem -Rendering $headerRendering
	    $footerRenderingInstance = Get-Rendering -Item $copiedPageItem -Rendering $footerRendering

	    $newHeaderDataSource = Get-Item -Path "/sitecore/content/Sites/Corporate/$targetCountry/Site Configuration/Header Config"
	    $newFooterDataSource = Get-Item -Path "/sitecore/content/Sites/Corporate/$targetCountry/Site Configuration/Footer Config"

	    if ($headerRenderingInstance) {
	        $headerRenderingInstance.Datasource = $newHeaderDataSource.ID
	    	Set-Rendering -Item $copiedPageItem -Instance $headerRenderingInstance
	    	"Success: $copiedPagePath header set"
    	} else {
    	    "Fail: $copiedPagePath header instance not found for $targetCountry"
    	}

    	if ($footerRenderingInstance) {
    	    $footerRenderingInstance.Datasource = $newFooterDataSource.ID
    		Set-Rendering -Item $copiedPageItem -Instance $footerRenderingInstance
    		"Success: $copiedPagePath footer set"
	    } else {
	        "Fail: $copiedPagePath footer instance not found for $targetCountry"
	    }
	    "Success: finished copying $copiedPagePath"
	    
	    #Need to set workflow state to draft before submitting
	    $copiedPageItem."__Workflow state" = "{3AB79688-C34F-4454-B3EC-056AC3F56C8D}"
	    Invoke-Workflow -Item $copiedPageItem -CommandName "Submit" -Comments "Automated copy of page from $sourcePagePath"
    } else {
        "Fail: couldn't find $copiedPagePath"
    }
}
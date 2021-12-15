$countryNodes = <#"DBE",#> "DBR", "DCH", "DFR", "DHU", "DLU", "DNA", "DNL", "DPH", "DSI", "DUA", "DUK"

$pagesToCopy = "404", "500"

function getNodeFromPath($path) {
    return [regex]::match($path, 'Corporate/(...)/').Groups[1].Value
}

function setCorrectDataSource($page, $renderingInstance) {
	$origDataSource = Get-Item master: -ID $renderingInstance.DataSource
	
    $pageNode = getNodeFromPath $page.Fullpath
    $origDataSourceNode = getNodeFromPath $origDataSource.Fullpath
	
    $newDataSourcePath = $origDataSource.Fullpath -replace $origDataSourceNode, $pageNode
    $newDataSource = Get-Item -Path $newDataSourcePath
    "$origDataSourcePath changing to $newDataSourcePath"
    if ($newDataSource) {
		$renderingInstance.Datasource = $newDataSource.ID
		Set-Rendering -Item $page -Instance $renderingInstance
	} else { 
	    "Error: No datasource found at" + $newDataSourcePath
	}
}

foreach ($node in $countryNodes) {
	foreach ($sourcePage in $pagesToCopy) {
		$sourcePagePath = "/sitecore/content/Sites/Corporate/DBE/Home/Error Pages/$sourcePage"
		$destinationPath = "/sitecore/content/Sites/Corporate/$node/Home/Error Pages"
		
		if (Test-Path -Path "$destinationPath/$sourcePage") {
			"Warning: $destinationPath already exists, skipping"
			continue
		}
		
		Copy-Item -Path $sourcePagePath -Destination $destinationPath -Recurse
		
		$copiedPagePath = "$destinationPath/$sourcePage"
		$copiedPageItem = Get-Item -Path $copiedPagePath
		
		if ($copiedPageItem) {
			$headerRendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Header/Header"
			$footerRendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Footer/Footer"

			$headerRenderingInstance = Get-Rendering -Item $copiedPageItem -Rendering $headerRendering
			
            if ($headerRenderingInstance) {
			    setCorrectDataSource $copiedPageItem $headerRenderingInstance
            } else {
                "Header rendering instance not found for" + $copiedPageItem.Fullpath
            }
            
            $footerRenderingInstance = Get-Rendering -Item $copiedPageItem -Rendering $footerRendering
			if ($footerRenderingInstance) {
			    setCorrectDataSource $copiedPageItem $footerRenderingInstance
			} else {
			    "Footer rendering instance not found for" + $copiedPageItem.Fullpath
			}
			
			$copiedPageItem.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
			$copiedPageItem."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
			Invoke-Workflow -Item $copiedPageItem -CommandName "Submit" -Comments "Automated copy of page from $sourcePagePath"
		} else {
			"Copy can't be found at $destinationPath"
		}
	}
}

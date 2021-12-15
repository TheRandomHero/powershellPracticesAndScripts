# /sitecore/content/Sites/Corporate/DBE/Site Configuration/Footer Config
# /sitecore/content/Sites/Corporate/DBE/Site Configuration/Header Config
# /sitecore/content/Sites/Corporate/DBE/Forms/Download Agristo Whitepaper
$countryNodes = "DBE",
"DBR",
"DCH",
"DFR",
"DHU",
"DLU",
"DNA",
"DNL",
"DPH",
"DSI",
"DUA",
"DUK"

#/sitecore/layout/Renderings/Modules/Web Forms for Marketers/Mvc Form
#"/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Header/Header"
function getNodeFromPath($path) {
    return [regex]::match($path, 'Corporate/(...)/').Groups[1].Value
}

function checkDataSourceNode($page, $renderingPath) {
    # Get the general rendering item
    $rendering = Get-Item -Path $renderingPath

    # Get instance of rendering on current page
    $renderingInstance = Get-Rendering -Item $page -Rendering $rendering
    
    # Match node name in path
    $pageCountryNode = getNodeFromPath $page.Fullpath
    
	if ($renderingInstance) {
	    if ($renderingInstance.Datasource) {
		    $dataSource = Get-Item $renderingInstance.Datasource
		} elseIf ($renderingInstance.Parameters -like "*FormID*") {
		    $formID = [regex]::match($renderingInstance.Parameters, '%7B(.*)%').Groups[1].Value
		    $renderingInstance.Parameters
		    $dataSource = Get-Item master: -ID $formID
		} else {
		    "No datasource, " + $pageCountryNode + ", " + $page.Name + ", " + $rendering.Name
		}
		
		if ($dataSource) {
			$formTemplateItemID = "{FFB1DA32-2764-47DB-83B0-95B843546A7E}"
    		if ($dataSource.Template -eq $formTemplateItemID) {
				setCorrectMvcForm $page $renderingInstance
			}
			$dataSourceCountryNode = getNodeFromPath $dataSource.Fullpath
            	if (-Not ($pageCountryNode -eq $dataSourceCountryNode)) {
            		#"Datasource mismatch, " + $pageCountryNode + ", " + $page.Name + ", " + $rendering.Name + ", " + $dataSourceCountryNode
            		if ($renderingInstance.Datasource) {
            		    setCorrectDataSource $page $renderingInstance
        		}
        	}
		}
	}
}

function setCorrectDataSource($page, $renderingInstance) {
	$origDataSource = Get-Item master: -ID $renderingInstance.DataSource
    #$origDataSource.Fullpath
    $pageNode = getNodeFromPath $page.Fullpath
    $origDataSourceNode = getNodeFromPath $origDataSource.Fullpath
    $newDataSourcePath = $origDataSource.Fullpath -replace $origDataSourceNode, $pageNode
    #$newDataSourcePath
    $newDataSource = Get-Item -Path $newDataSourcePath
    "$origDataSourcePath changed to $newDataSourcePath"
    # if ($newDataSource) {
    #   renderingInstance.Datasource = $newDataSource.ID
    #   Set-Rendering -Item $page -Instance $renderingInstance
    # } else { 
    #   "Error: No datasource found at" + $newDataSourcePath
    # }
}

function setCorrectMvcForm ($page, $renderingInstance) {
    #Example $renderingInstance.Parameters: "FormID=%7B54848054-A265-42FC-9475-AE50EF8FC544%7D&ReadQueryString=1"
    #ReadQuerystring value might might change
    $origFormID = [regex]::match($renderingInstance.Parameters, '%7B(.*)%').Groups[1].Value
    $origFormID
    $origForm = Get-Item master: -Id $origFormID
    $origFormNode = getNodeFromPath  $origForm.Fullpath
    $pageNode = getNodeFromPath $page.Fullpath
    $newFormPath = $origForm.Fullpath -replace $origFormNode, $pageNode
    $newForm = Get-item -Path $newFormPath
    $origForm
    #[System.Web.HttpUtility]::UrlEncode($URL) to get those %7b-s
    #FormID=%7B54848054-A265-42FC-9475-AE50EF8FC544%7D&ReadQueryString=1
    #(FormID=%7B).*(%7D&ReadQueryString.*)
    #$newFormIdNoBrackets = $newForm.ID -replace '{|}', ''
    #$newFormIdNoBrackets
}

"Error description, Source node, Page Name, Rendering name, Wrong datasource node"

foreach ($countryNode in $countryNodes) {
	$whitepapers = Get-Item -Path "master://" -Query "/sitecore/content/Sites/Corporate/$countryNode/Home/Downloads//*[startswith(@@name, 'Download') OR startswith(@@name, 'DOWNLOAD')]"
	foreach ($item in $whitepapers) {
		#checkDataSourceNode $item "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Header/Header"
		checkDataSourceNode $item "/sitecore/layout/Renderings/Modules/Web Forms for Marketers/Mvc Form"
		#checkDataSourceNode $item "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Footer/Footer"
	}
}

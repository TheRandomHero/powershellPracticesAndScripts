$pages = Get-Item master: -Query "/sitecore/content/Sites/Corporate/*/Home/Solutions/SAP Leonardo"
$headerRendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Header/Header"
$footerRendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Footer/Footer"

$renderings = @($headerRendering, $footerRendering)

foreach ($page in $pages) {
    $pageCountry = [regex]::match($page.fullpath, 'Corporate/(...)/').Groups[1].Value
    foreach ($rendering in $renderings) {
        # Get instance of rendering on current page
        $renderingInstance = Get-Rendering -Item $page -Rendering $rendering
        if ($renderingInstance) {
            $currentDataSource = Get-Item master: -ID $renderingInstance.Datasource
            
            $datasourceCountry = [regex]::match($currentDataSource.fullpath, 'Corporate/(...)/').Groups[1].Value
            $datasourceCountry + " | " + $pageCountry
            if ($pageCountry -ne $datasourceCountry) {
                # Get the item of the new data source
                $newDataSourcePath = $currentDataSource.fullpath -replace $datasourceCountry, $pageCountry
                $newDataSource = Get-Item -Path $newDataSourcePath
                
                if ($renderingInstance -and $newDatasource) {
    
                 	$renderingInstance.Datasource = $newDataSource.ID
                 	Set-Rendering -Item $page -Instance $renderingInstance
                 	"Success: " + $page.fullpath + " " + $rendering.Name + " set"
                } else {
                    "Couldn't get datasource at " + $newDataSourcePath
                }
            }
        } else {
            "Couldn't find rendering instance for " + $page.fullpath + " | " + $page.ID
        }
    } 
}


### Newer more general version
gi -path "./" | % {
	$item = $_
    $finalRenderings = @(Get-Rendering -Item $item -FinalLayout -Device $defaultDevice)
	$currentCountryNode = [regex]::match($item.ItemPath, 'Corporate/(...)/').Groups[1].Value
    foreach($rendering in $finalRenderings) {
        $ritem = gi master: -ID $rendering.ItemID
		$dsitem = Get-Item master: -ID $rendering.Datasource
		$correctDsItem = Get-Item -Path ($dsitem.ItemPath -replace "DBE", $currentCountryNode)
		if ($correctDsItem) {
			$rendering.Datasource =  $correctDsItem.ID
			Set-Rendering -Item $item -Instance $rendering
		}
     }
     $item
}
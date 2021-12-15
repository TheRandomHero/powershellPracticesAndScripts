$pages = @(Get-Item master: -Query "/sitecore/content/Sites/Corporate/DNL/Home/Digital")
$pages += Get-Item master: -Query "/sitecore/content/Sites/Corporate/DNL/Home/Digital//*[@@templatename='Content Page']"
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
                $newDataSourcePath = $currentDataSource.fullpath -replace $datasourceCountry, $pageCountry -replace "Digital ", ""
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

Get-Item master: -Query "/sitecore/content/Sites/Corporate/DNL/Home/Digital//*[@@templatename='Buttons']" | Where {$_."First Button Text" -like "*talk*"} |
foreach-object {
    $_."First Button" = Get-Item master: -ID "{E62A8334-A367-43BD-AEB5-9E775C595296}"
    $_
}
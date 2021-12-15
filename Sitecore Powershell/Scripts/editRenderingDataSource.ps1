#/sitecore/layout/Renderings/Modules/Web Forms for Marketers/Mvc Form


# First get the general rendering item
$rendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Header/Header"

# Get instance of rendering on current page
$renderingInstance = Get-Rendering -Item $page -Rendering $rendering

# Get the item of the new data source
$newDataSource = Get-Item -Path "/sitecore/content/Sites/Corporate/$targetCountry/Site Configuration/Header Config"

if ($renderingInstance) {
	$currentDatasource = Get-Item $renderingInstance.Datasource
	if ($currentDatasource.Fullpath -like "*$thisCountry*") {
		continue
	}
	$renderingInstance.Datasource = $newDataSource.ID
	Set-Rendering -Item $page -Instance $renderingInstance
	"Success: $copiedPagePath header set"
} else {
    "Fail: $copiedPagePath header instance not found for $targetCountry"
}
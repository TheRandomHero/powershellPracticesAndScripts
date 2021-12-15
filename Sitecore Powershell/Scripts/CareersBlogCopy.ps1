$countryNodes = "DBR", "DCH", "DFR", "DHU", "DLU", "DNA", "DNL", "DPH", "DSI", "DUA", "DUK"
$copiedItems = @();

foreach ($country in $countryNodes) {
	$destinationPathCareers = "/sitecore/content/Sites/Corporate/$country/Home/Careers/"
	$detailPage =  Copy-Item -Recurse -Path "/sitecore/content/Sites/Corporate/DBE/Home/Careers/blog" -Destination $destinationPathCareers -PassThru
	$copiedItems +=	$detailPage
	$starItem = gci -Item $detailPage | Where {$_.Name -like '`*'}
	$destinationPathSiteConfig = "/sitecore/content/Sites/Corporate/$country/Site Configuration/Link Configurations/"
	$linkConfig = Copy-Item -Recurse -Path "/sitecore/content/Sites/Corporate/DBE/Site Configuration/Link Configurations/Careers Blog Detail" -Destination $destinationPathSiteConfig -PassThru
	$linkConfig."Detail Page" = $starItem
}

foreach ($item in $copiedItems) {
    $itemCountry = [regex]::match($item.ItemPath, 'Corporate/(...)/').Groups[1].Value
	$finalRenderings = @(Get-Rendering -Item $item -FinalLayout -Device $defaultDevice)
	
	
    foreach($rendering in $finalRenderings) {
        $ritem = gi master: -ID $rendering.ItemID

         $dsitem = Get-Item master: -ID $rendering.Datasource
         $correctDsItem = Get-Item -Path ($dsitem.ItemPath -replace "DBE", $itemCountry)
         $rendering.Datasource =  $correctDsItem.ID
        if (($ritem.Name -like "*Hot Topics*") -and -not ($dsitem.TemplateName -like "Hot Topics Config")) {
          $rendering.Datasource = "query:.//*[@@templatename='Hot Topics Config']"
        }
         Set-Rendering -Item $item -Instance $rendering
         
     }
     $item
}
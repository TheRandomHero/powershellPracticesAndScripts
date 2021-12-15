$countryNodes = "DBR", "DCH", "DFR", "DHU", "DLU", "DNA", "DNL", "DPH", "DSI", "DUA", "DUK"
$copiedItems = @();

foreach ($country in $countryNodes) {
	$destinationPath = "/sitecore/content/Sites/Corporate/$country/Home/"
	$detailPage =  Copy-Item -Recurse -Path "/sitecore/content/Sites/Corporate/DBE/Home/Newsroom" -Destination $destinationPath -PassThru
	$copiedItems +=	$detailPage
	$starItem = gci -Item $detailPage | Where {$_.Name -like '`*'}
	$linkConfig = Get-Item -Path "/sitecore/content/Sites/Corporate/$country/Site Configuration/Link Configurations/News Detail"
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

         Set-Rendering -Item $item -Instance $rendering
         
     }
     $item
}
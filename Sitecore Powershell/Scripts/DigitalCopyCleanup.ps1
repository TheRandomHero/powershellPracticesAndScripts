$pages = @(gi -Path "/sitecore/content/Sites/Corporate/DHU/Home/Digital")
$pages += Get-Item master: -Query "/sitecore/content/Sites/Corporate/DHU/Home/Digital//*[@@templatename='Content Page']"

$device = Get-LayoutDevice -Default


foreach ($item in $pages) {
    $finalRenderings = @(Get-Rendering -Item $item -FinalLayout -Device $defaultDevice)

    foreach($rendering in $finalRenderings) {
		$correctDsItem = ""
        $ritem = gi master: -ID $rendering.ItemID

         $dsitem = Get-Item master: -ID $rendering.Datasource
         $correctDsItem = Get-Item -Path ($dsitem.ItemPath -replace "DBE", "DHU" -replace "Digital Header Config", "Header Config")
         if ($correctDsItem) {
			$rendering.Datasource =  $correctDsItem.ID
			Set-Rendering -Item $item -Instance $rendering
         }
     }
     $item
}



Get-Item master: -Query "/sitecore/content/Sites/Corporate/DHU/Home/Digital//*[@@templatename='Buttons']" | Where {($_."First Button Text" -like "*talk*") -or ($_."First Button Text".toLower() -like "*connect*")} |
foreach-object {
    $_."First Button" = Get-Item -Path "/sitecore/content/Sites/Corporate/DHU/Home/Contact"
    $_
}

gi -path "./" | % {
	$item = $_
    $finalRenderings = @(Get-Rendering -Item $item -FinalLayout -Device $defaultDevice)

    foreach($rendering in $finalRenderings) {
        $ritem = gi master: -ID $rendering.ItemID

         $dsitem = Get-Item master: -ID $rendering.Datasource
         $correctDsItem = Get-Item -Path ($dsitem.ItemPath -replace "DBE", "DFR" -replace "Digital Header Config", "Header Config")
         $rendering.Datasource =  $correctDsItem.ID
        if (($ritem.Name -like "*Hot Topics*") -and -not ($dsitem.TemplateName -like "Hot Topics Config")) {
          $rendering.Datasource = "query:.//*[@@templatename='Hot Topics Config']"
        }
         Set-Rendering -Item $item -Instance $rendering
         
     }
     $item
}

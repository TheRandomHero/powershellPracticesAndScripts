$pages = Get-Item master: -query "/sitecore/content/Sites/Corporate/*/Home/Solutions/Profisee"
#$pages += Get-Item master: -Query "/sitecore/content/Sites/Corporate/DNL/Home/Digital//*[@@templatename='Content Page']"
$headerRendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Header/Header"
$footerRendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Footer/Footer"

$renderings = @($headerRendering, $footerRendering)

#Get-Item master: -query "/sitecore/content/Sites/Corporate/*/Home/Solutions/" | Where { -not ($_.ItemPath -like "*DBE*")} | % {
#    Copy-Item -Path "/sitecore/content/Sites/Corporate/DBE/Home/Solutions/Profisee" -Recurse -Destination $_.ItemPath
#}

foreach ($item in $pages) {
    $pageCountry = [regex]::match($item.fullpath, 'Corporate/(...)/').Groups[1].Value

    $finalRenderings = @(Get-Rendering -Item $item -FinalLayout -Device $defaultDevice)

    foreach($rendering in $finalRenderings) {
        $ritem = gi master: -ID $rendering.ItemID

         $dsitem = Get-Item master: -ID $rendering.Datasource
         $correctDsItem = Get-Item -Path ($dsitem.ItemPath -replace "DBE", $pageCountry)
         if ($correctDsItem) {
             $rendering.Datasource =  $correctDsItem.ID
         }

        if (($ritem.Name -like "*Hot Topics*") -and -not ($dsitem.TemplateName -like "Hot Topics Config")) {
          $rendering.Datasource = "query:.//*[@@templatename='Hot Topics Config']"
        }
         Set-Rendering -Item $item -Instance $rendering
         
     }
     $item
}

gi -path "./" | % {
	$item = $_
    $pageCountry = [regex]::match($item.fullpath, 'Corporate/(...)/').Groups[1].Value

    $finalRenderings = @(Get-Rendering -Item $item -FinalLayout -Device $defaultDevice)

    foreach($rendering in $finalRenderings) {
        $ritem = gi master: -ID $rendering.ItemID

         $dsitem = Get-Item master: -ID $rendering.Datasource
         $correctDsItem = Get-Item -Path ($dsitem.ItemPath -replace "DBE", $pageCountry)
         if ($correctDsItem) {
             $rendering.Datasource =  $correctDsItem.ID
         }

        if (($ritem.Name -like "*Hot Topics*") -and -not ($dsitem.TemplateName -like "Hot Topics Config")) {
          $rendering.Datasource = "query:.//*[@@templatename='Hot Topics Config']"
        }
         Set-Rendering -Item $item -Instance $rendering
         
     }
     $item
}
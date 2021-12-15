#Create local

Get-Item master: -Query "/sitecore/content/Shared Data/Products #and# Vendors//*[@@templatename='Products and Vendors Shared Config']" | foreach-object {
$name = $_.name
$localItem = Get-Item -Path "/sitecore/content/Sites/Corporate/DBE/Home/Products and Vendors/Page Configuration/Products and Vendors List/$name"
if (-not $localItem) {
    $name
    $newItem = New-Item -Path "master:/sitecore/content/Sites/Corporate/DBE/Home/Products and Vendors/Page Configuration/Products and Vendors List/$name" -ItemType "{40742062-341C-4CBE-A2D0-42289818EBA9}"
    if ($newItem) {
        $newItem.Item = $_.ID
    }
}
}

#add links where possible

Get-Item master: -Query "/sitecore/content/Sites/Corporate/DBE/Home/Products and Vendors/Page Configuration/Products and Vendors List/*" | foreach-object {
    $name = $_.name
    $query = "/sitecore/content/Sites/Corporate/DBE/Home/Solutions/*[contains(@@name, '$name')]"
    $solutionpage = Get-Item master: -Query $query
    $solutionpage
    if ($solutionpage) {
        
        [Sitecore.Data.Fields.LinkField]$field = $_.Fields["Link"]
        $_.BeginEdit()
        $field.LinkType = "internal"
        $field.TargetID = $solutionpage.ID
        $_.EndEdit()
        $_.Link
    }
}
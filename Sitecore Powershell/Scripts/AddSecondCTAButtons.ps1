$buttons = @((Get-Item master: -Query "/sitecore/content/Sites/Corporate/DBE/Home/Solutions/SAP Leonardo/Page Configuration/*[@@templatename='Buttons']"),
(Get-Item master: -Query "/sitecore/content/Sites/Corporate/DBE/Home/Solutions/SAP S4HANA Cloud/Page Configuration/*[@@templatename='Buttons']"),
(Get-Item master: -Query "/sitecore/content/Sites/Corporate/DBE/Home/Solutions/OpenText/Page Configuration/*[@@templatename='Buttons']"),
(Get-Item master: -Query "/sitecore/content/Sites/Corporate/DUK/Home/Solutions/SAP Leonardo/Page Configuration/*[@@templatename='Buttons']"),
(Get-Item master: -Query "/sitecore/content/Sites/Corporate/DUK/Home/Solutions/SAP S4HANA Cloud/Page Configuration/*[@@templatename='Buttons']"),
(Get-Item master: -Query "/sitecore/content/Sites/Corporate/DUK/Home/Solutions/OpenText new/Page Configuration/*[@@templatename='Buttons']"),
(Get-Item master: -Query "/sitecore/content/Sites/Corporate/DNA/Home/Solutions/SAP Leonardo/Page Configuration/*[@@templatename='Buttons']"),
(Get-Item master: -Query "/sitecore/content/Sites/Corporate/DNA/Home/Solutions/SAP S4HANA Cloud/Page Configuration/*[@@templatename='Buttons']"),
(Get-Item master: -Query "/sitecore/content/Sites/Corporate/DNA/Home/Solutions/OpenText new/Page Configuration/*[@@templatename='Buttons']"))

foreach ($item in $buttons) {
    # $item."Second Button Text" = 'Meet us at SAPPHIRE NOW'
    [Sitecore.Data.Fields.LinkField]$field = $item.Fields["Second Button"]
    $country = ([regex]::match($item.fullpath, 'Corporate/(...)/').Groups[1].Value -replace 'D', '').ToLower() -replace 'na', 'us' -replace 'uk', 'gb'
     $field
     $item.BeginEdit()
    # $field.linktype = 'external'
     $field.Url = "/en-$country/Events/SAPPHIRE-NOW-2018"
     $item.EndEdit()
    $item.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
$item."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
Invoke-Workflow -Item $item -CommandName 'Submit' -Comment 'Automated Submit'

Invoke-Workflow -Item $item -CommandName 'Approve' -Comment 'Automated Approve'
}
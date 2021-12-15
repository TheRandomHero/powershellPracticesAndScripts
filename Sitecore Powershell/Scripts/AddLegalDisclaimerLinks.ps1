$countryNodes = "DBR", "DCH", "DFR", "DHU", "DLU", "DNA", "DNL", "DPH", "DSI", "DUA", "DUK"

foreach ($node in $countryNodes) {
    $footerItems = Get-Item -Path "/sitecore/content/Sites/Corporate/$node/Site Configuration/Footer Config" -Language *
    $legalPage = Get-Item -Path "/sitecore/content/Sites/Corporate/$node/Home/About Us/Legal Disclaimer"
    foreach ($footer in $footerItems) {
        $node
        #$legalpage.fullPath
        [Sitecore.Data.Fields.LinkField]$field = $footer.Fields["Disclaimer Link"]
        if ($field.TargetID -eq '{00000000-0000-0000-0000-000000000000}') {
            $node + " is missing disclaimer"
            $footer.BeginEdit();
            $field.TargetID = $legalPage.ID
            $field.linktype = 'internal'
            $footer.EndEdit();
        }
        #Write-Host ($field | Format-Table | Out-String)
        $footer."Disclaimer Link"
        $footer.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
        $footer."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
        Invoke-Workflow -Item $footer -CommandName 'Submit' -Comment 'Automated Legal Disclaimer adding'
    }
}
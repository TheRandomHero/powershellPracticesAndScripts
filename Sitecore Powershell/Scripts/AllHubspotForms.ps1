$HubspotForms = gi master: -Query "fast://sitecore/content//*[@@templatename='Hubspot Form Config']" -language * | Where { $_."Form ID" }

$props = @{
    Title = "delaware.pro embedded Hubspot forms"
    InfoTitle = "Total $($ContentItems.Count) items found!"
    InfoDescription = "Export Item Data"
	PageSize = 100
}

$ColumnProperties = @{Label="ItemPath"; Expression={$_.ItemPath} },
@{Label="ID"; Expression={$_.ID} },
#@{Label="URL"; Expression={Get-ItemUrl($_) },
@{Label="Language"; Expression={$_.Language} },
@{Label="Form ID"; Expression={"hsForm_" + $_."Form ID"}}

$HubspotForms | Show-ListView @props -Property $ColumnProperties 
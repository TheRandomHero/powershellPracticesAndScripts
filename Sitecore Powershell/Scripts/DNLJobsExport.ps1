function Get-ItemUrl($itemToProcess){
    if ($itemToProcess) {
         [Sitecore.Context]::SetActiveSite("DNL")
         $urlop = New-Object ([Sitecore.Links.UrlOptions]::DefaultOptions)
         $urlop.AddAspxExtension = $false
         $urlop.AlwaysIncludeServerUrl = $true
         $linkUrl = [Sitecore.Links.LinkManager]::GetItemUrl($itemToProcess,$urlop)
         ($linkUrl -replace "https://corp-preview.delawareconsulting.com", "http://delaware.pro").ToLower()
    }
}


function GetNameFromID($countryField) {
    if ($countryField) {
        $countryIDs = $countryField.Split("|")
        foreach ($ID in $countryIDs) {
            (gi master: -ID $ID).Name
            if ($countryIDs.Count -gt 1) {
                ", "
            }
        }
    }
}

$NewsItems = gi web: -Query "/sitecore/content/Shared Data/Open Positions/Netherlands//*[@@templatename='Job']" -language * | Where { $_."Permit Countries" }

$props = @{
    Title = "delaware.pro NL jobs"
    InfoTitle = "Total $($NewsItems.Count) items found!"
    InfoDescription = "Export Item Data"
	PageSize = 100
}

$ColumnProperties = @{Label="Title"; Expression={$_."Content Title"} },
@{Label="ItemPath"; Expression={$_.ItemPath} },
@{Label="TargetGroup"; Expression={GetNameFromID($_.TargetGroup)} },
@{Label="URL"; Expression={Get-ItemUrl($_) }},
@{Label="Country"; Expression={GetNameFromID($_."Permit Countries")} },
@{Label="Date"; Expression={$_.Created} },
@{Label="Language"; Expression={$_.Language} },
@{Label="ID"; Expression={$_.ID} }

$NewsItems | Sort-Object -Unique | Show-ListView @props -Property $ColumnProperties 
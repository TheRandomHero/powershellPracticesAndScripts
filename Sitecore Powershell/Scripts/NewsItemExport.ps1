function Get-ItemUrl($itemToProcess){
    if ($itemToProcess) {
         [Sitecore.Context]::SetActiveSite("DBE")
         $urlop = New-Object ([Sitecore.Links.UrlOptions]::DefaultOptions)
         $urlop.AddAspxExtension = $false
         $urlop.AlwaysIncludeServerUrl = $true
         $linkUrl = [Sitecore.Links.LinkManager]::GetItemUrl($itemToProcess,$urlop)
         ($linkUrl -replace "https://corp-preview.delawareconsulting.com", "http://delaware.pro").ToLower()
    }
}


function GetCountryFromID($countryField) {
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

$NewsItems = gi web: -Query "/sitecore/content/Shared Data/discover/News//*[@@templatename='Discover News']" -language * | Where { $_."Permit Countries" }

$props = @{
    Title = "delaware.pro News"
    InfoTitle = "Total $($NewsItems.Count) items found!"
    InfoDescription = "Export Item Data"
	PageSize = 100
}

$ColumnProperties = @{Label="Title"; Expression={$_."Content Title"} },
@{Label="ItemPath"; Expression={$_.ItemPath} },
@{Label="URL"; Expression={Get-ItemUrl($_) }},
@{Label="Country"; Expression={GetCountryFromID($_."Permit Countries")} },
@{Label="Date"; Expression={$_.NewsPublishdate} },
@{Label="Language"; Expression={$_.Language} },
@{Label="ID"; Expression={$_.ID} }

$NewsItems | Sort-Object -Unique | Show-ListView @props -Property $ColumnProperties 
function Get-ItemUrl($itemToProcess){
     [Sitecore.Context]::SetActiveSite("DHU")
     $urlop = New-Object ([Sitecore.Links.UrlOptions]::DefaultOptions)
     $urlop.AddAspxExtension = $false
     $urlop.AlwaysIncludeServerUrl = $true
     $linkUrl = [Sitecore.Links.LinkManager]::GetItemUrl($itemToProcess,$urlop)
     ($linkUrl -replace "https://corp-preview.delawareconsulting.com", "http://delaware.pro" -replace "%20", "-" -replace "/en/", "/en-hu/").ToLower()
}

function depthName($itempath, $offset) {
    $name = ""
    $depth = (([regex]::Matches($itempath, "/" )).count) - ($offset);
    for ($i=0; $i -lt $depth; $i++) {
        $name += "-"
    }
    $name += (Split-Path -Leaf $itempath)
    $name
}

gi web: -query "/sitecore/content/Sites/Corporate/DHU/Home//*[@@templatename='Content Page' or @@templatename='Solution folder' or @@templatename='Folder']" |
Where {-not ($_.Name -like "*Download*")} #|
#Show-ListView -Property @{Label="Name"; Expression={depthName $_.Itempath 7}}, @{Label="URL"; Expression={Get-ItemUrl($_)}} 


gi web: -query "/sitecore/content/Shared Configuration/Carrers Config/Job domains/*" | Show-ListView -Property @{Label="Name"; Expression={depthName $_.Itempath 7}}, @{Label="URL"; Expression={Get-ItemUrl($_)}} 
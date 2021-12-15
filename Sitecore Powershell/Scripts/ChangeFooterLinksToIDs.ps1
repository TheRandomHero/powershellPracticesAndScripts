# Get footer Item
$footer = Get-Item -Path "/sitecore/content/Sites/Corporate/DSI/Site Configuration/Footer Config"

# Create Htmlagilitypack object
$html = New-Object -TypeName HtmlAgilityPack.HtmlDocument
# Load actual footer html
$html.LoadHtml($footer."Link Area")
$html.DocumentNode.SelectNodes("//a") | foreach-object {
    if ($_.Attributes["href"].Value -like "/en-sg*") {
        $pagePath = $_.Attributes["href"].Value -replace '/en-sg', '/sitecore/content/Sites/Corporate/DSI/Home' -replace '-', ' '
        $pageID = (Get-Item -Path $pagePath).ID
        if ($pageID) {
            $pageID = $pageID -replace '-', '' -replace '{', '' -replace '}', ''
			$urlPageID = "~/link.aspx?_id=$pageID&amp;_z=z"
            $_.SetAttributeValue("href", $urlPageID)
        }
    }
}
#$footer."Link Area" = $html.DocumentNode.outerHTML
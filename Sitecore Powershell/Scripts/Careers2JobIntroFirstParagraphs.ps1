gci "/sitecore/content/Shared Data/Open Positions/Belgium" -language * | % {
    $html = $_."Job Detailed Description"
    $doc = New-Object -TypeName HtmlAgilityPack.HtmlDocument
    $doc.LoadHtml($html)
    $headers = $doc.DocumentNode.SelectNodes("//h3")
    $outputParagraph = $null
    if ($headers -and ($headers.Count -gt 1)) {
        $firstParagraph = $doc.DocumentNode.SelectNodes("//*")[0]
        if ($firstParagraph.OuterHtml -eq $headers[0].OuterHtml) {
            $sibling = $firstParagraph.NextSibling
        } else {
            $sibling = $firstParagraph
        }
        while ($sibling -and ($sibling.Name -ne "h3")) {
            #$sibling
            $outputParagraph += $sibling.OuterHtml
            $sibling = $sibling.NextSibling
            if (($sibling.Name -eq "h3") -and ($sibling.InnerHtml -like "*Our Vision*")) {
                $sibling = $sibling.NextSibling
            }
        }
        
        if (($outputParagraph.Length -lt 2000) -and (-not $_."Intro Description")) {
            $new = Add-ItemVersion -Item $_ -Language $_.language -TargetLanguage $_.language
            $new."Intro Description" = $outputParagraph -replace "color: #595959;", ""
            $new."Job Detailed Description" = ($new."Job Detailed Description" -replace $headers[0].OuterHtml, "") -replace $outputParagraph, ""
            $new
        }
    
    }
}
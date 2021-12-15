Import-Function FillCardDetails

gi master: -query "fast://sitecore/content/Sites/Corporate/DBE/Home/Solutions/*/Page Configuration/*[@@templatename='Overview Slider']" -language "en" | % {
    $parentpath = $_.ItemPath -replace $_.Name, "" -replace "/Page Configuration/", ""
    $parentitem = gi -path $parentpath -language "fr*"
    if ($parentitem) {
            #  $new = Add-ItemVersion -Item $_ -Language "en" -TargetLanguage "fr"
            #  $new.Title = $new.Title -replace "Related content", "Contenu associé"
            #  $new.Title
            #  $new
            $cards = gci -path $_.ItemPath -language "en"
            foreach ($card in $cards) {
                $frenchcard = gi -path $card.ItemPath -language "fr*"
                if (-not $frenchcard) {
                    $linkfield = [Sitecore.Data.Fields.LinkField]$card.Fields["Card detail link"]
                    if ($linkfield.linktype -eq "internal") {
                        $card
                        $new = Add-ItemVersion -path $card.ItemPath -Language "en" -TargetLanguage "fr"
                        $new."Card Title" = ""
                        $new."Card Summary" = ""
                        Fill-CardDetails $new $new.language
                    }
                }
            }
    }
}

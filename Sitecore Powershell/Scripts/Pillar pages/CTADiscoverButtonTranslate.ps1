gi master: -query "fast://sitecore/content/Sites/Corporate/DBE/Home/*/*/Page Configuration/*" -language "fr" | % {
    if($_.Fields["CTA"]) {
        $link = [Sitecore.Data.Fields.LinkField]$_.Fields["CTA"]
        if ($link.Text -like  $_.Fields["CTA Title"]) {
            $_.BeginEdit();
            $link.Text = "Découvrez plus"
            $_.EndEdit();
        }
    } elseif ($_.Fields["CTA Title"]) {
        if ($_."CTA Title" -like "Discover More") {
            $_."CTA Title" = "Découvrez plus"
        }
    }
}
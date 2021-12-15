#technologies: get the translated title from the solution page itself
$language = "fr"
gci -path "/sitecore/content/Sites/Corporate/DBE/Home/info/Applied Innovation/Page Configuration/Solutions Learn more" -language $language | % {
    $link = [Sitecore.Data.Fields.LinkField]$_.Fields["Link"]
    $title = (gi master: -ID $link.TargetID -language $language)."Page Title" -replace "(.*):(.*)", '$1'
    if ($title) {
        $_.Title = $title
    }
}

$language = "nl"
$countryNode = "DNL"
gci -language $language | % {
	$new = Add-ItemVersion -Item $_ -language $language -targetlanguage $language
    $link = [Sitecore.Data.Fields.LinkField]$new.Fields["Link"]
    $title = (gi master: -ID $link.TargetID -language $language)."Page Title" -replace "(.*):(.*)", '$1'
	if (-not $title) {
		$linkedItem = gi master: -ID $link.TargetID
		$countryLinkedItem = gi -path ($linkedItem.ItemPath -replace "DBE", $countryNode) -language $language
		$title = $countryLinkedItem."Page Title" -replace "(.*):(.*)", '$1'
	}
    if ($title) {
        $new.Title = $title
    }
}

#blogs get the translated title from the blog itself
$language = "fr"
gci -path "/sitecore/content/Sites/Corporate/DBE/Home/info/Applied Innovation/Page Configuration/Blogs" -Language $language | % {
    $link = [Sitecore.Data.Fields.LinkField]$_.Fields["Link"]
    $title = (gi master: -ID $link.TargetID -language $language)."Content Title"
    if ($title) {
        $_.Title = $title
    }
}

$language = "nl"
gci -Language $language | % {
	$title = $null
    $link = [Sitecore.Data.Fields.LinkField]$_.Fields["Link"]
    $title = (gi master: -ID $link.TargetID -language $language)."Content Title"
    if ($title) {
        $_.Title = $title
    }
}

#Rename subitems to their title for clarity in editor
gci | % {
	$_.BeginEdit();
	$_.Name = $_.Title;
	$_.EndEdit();
} 

"EN SAVOIR PLUS"
"TECHNOLOGIES ACTUELLES"
"NOS RÉFÉRENCES CLIENTS"

#Replace lazily added external links with item links (only for blogs)
$language = "fr"
gci -language $language | % {
	$link = [Sitecore.Data.Fields.LinkField]$_.Fields["Link"];
	$name = $link.url -replace "https://www.delaware.pro/.*/Discover/Blog/", "" -replace "-", " ";
	if ($link -and $name) {
		$itemlink = gi master: -query "/sitecore/content/Shared Data/Discover/Blog/*/$name";
		if ($itemlink) {
			$_.Link = $itemlink
		}
	}
}

#Translate "Meet an Expert" left title
gi master: -query "/sitecore/content/Sites/Corporate/DBE/Home/*/*/Page Configuration//*[@@templatename='Meet an expert']" -language "fr" | % {
    $_."Left title" = $_."Left title" -replace "What about meeting an <b>expert</b>", "Et si vous rencontriez un <b>expert</b> ?"
}

#Translate "follow us"

gi master: -query "/sitecore/content/Sites/Corporate/DBE/Home//*[@@templatename='Follow Us Config']" -language "fr" | % {
    $_.Title = "Suivez-nous:"
    $franceItem = Add-ItemVersion -Item $_ -Language 'fr' -TargetLanguage 'fr-fr'
    $franceItem.BeginEdit();   
    ([Sitecore.Data.Fields.LinkField]$franceItem.Fields["Facebook Link"]).url = "https://www.facebook.com/delawareFrance/"
    ([Sitecore.Data.Fields.LinkField]$franceItem.Fields["Twitter Link"]).url = "https://twitter.com/delaware_france"
    ([Sitecore.Data.Fields.LinkField]$franceItem.Fields["LinkedIn Link"]).url = "https://www.linkedin.com/company/9338959/"
    ([Sitecore.Data.Fields.LinkField]$franceItem.Fields["Instagram Link"]).url = "https://www.instagram.com/delawareinternational/"
    ([Sitecore.Data.Fields.LinkField]$franceItem.Fields["Youtube Link"]).url = "https://www.youtube.com/channel/UCyQURFhGbwmhD_3O3v55c1w"
    $franceItem.EndEdit(); 
    $franceItem
}

#translate the top navigation
gi master: -query "/sitecore/content/Sites/Corporate/DBE/Home//*[@@templatename='Item Config']" -language "fr" | % {
    if ($_.Title -like "Customer Stories") {
        $_.Title = "Nos références clients"
    } elseif ($_.Title -like "Blogs") {
        $_.Title = "Articles de blog"
    } elseif ($_.Title -like "Artificial Intelligence") {
        $_.Title = "Intelligence artificielle"
    } elseif ($_.Title -like "Industries") {
        
    } elseif ($_.Title -match "Enabling Technologies|1") {
        $_.Title = "Technologies actuelles"
    } elseif ($_.Title -like "Learn more") {
        $_.Title = "En savoir plus"
    } else {
        $_.Title
    }
}

#add missing top navigation links
gi master: -query "/sitecore/content/Sites/Corporate/DBE/Home//*[@@templatename='Item Config']" -language "en" | % {
    if (-not $_.Link) {
        $item = $_
        gci -Path ($_.ItemPath -replace "Pillar Navigation.*", "") | Where {$_.Name -like $item.Name} | % {
            $item
            $_
            $item.link = $_
        }
    }
}


gci -path "web:\content\shared data\discover\blog\2019" -language 'fr*' |  Where { $_."Permit countries" -like "*{DF931D23-E156-4D0C-BB4D-36C4F3B6754C}*" } | Sort-Object -Property "PublishDate" -Descending | Select-Object -first 6 | % {
    #Title Link Image
    #Title DiscoverImage 
    $_
    $newBlogTopic = New-Item -Path "/sitecore/content/Sites/Corporate/DFR/Home/Page Configuration/Blogs" -Name $_.Name -ItemType "{1100E183-7F66-4271-B345-4F424EFADA34}" -language "fr"
    $newBlogTopic
    $newBlogTopic.Title = $_."Content Title"
    $newBlogTopic.Link = $_
    $newBlogTopic.Image = $_.DiscoverImage
}
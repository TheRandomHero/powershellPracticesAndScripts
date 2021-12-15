$HotTopicstempalteID = "{8A488497-A805-4196-AF61-AECB9FF8ADEA}"
$HotTopics2019tempalteID = "{1100E183-7F66-4271-B345-4F424EFADA34}"
$language = "hu"
$sourceFolderPath = "/sitecore/content/Shared Data/discover/Cases"
$destinationPath = "/sitecore/content/Sites/Corporate/DHU/Home/Page Configuration/Cases Hot Topics"
$permitCountryID = "{C944E6A1-1B78-46CC-B4A3-CF9DF651BEBB}"

# Where { $_."Permit countries" -like "*$permitCountryID*" } |

gci -Path $sourceFolderPath -language ($language + "*") -recurse | Where { $_."Permit countries" -like "*$permitCountryID*" } | Sort-Object -Property "PublishDate" -Descending | Select-Object -first 6 | % {
    #Title Link Image
    #Title DiscoverImage 
    $_
    $newBlogTopic = New-Item -Path $destinationPath -Name $_.Name -ItemType $HotTopicstempalteID -language $language
    $newBlogTopic
    $newBlogTopic.Title = $_."Content Title"
    $newBlogTopic.Link = $_
    $newBlogTopic.Image = $_.DiscoverImage
}
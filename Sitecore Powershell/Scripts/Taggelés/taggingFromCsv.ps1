<#
 @param $tagCategoryName name of tag category (Technology, industry. etc)
 @param $tagList names of tags to apply to $page
 @param $page to apply the tags to
#>
function ApplyTagsToPage($tagCategoryName, $tagList, $page) {
    $page.$tagCategoryName = ""
    foreach ($tag in $tagList) {
        if ($tag -and $tag -ne "None" -and $tag -ne "All") {
            $tag = $tag -replace '&', 'and'
            $tagItem = Get-Item -Path "/sitecore/content/Shared Data/Solutions/Solution tags/$tagCategoryName/$tag"
            $tagID = $tagItem.ID
            if ($page.$tagCategoryName) {
                $tagID = '|' + $tagID
            }
            $page.$tagCategoryName += $tagID
        } elseif ($tag -eq "All") {
            $allTagsList = @()
            $allTags = @(Get-ChildItem -Path "/sitecore/content/Shared Data/Solutions/Solution tags/$tagCategoryName" | foreach-object {$allTagsList += $_.Name})
            ApplyTagsToPage $tagCategoryName $allTagsList $page
            break
        }
    }
    "Success: added $tagCategoryName tags to " + $page.Fullpath + " added tags: $tagList"
}

$media = Get-Item -Path "master:/sitecore/media library/System/solution_tags"
[system.io.stream]$body = $media.Fields["blob"].GetBlobStream()
try 
{
    $contents = New-Object byte[] $body.Length
    $body.Read($contents, 0, $body.Length) | Out-Null
} 
finally 
{
    $body.Close()    
}

$csv = [System.Text.Encoding]::Default.GetString($contents) | ConvertFrom-Csv -Delimiter ';'

$countryNodes = "DBR", "DCH", "DFR", "DHU", "DLU", "DNA", "DNL", "DPH", "DSI", "DUA", "DUK"
$count = 0
foreach ($node in $countryNodes) {
    $node
    foreach ($row in $csv) {
        $title = $row.'Page Title'
        
        $industry = @($row.'Industry', $row.'Industry 2', $row.'Industry 3')
        $technology = @($row.'Technolgy', $row.'Technology 2', $row.'Technology 3')     #There is a typo, so the first Technology column is name Technolgy :(
        $business = @($row.'Business', $row.'Business 2', $row.'Business 3', $row.'Business 4')
        $trending = @($row.'Trending', $row.'Trending 2', $row.'Trending 3', $row.'Trending 4')
        
        $itemName = $row.'link' -replace 'https://www.delaware.pro/en-be/solutions/', '' -replace '-', ' '
        $page = Get-Item -Path "/sitecore/content/Sites/Corporate/$node/Home/Solutions/$itemName"
        if ($page) {
            ApplyTagsToPage 'Industry' $industry $page
            ApplyTagsToPage 'Technology' $technology $page
            ApplyTagsToPage 'Business' $business $page
            ApplyTagsToPage 'Trending' $trending $page
            if (-Not $page.Description) {
                $belgianPage = Get-Item "/sitecore/content/Sites/Corporate/DBE/Home/Solutions/$itemName"
                if ($belgianPage) {
                    $page.Description = $belgianPage.Description
                    "Success: added meta description from DBE version to $node on page " + $page.fullpath
                } else {
                    "Error: Couldn't find DBE page with " + $row.'Page Title' + " with name $itemName"
                }
            }
        } else {
            "Error: Couldn't find page with " + $row.'Page Title' + " with name $itemName on node $node"
        }
    }
}
$count

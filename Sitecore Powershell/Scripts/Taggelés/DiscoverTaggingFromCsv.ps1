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

$media = Get-Item -Path "/sitecore/media library/New Corporate Folder/Tagging/discover_dbe_tags" #"master:/sitecore/media library/System/solution_tags"
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
$count = 0
foreach ($row in $csv) {
	$title = $row.'Page Title'
	
	if ($row.'link') {
		$industry = @($row.'Industry', $row.'Industry 2', $row.'Industry 3')
		$technology = @($row.'Technolgy', $row.'Technology 2', $row.'Technology 3')     #There is a typo, so the first Technology column is name Technolgy :(
		$business = @($row.'Business', $row.'Business 2', $row.'Business 3', $row.'Business 4')
		$trending = @($row.'Trending', $row.'Trending 2', $row.'Trending 3', $row.'Trending 4')
		
 		$itemName = ($row.'link' -replace 'https://www.delaware.pro/.*/Discover/.*/', '' -replace '-', ' ').ToLower()
 		$type = $row.'linK' -replace 'https://www.delaware.pro/.*/Discover/(.*)/.*', '$1'
 		$query = "/sitecore/content/Shared Data/discover/$type//*[@@key='$itemName' or @#__Display Name#='$itemName']"
 		$page = Get-Item master: -Query $query
 		
        if (-Not $page) {
    		$query = "/sitecore/content/Shared Data/discover/$type//*[@#Content Title#=`"$title`"]" 
    		$page = Get-Item master: -Query $query
        }
		
		if ($page) {
			if($page.Count -gt 1) {$page = $page[0]}
			
			ApplyTagsToPage 'Industry' $industry $page
		    ApplyTagsToPage 'Technology' $technology $page
			ApplyTagsToPage 'Business' $business $page
			ApplyTagsToPage 'Trending' $trending $page
			
			if (-Not $page.'Short Description' -and -Not $page.'Description') {
				"Missing description: " + $page.fullpath + " | " + $page.ID
			}
			
			$page.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
			$page."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
		    Invoke-Workflow -Item $page -CommandName 'Submit' -Comment 'Automated Submit: tagged'
			
			Invoke-Workflow -Item $page -CommandName 'Approve' -Comment 'Automated Approve: tagging'
		} else {
			"Error: Couldn't find page with " + $row.'Page Title' + " with name $itemName on node $node"
		}
	}
}
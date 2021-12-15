<#
    .SYNOPSIS
        Find all of the items and fields which contain a specific text.
        
    .LINK
        https://vandsh.github.io/sitecore/2018/01/27/spe-search-replace.html
#>
$rootItem = Get-Item -Path "master:/sitecore/content/Shared Data/discover"
$needle = "button"

@($rootItem) + @($rootItem.Axes.GetDescendants() | Initialize-Item) | 
    ForEach-Object {
        $currentItem = $_
        Get-ItemField -Item $currentItem -ReturnType Field -Name "*" `
            | ForEach-Object{ 
                if($PSItem.Value.Contains($needle)){
                    [pscustomobject]@{
                        "Name"=$currentItem.DisplayName
                        "ItemId"=$currentItem.ID
                        "FieldName"=$_.Name
                        "ItemPath" = $currentItem.Paths.Path
                        "Paragraph Text" = $currentItem."Paragraph Text"
                    }
                }
            }
} | foreach-object {
    $changeItem = Get-Item master: -ID $_.ItemId
    $newVersion = Add-ItemVersion -Item $changeItem -language $changeItem.language
    $newVersion."Paragraph Text" = $newVersion."Paragraph Text" -replace 'class="button"', 'class="button" data-id="gtm-cta"' -replace 'class="red button"', 'class="red button" data-id="gtm-cta"'
    Invoke-Workflow -Item $newVersion -CommandName Submit
    Invoke-Workflow -Item $newVersion -CommandName Accept
    $newVersion
    Publish-Item -Item $newVersion -PublishMode SingleItem
} 
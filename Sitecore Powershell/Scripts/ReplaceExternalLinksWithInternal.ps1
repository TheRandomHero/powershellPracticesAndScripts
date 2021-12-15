gi master: -query "fast://sitecore/content/Sites/Corporate/*/Home/*[@@name='info' or @@name='connect']//*" -language * | % {
    $item = $_
    
    $_.Fields | Where { ($_.TypeKey -like "*link*") -and
                        ($_.Value -like "*external*delaware.pro*") -and
                        (-not ($_.Value -like "*store.delaware.pro*")) -and
                        (-not ($_.Value -like "*info.delaware.pro*"))} | % {
                            #Add-ItemVersion -Item $item -Language $item.language -TargetLanguage $item.language
                            [Sitecore.Data.Fields.LinkField]$field = $_
                            $blogname = (Split-Path -leaf $field.URL) -replace "-", " "
                            $blogname
                            $field.url
                            $blogitem = gi master: -query "fast://sitecore/content/Shared Data/discover/blog/*/*[@@key='$blogname']"
                            $item
                            #$item.Link = $blogitem
                            
                        }
}

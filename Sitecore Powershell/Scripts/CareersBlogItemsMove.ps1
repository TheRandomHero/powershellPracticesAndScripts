gi master: -query "fast://sitecore/content/Shared Data/discover/blog//*[@@templatename='Discover Blog']" | Where { $_.Business -like "*{4594AFF8-2C80-42B2-8A37-CDE584927DA1}*"} | % {
    move-item -Path $_.ItemPath -Destination "/sitecore/content/Shared Data/careers blog/2019" 
}
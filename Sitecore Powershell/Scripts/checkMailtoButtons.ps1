Get-Item web: -Query "fast://sitecore/content/Shared Data/discover//*[@@templatename='Discover Button']" -language * | Where { ($_."Link" -like "*mailto*") } 

Get-Item web: -Query "fast://sitecore/content/Sites/Corporate/*/Home//*[@@templatename='Buttons']" -language * | Where { ($_."First button" -like "*mailto*") -or  ($_."Second button" -like "*mailto*")}
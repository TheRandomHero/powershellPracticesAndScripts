Get-ChildItem -Path "/sitecore/content/Sites/Corporate/DSI/Home/People of Delaware/Page Configuration/KeyTakeAwayConfig" | foreach-object {$_.Name}

Add-ItemVersion -Id "{2B1ACB3F-FF77-4E40-ADA3-41CB3ED5C21D}" -Language en-BE -TargetLanguage en -IfExist Append

Get-ChildItem -Path "/sitecore/content/Sites/Corporate/DSI/Home/People of Delaware/Page Configuration/KeyTakeAwayConfig" | Add-ItemVersion -Language en-BE -TargetLanguage en -
IfExist Append
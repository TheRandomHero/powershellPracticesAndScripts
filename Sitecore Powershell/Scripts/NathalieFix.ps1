Get-ChildItem -Path "./" -Recurse |
foreach-object { $_.'__Enable Item Fallback' = 1}
Where {$_."__Created by" -eq "sitecore\Nathalie Vermeulen" -and -not $_.'__Enable Item Fallback'} |
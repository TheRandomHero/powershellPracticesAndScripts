$solutionConfigTemplateID = '{43105009-77BC-4E6A-8BD4-E5DE70B72F1B}'

$blogTemplateID = '{92856554-AFB1-4A13-AE78-C08A61F8F00C}'
$caseTemplateID = '{063F2D16-AA03-4DDA-9AD4-E6BB2B567C72}'
$newsTemplateID = '{F029E5B7-6EAC-4FF1-8CEA-457E8B41ED0F}'

$eventTemplateID = '{207BB526-918F-4BAB-B8D3-933F7E0DBB44}'

$openPositionTemplateID = '{F41CBAD4-1305-4DA9-948C-874EF5AD8A68}'

$contentPageTemplateID =  '{4ECEBE47-DE76-4FCE-B133-E1523EA41733}'

# Corporate trunk: content page, solution
# Child item: Image Overlay Config - Image, Horizontal Image - Picture
Get-Item master: -Query "fast:/sitecore/content/Sites/Corporate//*[@@templateid='$contentPageTemplateID']" | Where-Object {!$_."Social Sharing Image" } | foreach-object { 
    $childItemQuery = "fast:" + $_.fullpath.ToString() + "//*[@@templatename='Image Overlay Config']"
    Get-Item master: -Query $childItemQuery
    
}
# SolutionImage on item, or see content page childitem
Get-Item master: -Query "fast:/sitecore/content/Sites/Corporate//*[@@templateid='$solutionConfigTemplateID']" | measure


# Shared data trunk: blog, case, news, event, open position
# Image fields: DiscoverImage, SmallImage 
Get-Item master: -Query "fast:/sitecore/content/Shared Data/discover/blog//*[@@templateid='$blogTemplateID']" | measure
Get-Item master: -Query "fast:/sitecore/content/Shared Data/discover/Cases//*[@@templateid='$caseTemplateID']" | measure
Get-Item master: -Query "fast:/sitecore/content/Shared Data/discover/News//*[@@templateid='$newsTemplateID']" | measure
# Image fields: Background 
Get-Item master: -Query "fast:/sitecore/content/Shared Data/Events//*[@@templateid='$eventTemplateID']" | measure
# No images for jobs...
# Get-Item master: -Query "fast:/sitecore/content/Shared Data/Open Positions//*[@@templateid='$openPositionTemplateID']" | measure


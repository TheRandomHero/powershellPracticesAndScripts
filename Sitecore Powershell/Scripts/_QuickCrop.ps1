Import-Function ImageCropAzure
$linkedItemImage = gi master: -ID "{7B6BE3C5-2BDE-4C8B-A4BA-781EEB839C8C}"

#Get-SmartCroppedImage $linkedItemImage 720 720 "/sitecore/media library/New Corporate Folder/DNA/Discover/Blog/Aerospace defense challenges/"
#Get-SmartCroppedImage $linkedItemImage 720 360 "/sitecore/media library/New Corporate Folder/DNA/Discover/Blog/Aerospace defense challenges/"
Get-SmartCroppedImage $linkedItemImage 1200 630 "/sitecore/media library/New Corporate Folder/DNA/Discover/Blog/Aerospace defense challenges/"
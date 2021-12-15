$toUnpublishPages = @("/sitecore/content/Sites/Corporate/DBE/Home/Solutions/How to connect with your customer",
"/sitecore/content/Sites/Corporate/DBE/Home/Solutions/Customer intelligence",
"/sitecore/content/Sites/Corporate/DBE/Home/Solutions/Customer Strategy Disruption",
"/sitecore/content/Sites/Corporate/DBE/Home/Solutions/Digital Asset Management",
"/sitecore/content/Sites/Corporate/DBE/Home/Solutions/Marketing Automation",
"/sitecore/content/Sites/Corporate/DBE/Home/Solutions/Omnichannel experience",
"/sitecore/content/Sites/Corporate/DBE/Home/Solutions/Product Information Management",
"/sitecore/content/Sites/Corporate/DBE/Home/Solutions/How to connect with your customer");

(Get-Item master: -ID "{B93FACA3-07D5-441F-8BDF-058CA3D1FF4B}")."_Aliases"

#foreach ($path in $toUnpublishPages) {
    #$page =	Get-Item -Path $path -Version * -Language "en*"
	#$page."__Hide version" = 1
	#Publish-Item -Item $page -PublishMode SingleItem
	#$page
	#$page."__Hide version"
#}
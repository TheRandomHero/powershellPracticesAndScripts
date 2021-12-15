$links = @("http://delaware.pro/fr-FR/Solutions/Discover-the-next-gen-ERP",
"http://delaware.pro/fr-FR/Solutions/Advanced-planning",
"http://delaware.pro/fr-FR/Solutions/Field-Services",
"http://delaware.pro/fr-FR/Solutions/Global-trade",
"http://delaware.pro/fr-FR/Solutions/Invoice-management",
"http://delaware.pro/fr-FR/Solutions/Lot-size-one",
"http://delaware.pro/fr-FR/Solutions/Public-cloud",
"http://delaware.pro/fr-FR/Solutions/Smart-Maintenance",
"http://delaware.pro/fr-FR/Solutions/Smart-warehouse",
"http://delaware.pro/fr-FR/Solutions/Strategic-Sourcing",

"http://delaware.pro/fr-FR/Solutions/Trending",
"http://delaware.pro/fr-FR/Solutions/Artificial-Intelligence",
"http://delaware.pro/fr-FR/Solutions/Augmented-reality",
"http://delaware.pro/fr-FR/Solutions/Trending-beacons",
"http://delaware.pro/fr-FR/Solutions/Blockchain-technology",
"http://delaware.pro/fr-FR/Solutions/Chatbots",
"http://delaware.pro/fr-FR/Solutions/Cloud-Computing",
"http://delaware.pro/fr-FR/Solutions/Intelligent-apps",
"http://delaware.pro/fr-FR/Solutions/Internet-of-Things",
"http://delaware.pro/fr-FR/Solutions/Virtual-reality",

"http://delaware.pro/fr-FR/Solutions/How-to-connect-with-your-customer",
"http://delaware.pro/fr-FR/Solutions/Customer-intelligence",
"http://delaware.pro/fr-FR/Solutions/Customer-Strategy-Disruption",
"http://delaware.pro/fr-FR/Solutions/Digital-Asset-Management",
"http://delaware.pro/fr-FR/Solutions/Marketing-Automation",
"http://delaware.pro/fr-FR/Solutions/Omnichannel-experience",
"http://delaware.pro/fr-FR/Solutions/Product-Information-Management",
"http://delaware.pro/fr-FR/Solutions/GDPR-profile-stores",

"http://delaware.pro/fr-FR/Solutions/Future-proof-your-operations",
"http://delaware.pro/fr-FR/Solutions/Application-maintenance",
"http://delaware.pro/fr-FR/Solutions/Change-communication",
"http://delaware.pro/fr-FR/Solutions/Digital-transformation-strategy",
"http://delaware.pro/fr-FR/Solutions/Enterprise-Asset-Management",
"http://delaware.pro/fr-FR/Solutions/Industry%204%200",
"http://delaware.pro/fr-FR/Solutions/Infrastructure-Services",
"http://delaware.pro/fr-FR/Solutions/Master-data-management",
"http://delaware.pro/fr-FR/Solutions/Training-and-end-user-productivity",

"http://delaware.pro/fr-FR/Solutions/Data-and-analytics",
"http://delaware.pro/fr-FR/Solutions/Controlling-and-reporting",
"http://delaware.pro/fr-FR/Solutions/Data-management-and-governance",
"http://delaware.pro/fr-FR/Solutions/Data-science",
"http://delaware.pro/fr-FR/Solutions/Data-driven-organization",
"http://delaware.pro/fr-FR/Solutions/Visual-analytics",

"http://delaware.pro/fr-FR/Solutions/Put-your-employees-first",
"http://delaware.pro/fr-FR/Solutions/IM",
"http://delaware.pro/fr-FR/Solutions/Manage-your-human-capital",
"http://delaware.pro/fr-FR/Solutions/Office-productivity",
"http://delaware.pro/fr-FR/Solutions/Your-digital-workplace",

"http://delaware.pro/fr-FR/Discover/Cases",






"http://delaware.pro/fr-FR/Solutions/Industries",
"http://delaware.pro/fr-FR/Solutions/Automotive",
"http://delaware.pro/fr-FR/Solutions/Harnessing-the-chemistry-of-digital-transformation",
"http://delaware.pro/fr-FR/Solutions/Discrete-manufacturing",
"http://delaware.pro/fr-FR/Solutions/Food",
"http://delaware.pro/fr-FR/Solutions/Engineering-projects",
"http://delaware.pro/fr-FR/Solutions/Professional-Services",
"http://delaware.pro/fr-FR/Solutions/Retail-and-Consumer-Markets",
"http://delaware.pro/fr-FR/Solutions/Textiles",
"http://delaware.pro/fr-FR/Solutions/Utility-Industry")

	
foreach ($link in $links) {
	try {
		$result = Invoke-WebRequest -Uri $link -Method Get
		$result.Content -match "<title>(?<title>.*)</title>" | out-null
		#$link + " | " + $matches['title']
		'<li><a href="' + ($link -replace "http://delaware.pro", "") + '">' + $matches['title'] +'</a></li>'
	}
	catch {
		$_.Exception.Message
	}
}
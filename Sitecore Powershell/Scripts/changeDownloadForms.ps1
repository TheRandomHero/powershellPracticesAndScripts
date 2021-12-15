# Get all items under path, which name begins with Download and is a form
$downloadForms = Get-Item -Path "master://" -Query "/sitecore/content/Sites/Corporate/DBE/Forms//*[(startswith(@@name, 'Download') OR startswith(@@name, 'DOWNLOAD')) AND @@name != 'Downloa
d our whitepaper to learn more about the value drivers of SAP S4HANA' ]"
$consentItemPath = "/sitecore/content/Sites/Corporate/DBE/Forms/Download our whitepaper to learn more about the value drivers of SAP S4HANA/consent"

foreach ($form in $downloadForms) {
	if (Test-Path ($form.Paths.FullPath + "/consent")) {
		"Consent Item already exists, skipping $form.Name"
		continue
	}
	Copy-Item -Path $consentItemPath -DestinationItem $form -Recurse
	"Success copying to " +  $form.Name
}

<#
1. Copy $consent item recursively to all forms beginning with "Download" (don't if it exists)
2. Submit forms for publishing approval
#>
$pageTitles = "M Files",
"SAP on Azure",
"Microsoft Azure",
"Office 365",
"OpenText new",
"SAP Ariba",
"SAP Hybris",
"SAP S4HANA",
"SAP S4HANA Cloud",
"SAP SuccessFactors",
"Information Management"

foreach ($pageTitle in $pageTitles) {
    Get-Item master: -Query "/sitecore/content/Sites/Corporate/DNL/Home/Solutions/$pageTitle//*[not(@@templatename='Page Configuration') and not(@@templatename='Solution Card')]" |
    foreach-object {Add-ItemVersion -Item $_ -Language 'en' -TargetLanguage 'nl'}
}

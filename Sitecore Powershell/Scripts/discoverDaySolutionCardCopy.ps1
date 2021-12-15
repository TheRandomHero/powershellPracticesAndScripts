$pagenames = "SAP S4HANA Cloud",
"SAP Ariba",
"Sap Analytics Cloud",
"Internet of Things",
"Information Management",
"Discrete Manufacturing",
"Blockchain technology",
"Food",
"SAP on Azure",
"Microsoft Azure",
"OpenText new",
"M Files",
"Invoice Management",
"Put your employees first"

$card = Get-Item master: -ID "{79C2BAAF-8439-4086-8A06-949D39D16B80}"

foreach ($name in $pagenames) {
    Get-Item -Path "/sitecore/content/Sites/Corporate/DNL/Home/Solutions/$name"
    $destinationslider = Get-Item master: -Query "/sitecore/content/Sites/Corporate/DNL/Home/Solutions/$name//*[@@templatename='Overview Slider']"
    foreach ($slider in $destinationslider) {
        $destinationslider.fullpath
        #$copiedItem = Copy-Item -Item $card -Destination $destinationslider.fullpath
        #$copiedItem
    }
}
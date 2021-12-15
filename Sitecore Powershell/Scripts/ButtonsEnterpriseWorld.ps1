$buttons = @()
$buttons += Get-Item master: -Query "fast://sitecore/content/Sites/Corporate/*/Home/Solutions/Information Management/Page Configuration//*[@@templatename='Buttons']"
$buttons += Get-Item master: -Query "fast://sitecore/content/Sites/Corporate/*/Home/Solutions/Enterprise Asset Management/Page Configuration//*[@@templatename='Buttons']"
$event = Get-Item -Path "/sitecore/content/Shared Data/Events/Global/2018/Enterprise World"
$readybutton = Get-Item -Path "/sitecore/content/Sites/Corporate/DBE/Home/Solutions/Information management/Page Configuration/New CTA Buttons Config"

foreach ($item in $buttons) {
    $item.Name
    #$item.Fullpath
    #$item.ID
    #$item.'Second Button Text' = 'MEET US AT ENTERPRISE WORLD'
    #$item.BeginEdit();
    #$item.'Second Button Text' = $readybutton.'Second Button Text'
    #$item."Second Button" = $readybutton."Second Button"
    #if ($item."Second Button") {
        [Sitecore.Data.Fields.LinkField]$field = $item.Fields["second button"]
        #$field.TargetID = "{224c1ead-a5b9-43ac-a706-4303b63eabdf}"
        #$item.Fields
    #}
    
    #$item.EndEdit();
    Publish-Item -Item $item -Language 'en' -PublishMode SingleItem
}
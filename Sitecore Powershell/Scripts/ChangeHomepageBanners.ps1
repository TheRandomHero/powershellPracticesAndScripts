#for france
$newImage = Get-Item -Path "/sitecore/content/Sites/Corporate/DBE/Home/Page Configuration/Banner Carousel Config/delaware" -Language 'en-be'
$newButton = Get-Item -Path "/sitecore/content/Sites/Corporate/DBE/Home/Page Configuration/Banner Carousel Config/delaware/Discover Now" -Language 'en-be'
$newImage
$newButton
$newImage.Image
$newImage.Link
$newButton.Link
#Link
Get-Item master: -Query "/sitecore/content/Sites/Corporate/*[not(@@name='DNL') and not(@@name='DBE') and not(@@name='DFR') and not(@@name='DCH')]/Home/Page Configuration/Banner Carousel Config/*[@@templatename='Image Overlay Config']" -Language * | foreach-object {
    Invoke-Workflow -Item $_ -CommandName 'Approve' -Comment 'Automated SUbmit banner and button change'

    #Create new version for the item and modify image
    # $newVersion = Add-ItemVersion $_ -Language $_.language -TargetLanguage $_.language
    # $newVersion
    # $newVersion.Image = $newImage.Image
    
    #Get the country's solution overview page for linking
    # $countrysolutionpath = $_.fullpath -replace 'Page Configuration/.*', 'Solutions'
    # $solutionItem = Get-Item -Path $countrysolutionpath
    
    #Add the link to the non working banner link
    # [Sitecore.Data.Fields.LinkField]$bannerlinkfield = $newVersion.Fields["Link"]
    # $newVersion.BeginEdit()
    # $bannerlinkfield.TargetID = $solutionItem.ID
    # $newVersion.EndEdit()
    
    #get the button item and set the link 
    $childbuttons = Get-Childitem -Item $_ -Language $_.language
    foreach ($button in $childbuttons) {
        Invoke-Workflow -Item $button -CommandName 'Approve' -Comment 'Automated SUbmit banner and button change'
        # if ($button.text.ToLower() -eq "discover now") {
        #     $button.text = "Discover"
        #     $button
        # }
        # $button = Add-ItemVersion $button -Language $_.language -TargetLanguage $_.language
        # $button
        # [Sitecore.Data.Fields.LinkField]$linkfield = $button.Fields["Link"]
        # $button.BeginEdit()
        # $linkfield.TargetID = $solutionItem.ID
        # $button.EndEdit()
    }
} #| Format-Table Name, Children, Language, fullpath
#Add-ItemVersion -Path "/sitecore/content/Sites/Corporate/DBE/Home/Page Configuration/Banner Carousel Config/delaware" -Language "fr-be" -TargetLanguage "fr" -Recurse
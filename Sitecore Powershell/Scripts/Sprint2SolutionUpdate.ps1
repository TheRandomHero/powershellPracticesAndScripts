#DBE, DHU done
$countryNodes = "DBR", "DCH", "DHU", "DFR", "DLU", "DNA", "DNL", "DPH", "DSI", "DUA", "DUK"



#Content page template ID: {4ECEBE47-DE76-4FCE-B133-E1523EA41733} template name:  'Content Page'
#Solution Config template ID: {43105009-77BC-4E6A-8BD4-E5DE70B72F1B} template name: 'Solution Config'
$solutionConfigTemplateID = '{43105009-77BC-4E6A-8BD4-E5DE70B72F1B}'
$solutionConfigTemplate = Get-Item master: -ID $solutionConfigTemplateID


foreach ($node in $countryNodes) {
    # Pay close attention to that double slash after Solutions, that means it searches recursively
    $solutionsQuery = "/sitecore/content/Sites/Corporate/$node/Home/Solutions//*[@@templatename='Content Page']"
    $solutionPages = Get-Item master: -Query $solutionsQuery

    
    foreach ($page in $solutionPages) {
        if ($page.templatename -eq 'Content Page') {
            $page.ChangeTemplate($solutionConfigTemplate);
        }
        
        if ($page.templatename -eq 'Solution Config') {
            $newPage = Get-Item master: -ID $page.ID
            'Success: changed Template to Solution Config on ' + $newPage.fullpath
    
            $horImageSearchQuery = ((Split-Path $page.fullpath) + '\#' + $page.name + "#\Page Configuration\*[@@templatename='Horizontal Image']")  -replace '\\', '/'
            $horImage = @(Get-Item master: -Query $horImageSearchQuery)
            
            $bannerImageSearchQuery = ((Split-Path $page.fullpath) + '\#' + $page.name + '#\Page Configuration\*[@@templatename="Banner Carousel Config"]\*[@@templatename="Image Overlay Config"]')  -replace '\\', '/'
            $bannerImage = @(Get-Item master: -Query $bannerImageSearchQuery)
        
            if ($horImage) {
                $newPage.SolutionImage = $horImage[0].Picture
                'Success: changed SolutionImage to horimage on ' + $newPage.fullpath
            } elseif ($bannerImage) {
                $newPage.SolutionImage = $bannerImage[0].Image
                'Success: changed SolutionImage to bannerimage on ' + $newPage.fullpath
            } else {
                'Warning: ' + $newPage.fullpath + " solution image couldn't be set"
            }
        } else {
            'Warning: ' + $page.fullpath + " template change was unsuccessful"
        }
    }
}

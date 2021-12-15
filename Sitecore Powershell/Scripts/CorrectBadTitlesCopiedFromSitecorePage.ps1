$wrongTitledPages = Get-Item master: -Query "/sitecore/content/Sites/Corporate/*/Home/Solutions/*[@@name='SAP Hybris' or @@name='Tableau' or @@name='Retail and Consumer Markets' or @@name='Episerver' or @@name='SAP Successfactors' or @@name='Aprimo']" -Language @('en*', 'pt*', 'nl*')

foreach ($page in $wrongTitledPages) {
    $query = ((Split-Path $page.fullpath) -replace '\\', '/') + '/#' + $page.name + "#//*[@@templatename='Horizontal Image']"
    $horImage = @(Get-Item master: -Query $query)
    if ($horImage) {
        if ($page.'Page Title' -and $horImage[0].Title -eq $page.'Page Title') {
            ((Split-Path $page.fullpath) -replace '\\', '/') + '/#' + $page.name + '#'
            $page.'Page Title' + " | " + $horImage[0].Title + ' | ' + $page.ID
            #$page.'Page Title' = $horImage[0].Title
            
            #$page.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
            #$page."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
            #Invoke-Workflow -Item $page -CommandName 'Submit' -Comment 'Automated Submit: correcting Sitecore copy Page Title'
        }
    }
}
$copyItems = Get-Item master: -Query "fast://sitecore/content/Sites/Corporate/DBE/Home/Digital/Strategy/Corporate strategy/Page Configuration/*[@@templatename='Horizontal Image' or @@templatename='Buttons']"  | Sort-Object -Property Created
$wheelConfigID = '{4648D4A2-254C-4939-BC84-EA148293FBBB}'

$layoutrendering = Get-Item -Path "master:/sitecore/layout/Layouts/User Defined/Corporate/Corporate Content Page Layout"
$defaultLayout = Get-LayoutDevice "Default"
Get-Item master: -Query "fast://sitecore/content/Sites/Corporate/DBE/Home/Digital/Single Source of Truth/*[@@templatename='Content Page' and @@name!='Corporate Strategy']" | foreach-object {
    $pageconfig = Get-Childitem -Item $_ | Where {$_.templatename -eq 'Page Configuration'}
    
    #CTA Lets connect Discover white
    #Wheel config id {4648D4A2-254C-4939-BC84-EA148293FBBB}
    foreach ($item in $copyItems) {
        $itemRenderingID = switch ($item.templatename) {
            'Buttons' { '{9D3E5FBE-6C4A-4C3A-9871-576BAF1D966C}'}
            'Horizontal Image' { '{9B3AC628-A57F-44FF-9FA9-FC0BAFA959B0}'}
            'Wheel Config' {'{0031397B-2838-4694-84C3-0677BEA06539}'}
            default {''}
        }
        if ($itemRenderingID) {
            $itemRendering = Get-Item master: -ID $itemRenderingID | New-Rendering -Placeholder "row1"
            if ($itemRendering) {
                $newItem = Copy-Item -Path $item.fullpath -Destination $pageconfig.fullpath -PassThru
                if ($newItem) {
                    $indexValue = (Get-Rendering -Item $_ | measure).count
                    Add-Rendering -Item $_ -PlaceHolder "row1" -DataSource $newItem.ID -Rendering $itemRendering -Device (Get-LayoutDevice -Name "default") -Language 'en' -Index $indexValue
                }
                if ($newItem.Name -eq 'CTA Lets talk grey') {
                    $wheelConfigRendering = Get-Item master: -ID '{0031397B-2838-4694-84C3-0677BEA06539}' | New-Rendering -Placeholder "row1"
                    Add-Rendering -Item $_ -PlaceHolder "row1" -DataSource $wheelConfigID -Rendering $wheelConfigRendering -Device (Get-LayoutDevice -Name "default") -Language 'en' -Index ($indexValue+1)
                }
            }
        }
    }
    $_
}
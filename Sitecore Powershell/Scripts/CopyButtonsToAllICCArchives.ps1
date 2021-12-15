$archiveButtons = '/sitecore/content/Sites/Corporate/DBE/Home/ICC/Archive/Page Configuration'
$buttonRenderingID = '{9D3E5FBE-6C4A-4C3A-9871-576BAF1D966C}'
gi master: -Query "/sitecore/content/Sites/Corporate/*[not(@@name='DBE')]/Home/ICC/Archive" -Language *  | Where {-not $_.HasChildren} | foreach-object {
    Copy-Item -Recurse -Path $archiveButtons -Destination $_.fullpath
    $button = Get-Item -Path ($_.fullpath + "/Page Configuration/CTA Buttons Config")
    $ButtonRendering = Get-Item master: -ID $buttonRenderingID | New-Rendering -Placeholder "row1"
    $indexValue = (Get-Rendering -Item $_ | measure).count
    Add-Rendering -Item $_ -PlaceHolder "row1" -DataSource $button.ID -Rendering $ButtonRendering -Device (Get-LayoutDevice -Name "default") -Language 'en' -Index $indexValue
    $_
}

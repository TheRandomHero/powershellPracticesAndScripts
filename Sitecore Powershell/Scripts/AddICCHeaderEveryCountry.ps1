#/sitecore/content/Shared Data/ICC/ICC Header Config {4E4AC0F2-1AD2-48D7-A999-BA61C4392322}
$iccheaderRendering = Get-Item -Path "/sitecore/layout/Renderings/User Defined/Delaware/Corporate/Header/IccHeader"

gi master: -Query "/sitecore/content/Sites/Corporate/*[not(@@name='DBE')]/Home/ICC" -Language * | foreach-object {
    Remove-Rendering -Item $_ -PlaceHolder "header"
    $newRendering = Get-Item master: -ID $iccheaderRendering.ID | New-Rendering -Placeholder "header"
    Add-Rendering -Item $_ -PlaceHolder "header" -DataSource "{4E4AC0F2-1AD2-48D7-A999-BA61C4392322}" -Rendering $newRendering -Device (Get-LayoutDevice -Name "default") -Language $_.Language
    $_
}
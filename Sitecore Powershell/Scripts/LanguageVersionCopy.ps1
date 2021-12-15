$currentLanguage = $SitecoreContextItem.Language
$item = Get-Item -Path "." -language $currentLanguage

$allLanguages = Get-ChildItem "master:\sitecore\system\Languages"
$languagesItem = Get-Item "master:\sitecore\system\Languages"

$options = [ordered]@{}

Get-Item -Path "." -language * | % { $options.Add($_.Language.Title, $_.Language.Name) }

$props = @{
    Parameters = @(
        @{Name="sourceLanguage"; Title="Choose the source language"; Options=$options; Tooltip="Choose one."; Value = $currentLanguage.Title},
        @{Name="targetLanguages"; Title="Choose the target languages"; Source="DataSource=/sitecore/system/languages&DatabaseName=master"; Tooltip="Choose one or more."; Editor = "treelist";}
    )
    Title = "Source language"
    Width = 800
    Height = 800
    ShowHints = $false
}

if ((Read-Variable @props) -like "ok") {
    $sourceLanguage
    $targetLanguages
}
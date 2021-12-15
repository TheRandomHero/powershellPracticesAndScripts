Get-Item master: -Query "fast://sitecore/content/Sites/Corporate/*/Site Configuration/Header Config/Careers" -Language * | foreach-object {
    $countryNode = [regex]::match($_.ItemPath, 'Corporate/(...)/').Groups[1].Value
    $_.Page = (Get-Item -Path "/sitecore/content/Sites/Corporate/$countryNode/Home/Careers")
    $_.Page
    $_
    Publish-Item -Item $_ -PublishMode SingleItem
}
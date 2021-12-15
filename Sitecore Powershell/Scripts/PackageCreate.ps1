$package = New-Package "News images";

gi master: -query "/sitecore/content/Shared Data/discover/News//*[@@templatename='Discover News']" | % {
    if ($_.SmallImage) {
        [Sitecore.Data.Fields.ImageField]$field = $_.Fields["SmallImage"];
        $image = gi master: -id $field.mediaid | New-ItemSource -Name $image.Name -InstallMode Overwrite
        $package.Sources.Add($image)
    }
}

Export-Package -Project $package -Path "$($package.Name)-$($package.Metadata.Version).zip" -Zip
Download-File "$SitecorePackageFolder\$($package.Name)-$($package.Metadata.Version).zip"

$mediaLibraryFolder = '/sitecore/media library/New Corporate Folder/DBR/Events/2018/SAP Forum 2018 Sao Paulo/Gallery'
$galleryConfigBase = '/sitecore/content/Shared Data/Events/Brazil/2018/SAP Forum 2018 Sao Paulo/Page Configuration/Gallery'
$count = 1;
Get-ChildItem $mediaLibraryFolder | foreach-object {
    $newPhotoPath = $galleryConfigBase + '/Photo ' + $count
    $newPhoto = New-Item -Path $newPhotoPath -ItemType '/sitecore/templates/User Defined/Corporate/Components/Gallery/Photo';
    $count++;
    $newPhoto.Image = $_
}


$mediaLibraryFolder = '/sitecore/media library/New Corporate Folder/DBE/Careers/Blog/2020/Thailand gallery'
$galleryConfigBase = '/sitecore/content/Shared Data/careers blog/2020/Belgium/Thailand blog placeholder/Gallery Config'
$count = 1;
Get-ChildItem $mediaLibraryFolder | foreach-object {
    $newPhotoPath = $galleryConfigBase + '/' + $_.Name
    $newPhoto = New-Item -Path $newPhotoPath -ItemType '/sitecore/templates/User Defined/Corporate/Components/Gallery/Photo';
    $count++;
    $newPhoto.Image = $_
}
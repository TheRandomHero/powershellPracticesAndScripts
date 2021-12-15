Get-ChildItem -Path "/sitecore/media library/New Corporate Folder/DBE/Events/2018/Pikes Peak/Gallery" | foreach-object {
    [system.io.stream]$filestream = $_.Fields["blob"].GetBlobStream()
    $imagefile = New-Object System.Drawing.Bitmap $filestream
    if (-not $_.Width) {
        $_.Width = $imagefile.Width
    }
    if (-not $_.Height) {
        $_.Height = $imagefile.Height
    }
}

Get-ChildItem | foreach-object {
    [system.io.stream]$filestream = $_.Fields["blob"].GetBlobStream()
    $imagefile = New-Object System.Drawing.Bitmap $filestream
    if (-not $_.Width) {
        $_.Width = $imagefile.Width
    }
    if (-not $_.Height) {
        $_.Height = $imagefile.Height
    }
}
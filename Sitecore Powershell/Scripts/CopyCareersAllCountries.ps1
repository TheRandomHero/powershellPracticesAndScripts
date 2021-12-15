Get-Item master: -Query "/sitecore/content/Sites/Corporate/*/Home/" | foreach-object {
    if (-not ($_.ItemPath -like "*DHU*") -and (-not ($_.ItemPath -like "*DBE*")) -and (-not (Test-Path -Path ($_.Itempath + "/Careers")))) {
        $new = Copy-Item -Path "/sitecore/content/Sites/Corporate/DHU/Home/Careers" -Destination $_.Itempath -Recurse -PassThru
        $new
    }
} | Format-Table Name, ID, ItemPath
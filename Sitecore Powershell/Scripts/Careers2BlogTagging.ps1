$media = Get-Item -Path "/sitecore/media library/New Corporate Folder/DBE/Careers/careers blog tagging v2"
[system.io.stream]$body = $media.Fields["blob"].GetBlobStream()

try {
    $contents = New-Object byte[] $body.Length
    $body.Read($contents, 0, $body.Length) | Out-Null
} finally {
    $body.Close()    
}

$csv = [System.Text.Encoding]::Default.GetString($contents) | ConvertFrom-Csv -Delimiter ';'

foreach ($row in $csv) {
    $id = $row."ID"
    $row
    $blogItem = $null
    $blogItem = gi master: -ID $id
    
    
    
    if (-not $blogItem) {
        $name
        continue
    } else {$name, $blogItem }
    ($row | Select-Object -Property * -ExcludeProperty "*name*").PSObject.Properties | % {
        if ($_.Value -like "x") {
            $tagname = $_.Name.ToLower()
            $tagItem = gi master: -query ("/sitecore/content/Shared Configuration/Carrers Config/Job tags/*/*[@@key='" + $tagname + "']")
            #$blogItem.($tagItem.parent.name) = ""
            $blogItem.($tagItem.parent.name) += ([string]$tagitem.ID + "|")
        }
    }
    $blogItem
}

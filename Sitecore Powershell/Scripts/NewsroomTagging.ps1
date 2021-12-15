$media = Get-Item -Path "/sitecore/media library/New Corporate Folder/Tagging/Newsroom categorize 20191030"
[system.io.stream]$body = $media.Fields["blob"].GetBlobStream()

try {
    $contents = New-Object byte[] $body.Length
    $body.Read($contents, 0, $body.Length) | Out-Null
} finally {
    $body.Close()    
}
$csv = [System.Text.Encoding]::Default.GetString($contents) | ConvertFrom-Csv -Delimiter ';'


foreach ($row in $csv) {
    $newsItem = gi master: -ID $row.'ID'
    $tag = $row.'Type' -replace 'Article', 'News'
    $tagItem = gi -path "/sitecore/content/Shared Data/Solutions/Solution tags/NewsType/$tag"
    if ((-not ($tag -like "News")) -and ($tag) -and ($tagItem)) {
        $newsItem.NewsType = $tagitem.ID
        $newsItem
    }
}

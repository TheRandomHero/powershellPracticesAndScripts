$media = Get-Item -Path "/sitecore/media library/New Corporate Folder/DBE/Events/2020/Unlocking the potential of Microsoft Power Platform/power platform sessions"
[system.io.stream]$body = $media.Fields["blob"].GetBlobStream()
$basepath = "/sitecore/content/Shared Data/Events/Belgium/2020/Unlocking the potential of Microsoft Power Platform/Agenda/Day 1/1700"

try {
    $contents = New-Object byte[] $body.Length
    $body.Read($contents, 0, $body.Length) | Out-Null
} finally {
    $body.Close()    
}

$csv = [System.Text.Encoding]::Default.GetString($contents) | ConvertFrom-Csv -Delimiter ';'
$count = 1
foreach ($row in $csv) {
    $row
    $newprespath = $basepath + '/Session ' + $count
    $newpres = New-Item -Path $newprespath -ItemType '/sitecore/templates/User Defined/Corporate/Components/Events/Detail/Presentation';
    $newpres.Title = $row.Date + '<br /><span style="font-weight: normal">' + $row.Title + '</span>'
    $newpres.Summary = $row.Description
    $count++
}
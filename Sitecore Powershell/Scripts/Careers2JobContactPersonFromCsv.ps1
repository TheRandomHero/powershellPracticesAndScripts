$media = Get-Item -Path "/sitecore/media library/New Corporate Folder/DBE/Careers/job recruiters"
[system.io.stream]$body = $media.Fields["blob"].GetBlobStream()

try {
    $contents = New-Object byte[] $body.Length
    $body.Read($contents, 0, $body.Length) | Out-Null
} finally {
    $body.Close()    
}

$csv = [System.Text.Encoding]::Default.GetString($contents) | ConvertFrom-Csv -Delimiter ';'

foreach ($row in $csv) {
    $name = ($row."vacature").ToLower()
    $jobItem = gi master: -query ("fast://sitecore/content/Shared Data/Open Positions/Belgium/*") | Where { $_."Content Title" -like "*$name*"}
    $recruiterItem = gi master: -query ("fast://sitecore/content/Shared Configuration/Carrers Config/Job Contact Person Folder/*") | Where { $_."Contact Person Name" -like $row."Recruiter"}
    
    if ($row."Recruiter") {
        foreach ($job in $jobItem) {
            if ($job -and $recruiterItem) {
                $job."Contact Person" = $recruiterItem
                $job."Contact Person" 
            }
        }
    }
}


$media = Get-Item -Path "/sitecore/media library/New Corporate Folder/DBE/Careers/job recruiters v2"
[system.io.stream]$body = $media.Fields["blob"].GetBlobStream()

try {
    $contents = New-Object byte[] $body.Length
    $body.Read($contents, 0, $body.Length) | Out-Null
} finally {
    $body.Close()    
}

$csv = [System.Text.Encoding]::Default.GetString($contents) | ConvertFrom-Csv -Delimiter ';'

foreach ($row in $csv) {
    $name = (Split-Path -Leaf $row."vacature") -replace "-", " "
    $recruiter = $row."Recruiter"
    
    $jobItem = gi master: -query ("fast://sitecore/content/Shared Data/Open Positions/Belgium/*[@@name='$name']") -language *
    $recruiterItem = gi master: -query ("fast://sitecore/content/Shared Configuration/Carrers Config/Job Contact Person Folder/*[@@name='$recruiter']") 
    if ($jobItem -and $recruiterItem) {
        if ($row."Recruiter" -and ($row."displayrecruiter" -like "yes")) {
            foreach ($job in $jobItem) {
                    $job."Contact Person" = $recruiterItem
                    $job
                    $job."Contact Person" 
                    
            }
        } else {
            $job."Contact Person" = ""
        }
    }
}
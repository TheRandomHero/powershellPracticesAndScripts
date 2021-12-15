Get-Item master: -Query "fast://sitecore/content/Shared Data/Open Positions//*[@@templatename='Job']" | foreach-object {
    $PrimaryJobDomainID = $_.JobDomains -split "\|"
    if($PrimaryJobDomainID) {
        $_.PrimaryJobDomain = $PrimaryJobDomainID[0]
    }
    $_
    $TargetGroupID = switch ($_.TargetGroup) {
        'Intern' { '{42209D41-CEB0-433F-B421-4BE767B83092}'}
        'Starter' { '{EE6DFB95-8C47-4F51-A0AE-E1F769D37C57}'}
        'Experienced' {'{7249A881-B3E5-438F-8821-711770E1D939}'}
        default {''}
    }
    if ($TargetGroupID) {
        $_.TargetGroup = $TargetGroupID
    }
    $_
} 
#Format-Table Name, Id, TargetGroup, PrimaryJobDomain

Get-Item master: -Query "fast://sitecore/content/Shared Data/Open Positions//*[@@templatename='Job']" | Format-Table Name, Id, TargetGroup, PrimaryJobDomain


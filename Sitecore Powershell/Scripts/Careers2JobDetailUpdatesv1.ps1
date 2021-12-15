gci "/sitecore/content/Shared Data/Open Positions/Belgium" | % {
    $_."Contact Person" = "{32A8B82C-6CE6-4A84-8E60-3F64D493AF63}"
    $_."Related Content" = "{EBD6A57D-47CC-4D9C-9FD5-DBCD3720A03B}|{853F072E-169F-49CC-A25D-9DA4EE6F822B}"
    $_."Intro Image" = (gi -path ("/sitecore/media library/New Corporate Folder/DBE/People of delaware/HR collage " + (Get-Random -Minimum 1 -Maximum 5)))
    $_."Intro Description" = $_."Description"
    $_."Ask a question link" = (gi -path "/sitecore/content/Sites/Corporate/DBE/Home/Contact")
    [Sitecore.Data.Fields.LinkField]$link = $_.Fields["Ask a question link"]
    $_.BeginEdit();
    $link.Text = "ask a question"
    $_.EndEdit();
}

# V2
gci "/sitecore/content/Shared Data/Open Positions/Belgium" -language * | % {
    $new = Add-ItemVersion -Item $_ -Language $_.Language -TargetLanguage $_.Language
    $new
    $new."Job Detailed Description" = $new."Job Detailed Description" -replace "color: #595959;", ""
    if ($new."CTA Detail Description") {
        $new."CTA Detail Description" = $new."CTA Detail Description" -replace "color: #ffffff;", ""
        $new."Job Detailed Description" = ($new."Job Detailed Description" + "`n" + $new."CTA Detail Description")
        $new."CTA Detail Description" = ""
    }
    
    $new."Contact Person" = "{32A8B82C-6CE6-4A84-8E60-3F64D493AF63}"
    $new."Related Content" = "{EBD6A57D-47CC-4D9C-9FD5-DBCD3720A03B}|{853F072E-169F-49CC-A25D-9DA4EE6F822B}"
    $new."Intro Image" = (gi master: -ID $new.PrimaryJobDomain -language "en-be").smallimage

    $new."Ask a question link" = (gi -path "/sitecore/content/Sites/Corporate/DBE/Home/Contact")
    [Sitecore.Data.Fields.LinkField]$link = $new.Fields["Ask a question link"]
    $new.BeginEdit();
    $link.Text = "ask a question"
    $new.EndEdit();
    
}
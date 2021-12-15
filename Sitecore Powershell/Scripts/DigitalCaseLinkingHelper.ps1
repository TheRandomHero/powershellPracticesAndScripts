gi master: -query "/sitecore/content/Sites/Corporate/DBE/Home/Digital/Technology/*/Page Configuration/*[@@templatename='Horizontal Image']" | Where { 
    -not $_."Picture Link" -and
    $_.Name -like "*case*" -and
    $_.Picture -ne '<image mediaid="{454468D7-93A4-4B0A-A4D1-7FCF36AE3AD8}" />' -and
    -not ($_."Text below title" -like "*netafim*") -and
    -not ($_."Text below title" -like "*unilin*") -and
    -not ($_."Text below title" -like "*stage entertainment*") -and
    -not ($_."Text below title" -like "*cera*") -and
    -not ($_."Text below title" -like "*LAMB WESTON MEIJER*") -and
    -not ($_."Text below title" -like "*De Watergroep*") -and
    -not ($_."Text below title" -like "*Bayer*") -and
    -not ($_."Text below title" -like "*Samsonite*") -and
    -not ($_."Text below title" -like "*athlon*") 
} | foreach-object {
    #Add-Itemversion -Item $_ -Language 'en'
    $_
}

gi master: -query "/sitecore/content/Sites/Corporate/DBE/Home/Digital/Services/*/*/Page Configuration/*[@@templatename='Horizontal Image']" | Where { 
    #-not $_."Picture Link" -and
    $_.Name -like "*case*" -and
    $_.Picture -ne '<image mediaid="{454468D7-93A4-4B0A-A4D1-7FCF36AE3AD8}" />' -and
    -not ($_."Text below title" -like "*netafim*") -and
    -not ($_."Text below title" -like "*unilin*") -and
    -not ($_."Text below title" -like "*stage entertainment*") -and
    -not ($_."Text below title" -like "*cera*") -and
    -not ($_."Text below title" -like "*LAMB WESTON MEIJER*") -and
    -not ($_."Text below title" -like "*De Watergroep*") -and
    -not ($_."Text below title" -like "*Bayer*") -and
    -not ($_."Text below title" -like "*Samsonite*") -and
    -not ($_."Text below title" -like "*athlon*") -and 
    -not ($_."Text below title" -like "*STIHL*") -and
    -not ($_."Text below title" -like "*Game mania*") -and
    -not ($_."Text below title" -like "*WIENERBERGER*") -and
    -not ($_."Text below title" -like "*Esas*") -and
    -not ($_."Text below title" -like "*Eandis*")
} | foreach-object {
    $_
    # $new = Add-ItemVersion -Item $_ -Language $_.language
    # $new."Picture Link" = (Get-Item -Path "/sitecore/content/Sites/Corporate/DBE/Home/Digital/Cases/Eandis")
    # Invoke-Workflow -Item $new -CommandName Submit
    # Invoke-Workflow -Item $new -CommandName Approve
    # Publish-Item -Item $new -PublishMode SingleItem
    # $new
}
$countryNodes = "DBE",
"DBR",
"DCH",
"DFR",
"DHU",
"DLU",
"DNA",
"DNL",
"DPH",
"DSI",
"DUA",
"DUK"

foreach ($countryNode in $countryNodes) {
    $videos = Get-ChildItem -Path "/sitecore/content/Sites/Corporate/$countryNode/Home/People of Delaware/Page Configuration/Banner Carousel Config"
    foreach ($video in $videos) {
        if ($video."Video URL" -like "https://youtu.be/jbef9DKleWM") {
            #$video."Video URL" = "https://youtu.be/jbef9DKleWM"
            $video.Fullpath
            $video.__Workflow = "{3162F28D-EB11-4209-8275-27439FB72F7A}"
            $video."__Workflow state" = "{3AB79688-C34F-4454-B3EC-056AC3F56C8D}"
            Invoke-Workflow -Item $video -CommandName "Submit" -Comments "Changed video url"
            $video."__Workflow state"
        }
    }
}
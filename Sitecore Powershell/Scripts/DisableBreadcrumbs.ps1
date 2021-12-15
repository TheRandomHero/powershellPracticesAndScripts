$countryNodes = "DBR", "DCH", "DFR", "DHU", "DLU", "DNA", "DNL", "DPH", "DSI", "DUA", "DUK"

$pagePaths = "/Home/Discover/Most Recent Page",
"/Home/Discover/Most Relevant Page",
"/Home/Discover/News",
"/Home/Discover/Blog"
#"/Home/About Us",
#"/Home/Discover our Jobs",
#"/Home/Discover our Jobs/*",
#"/Home/Discover our Jobs/JobIframeForm",
#"/Home/Discover our Jobs/JobForm",
#"/Home/Discover",
#"/Home/Discover/Cases",


foreach ($node in $countryNodes) {
    foreach ($partialPagePath in $pagePaths) {
        $completePagePath = '/sitecore/content/Sites/Corporate/' + $node + $partialPagePath
        $page = Get-Item -Path $completePagePath
        # if ($page."Has Breadcrumb" -eq 1) {
        #     $page."Has Breadcrumb" = 0
        #     $page.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
        #     $page."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
        #     Invoke-Workflow -Item $page -CommandName 'Submit' -Comment 'Automated breadcrumb disabling'
        #     $page.fullpath
        # }
        # if ($page."Has Breadcrumb" -eq 0) {
        #     Invoke-Workflow -Item $page -CommandName 'Approve' -Comment 'Automatically disabled breadcrumbs'
        #     $page.fullpath
        # }
        if ($page."Page Title" -eq "") {
            $page."Page Title" = $page.name -replace " Page", ""
            Invoke-Workflow -Item $page -CommandName 'Approve' -Comment 'Automatically disabled breadcrumbs, and added Page Title to meet validation requirements'
            $page.fullpath
        }
    }
}

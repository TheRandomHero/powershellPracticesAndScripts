 $casesForBrazil = Get-ChildItem -Path "/sitecore/content/Shared Data/discover/Cases/Belgium" | Where {$_."Permit Countries" -like "*{1C01684F-13A2-4400-B288-0F37CA26BCDF}*"}
 foreach ($case in $casesForBrazil) {
     Add-ItemVersion -Item $case-Language "en" -TargetLanguage "pt" -Recurse
}
Get-ChildItem -Path "/sitecore/content/Shared Data/discover/Cases/Belgium" -Language 'pt' -Recurse |
foreach-object { 
    $_.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
    $_."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
    Invoke-Workflow -Item $_ -CommandName 'Approve' -Comment 'Automatically created PT version'
}

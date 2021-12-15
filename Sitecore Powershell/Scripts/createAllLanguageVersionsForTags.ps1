$tagCategories = @('Industry', 'Technology', 'Business', 'Trending')

$languages = "en-ae", "en-be", "en-br", "en-cn", "en-fr", "en-hu", "en-lu", "en-nl", "en-ph", "en-sg", "en-us", "en-gb", "fr", "fr-fr", "fr-be", "fr-lu", "nl-be", "nl-lu", "nl-nl", "nl", "pt-br", "zh-cn", "hu-hu", "hu", "pt", "zh", "en-my"

foreach ($tagCategory in $tagCategories) {
    $tagItems = Get-ChildItem -Path "/sitecore/content/Shared Data/Solutions/Solution tags/$tagCategory/"
    
    foreach ($tag in $tagItems) {
        foreach ($lang in $languages) {
            Add-ItemVersion -Item $tag -Language 'en' -TargetLanguage $lang -IfExist Skip
        }
        $tag
    }
}
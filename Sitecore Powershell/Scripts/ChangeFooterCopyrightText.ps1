gi master: -Query "/sitecore/content/Sites/Corporate/*/Site Configuration/Footer Config" -language * | Where { -not ($_.ItemPath -like "*DBE*")} |% {
   $_."Copyright Text" = $_."Copyright Text" + ' </div><div class="right-separator mobile-separator disclaimer"> <a href="/en-be/About-Us/Responsible-disclosure">Responsible Disclosure</a>'
   Publish-Item -Item $_ -PublishMode Smart
}
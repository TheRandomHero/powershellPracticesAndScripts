#  gci -Path "web:/sitecore/content/Shared Data/Open Positions/Belgium" | foreach-object { 
#      $item = gi master: -ID $_.ID -language 'fr-be'
#      $_
#      $item
#      Publish-Item -Item $item -Language 'fr-be' -PublishMode Smart
#     $new = Add-ItemVersion -Item $item -Language 'en' -TargetLanguage 'fr-be'
#     $_
#     $new
#  }
gci -Path "web:/sitecore/content/Shared Data/Open Positions/Belgium" -language 'fr-be'
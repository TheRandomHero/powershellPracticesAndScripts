gi -path "./" | foreach-object { $_."__Enable item fallback" = 0}
gi -path "./" | Add-ItemVersion -Language 'en' -IfExist Skip -TargetLanguage @("en-be", "en-cn", "en-hu", "en-lu", "en-my", "en-nl", "en-sg", "en-gb", "en-us")
gi -path "./" | Add-ItemVersion -Language 'zh' -IfExist Skip -TargetLanguage 'zh-cn'
gi -path "./" | Add-ItemVersion -Language 'nl' -IfExist Skip -TargetLanguage 'nl-nl'
gi -path "./" | Add-ItemVersion -Language 'fr' -IfExist Skip -TargetLanguage 'fr-fr'

gi -path "./" | foreach-object { $_."__Enable item fallback" = 0}
gi -path "./" | Add-ItemVersion -Language 'en' -IfExist Skip -TargetLanguage @("en-be", "en-cn", "en-hu", "en-lu", "en-my", "en-nl", "en-sg", "en-gb", "en-us")
gi -path "./" | Add-ItemVersion -Language 'zh' -IfExist Skip -TargetLanguage 'zh-cn'
gi -path "./" | Add-ItemVersion -Language 'nl' -IfExist Skip -TargetLanguage 'nl-nl'
gi -path "./" | foreach-object { $_."__Enable item fallback" = 1}

gi -path "./" -language 'en' | foreach-object { $_."__Enable item fallback" = 0; $_."__Hide version" = 1;}
gi -path "./" | Remove-ItemVersion -Language 'en'

gi -path "./" -language 'fr' | foreach-object { $_."__Enable item fallback" = 0; $_."__Hide version" = 1;}
gi -path "./" | Add-ItemVersion -Language 'fr' -IfExist Skip -TargetLanguage 'fr-be'

gi -path "./" | foreach-object { $_."__Enable item fallback" = 0}
gi -path "./" | Add-ItemVersion -Language 'en' -IfExist Skip -TargetLanguage @("en-be")
gi -path "./" | foreach-object { $_."__Enable item fallback" = 1}
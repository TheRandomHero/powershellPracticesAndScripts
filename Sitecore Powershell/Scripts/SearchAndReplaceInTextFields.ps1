$path = "/sitecore/content/Sites/Corporate/DNL/Home/Solutions/SAP Hybris"
$item = gi -path $path -language *
$children = gci -path $path -recurse -language *
$items = @($item) + @($children)

foreach($item in $items){
    $newItem = Add-ItemVersion -Item $item -Language $item.language
    $item
    foreach($field in $newItem.Fields){
        if(($field.Type -like "Single-Line Text") -or ($field.Type -like "Rich Text") -or ($field.Type -like "Multi-Line Text")){
            $newItem.BeginEdit()
            $field.Value = ($field.Value) -replace "Hybris", "C/4HANA"
            $newItem.EndEdit()    
        }
    }
}
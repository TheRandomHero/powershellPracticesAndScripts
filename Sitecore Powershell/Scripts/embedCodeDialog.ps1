$embedCode = Show-Input 'embed code pls'
if ($embedCode) {
    Get-Item master: -ID "{232DCDB8-6F43-458F-9DA8-3CB20C1EFF7F}" | foreach-object { $_.Content = $embedCode}
}
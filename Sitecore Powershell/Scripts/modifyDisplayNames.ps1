Get-Item master: -Query "/sitecore/content/Shared Data/Solutions/Solution tags
/*/*" -Language @('fr-be', 'fr-lu') | foreach-object {$_."__Display Name" = (Get-Item master: -Id $_.ID -Language 'fr-fr').'DisplayNa
me';}
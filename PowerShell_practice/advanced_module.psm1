function Write-M() {
    Write-Host 'M'
}



#PSScriptRoot is a shortcut to "the current folder where the script is being run from" 
# " . " run the file on given path 
. $PSScriptRoot\module.ps1


#You can tell which module to export, this makes able to have private functions

Export-ModuleMember Write-A
Export-ModuleMember Write-B


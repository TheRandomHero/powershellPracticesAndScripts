#It is possible to pipeline enable your functions
#These are referred to as advanced functions
function Get-PSFiles ()
{
    begin { $retval = 'Here are some PowerShell Files:`r`n' }

    #The process block is executed once for each object being
    #passed in from the pipe
    process {
                if($_.Name -like "*.ps1")
                {
                  $retval += "`t$($_.Name)`r`n"
                  #Note this line could also be rendered as
                  $retval= $retval + "`t" + $_.Name + "`r`n"
                  #`t     Tab Character
                  #`r     Carriage return
                  #`n     Line Feed
                  #$()    Tells PS to evaluate the expression in () first then return it
                  #$_     The Current object being passed in the pipeline
                  #.Name  The name property of the current object
                }

            }
    end { return $retval }
}

#Advanced functions also allow parameters with extra helping hint
function Multiply ()
{
    [CmdletBinding()] # Needed to indicate this as an advanced function
    param ( # Begin the parameter block
            [Parameter( Mandatory = $true,
                        HelpMessage = 'Please enter value one.'
                        )]
            [int] $firstParam,
            # Note in the second we are strongly typing, and are providing a default value
            [Parameter( Mandatory = $false,
                        HelpMessage = 'Please enter value two.'
                        )]
            [int] $secondParam = 42
            ) #End of parameter block
    begin {}

    process {
            $result = $firstParam * $secondParam
            }
    end { return $result }
}

#Handle errors using try/catch/finally
function divver($enum,$denom)
{
  Write-Host "Divver begin."

  try
  {
    $result = $enum / $denom
    Write-Host "Result: $result"
  }
  catch
  {
    Write-Host "Oh NO! An error has occured!!"
    write-host $_.ErrorID
    write-host $_.Exception.Message
    break #With break, or omitting it, error bubbles up to parent
  }
  finally
  {
    Write-Host "Divver done."
  }
}
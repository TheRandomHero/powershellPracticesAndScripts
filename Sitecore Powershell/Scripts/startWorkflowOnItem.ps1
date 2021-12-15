#Publishing workflow ID: {3162F28D-EB11-4209-8275-27439FB72F7A}
#Draft workflow _: {3AB79688-C34F-4454-B3EC-056AC3F56C8D}
#Awaiting approval workflow _: {7EDA1725-A893-416E-AEBC-34635775A776}
#APproved: {7BE7EC98-54B4-4618-AE0D-4EC6DAC5D11B}

# Instant Awaiting approve
$_.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
$_."__Workflow state" = '{7EDA1725-A893-416E-AEBC-34635775A776}'
Invoke-Workflow -Item $_ -CommandName 'Approve' -Comment 'Automated Approve'


$_.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
$_."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
Invoke-Workflow -Item $_ -CommandName 'Submit' -Comment 'Automated Submit'

Invoke-Workflow -Item $_ -CommandName 'Approve' -Comment 'Automated Approve'

$item.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
$item."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
Invoke-Workflow -Item $item -CommandName 'Submit' -Comment 'Automated Submit'

Invoke-Workflow -Item $item -CommandName 'Approve' -Comment 'Automated Approve'


$page.__Workflow = '{3162F28D-EB11-4209-8275-27439FB72F7A}'
$page."__Workflow state" = '{3AB79688-C34F-4454-B3EC-056AC3F56C8D}'
Invoke-Workflow -Item $page -CommandName 'Submit' -Comment 'Automated Submit'

Invoke-Workflow -Item $item -CommandName 'Approve' -Comment 'Automated Approve'
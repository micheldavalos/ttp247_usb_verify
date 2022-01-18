Add-Type -AssemblyName @('UIAutomationClient', 'UIAutomationTypes')

$calc = [Diagnostics.Process]::Start('calc')
#wait for the UI to appear
$null = $calc.WaitForInputIdle(5000)
sleep -s 2
$calcWindowId = ((Get-Process).where{$_.MainWindowTitle -eq 'Calculadora'})[0].Id
$root = [Windows.Automation.AutomationElement]::RootElement
$condition = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::ProcessIdProperty, $calcWindowId)
$calcUI = $root.FindFirst([Windows.Automation.TreeScope]::Children, $condition)

function FindAndClickButton($name){
	$condition1 = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::ClassNameProperty, "Button")
    Write-Output $condition1
	$condition2 = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::NameProperty, $name)
    Write-Output $condition2
	$condition = New-Object Windows.Automation.AndCondition($condition1, $condition2)
    Write-Output $condition
	$button = $calcUI.FindFirst([Windows.Automation.TreeScope]::Descendants, $condition)
	$button.GetCurrentPattern([Windows.Automation.InvokePattern]::Pattern).Invoke()
}

#get and click the buttons for the calculation

FindAndClickButton Cinco
sleep -s 2
FindAndClickButton "Mas"
sleep -s 2
FindAndClickButton Nueve
sleep -s 2
FindAndClickButton 'Es igual a'

#get the result
$condition = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::AutomationIdProperty, "CalculatorResults")
$result = $calcUI.FindFirst([Windows.Automation.TreeScope]::Descendants, $condition)
$result.current.name

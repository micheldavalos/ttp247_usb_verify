Add-Type -AssemblyName @('UIAutomationClient', 'UIAutomationTypes')

$app = [Diagnostics.Process]::Start('C:\Program Files (x86)\USB Server 2\USB Server.exe')
#wait for the UI to appear
$null = $app.WaitForInputIdle(5000)
sleep -s 2
$id = ((Get-Process).where{$_.MainWindowTitle -eq 'USB Server'})[0].Id
$root = [Windows.Automation.AutomationElement]::RootElement
$condition = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::ProcessIdProperty, $id)
$appUI = $root.FindFirst([Windows.Automation.TreeScope]::Children, $condition)

$condition1 = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::ClassNameProperty, "MFCReportCtrl")
Write-Output $condition1
$condition2 = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::NameProperty, '')
Write-Output $condition2
$condition = New-Object Windows.Automation.AndCondition($condition1, $condition2)
Write-Output $condition
$panel = $appUI.FindFirst([Windows.Automation.TreeScope]::Descendants, $condition)
$elements = $panel.FindAll()
Write-Output $panel
# $button.GetCurrentPattern([Windows.Automation.InvokePattern]::Pattern).Invoke()
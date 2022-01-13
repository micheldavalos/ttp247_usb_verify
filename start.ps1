Add-Type -AssemblyName PresentationCore,PresentationFramework

$_proccess = Get-Process | Where-Object {$_.MainWindowTitle -eq "USB Server"}
if ($_proccess.MainWindowTitle -eq "USB Server") {
    # Start-Process -FilePath "$env:USERPROFILE\Desktop\32bits\ticket_a.exe"
    # Start-Sleep -s 5
    # Start-Process -FilePath "$env:USERPROFILE\Desktop\32bits\ticket_b.exe"
    # Start-Sleep -s 5
    # Start-Process -FilePath "$env:USERPROFILE\Desktop\32bits\ticket_c.exe"

    $count = (Get-CimInstance -ClassName Win32_Printer -Filter 'DriverName LIKE "TSC%"').Count
    if ($count -gt 3) {
        [System.Windows.MessageBox]::Show('Hay mas de 3 impresoras instaladas', 'Error')
        exit
    } elseif ($count -lt 3) {
        [System.Windows.MessageBox]::Show('Hay menos de 3 impresoras instaladas', 'Error')
        exit
    }
    $printers = Get-CimInstance -ClassName Win32_Printer -Filter 'DriverName LIKE "TSC%"' | Select-Object -Property Name, PortName
    
    $names = @('Robot_1', 'Robot_2', 'Robot_3') 
    # $printers = @('TSC TTP-247', 'TSC TTP-247 (Copiar 1)', 'TSC TTP-247 (Copiar 2)') 
    [bool] $check = 0
    foreach ($printer in $printers)
    {
        if ($printer.Name -in $names) {
            Write-Output $printer.PortName
        } else {
            $check = 1
        }
    }
    
    if ($check) {
        [System.Windows.MessageBox]::Show('Los nombres de las impresoras no coinciden', 'Error')
        exit
    }
}else {
    [System.Windows.MessageBox]::Show('Arranca USB Server', 'Error')
}
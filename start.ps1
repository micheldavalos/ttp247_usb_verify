Add-Type -AssemblyName PresentationCore,PresentationFramework

# Verify if USB Server is running 
function USBServerRunning {
    $_proccess = Get-Process | Where-Object {$_.MainWindowTitle -eq "USB Server"}
    if ($_proccess.MainWindowTitle -eq "USB Server") {
        return [bool] 1
    } 

    return [bool] 0
}

if (USBServerRunning) {
    Write-Information -MessageData 'USB Server is Running' -InformationAction 'Continue'
    Start-Process -FilePath "$env:USERPROFILE\Desktop\32bits\ticket_a.exe"
    Start-Sleep -s 5
    Start-Process -FilePath "$env:USERPROFILE\Desktop\32bits\ticket_b.exe"
    Start-Sleep -s 5
    Start-Process -FilePath "$env:USERPROFILE\Desktop\32bits\ticket_c.exe"

    # $count = (Get-CimInstance -ClassName Win32_Printer -Filter 'DriverName LIKE "TSC%"').Count
    # if ($count -gt 3) {
    #     [System.Windows.MessageBox]::Show('Hay mas de 3 impresoras instaladas', 'Error')
    #     exit
    # } elseif ($count -lt 3) {
    #     [System.Windows.MessageBox]::Show('Hay menos de 3 impresoras instaladas', 'Error')
    #     exit
    # }
    # $printers = Get-CimInstance -ClassName Win32_Printer -Filter 'DriverName LIKE "TSC%"' | Select-Object -Property Name, PortName
    
    # $printersNames = @('Robot_1', 'Robot_2', 'Robot_3') 
    # $usbPortsNames = New-Object System.Collections.Generic.List[System.Object]
    # # $printers = @('TSC TTP-247', 'TSC TTP-247 (Copiar 1)', 'TSC TTP-247 (Copiar 2)') 
    # [bool] $check = 0
    # foreach ($printer in $printers)
    # {
    #     if ($printer.Name -in $printersNames) {
    #         # Write-Output $printer.PortName
    #         $usbPortsNames.Add($printer.PortName)
    #     } else {
    #         $check = 1
    #     }
    # }
    
    # if ($check) {
    #     [System.Windows.MessageBox]::Show('Los nombres de las impresoras no coinciden', 'Error')
    #     exit
    # }
    # # Obtiene todos las impresoras conectadas por USB
    # $printersConnected =  Get-WmiObject Win32_PnPEntity -Filter "DeviceID LIKE 'USBPRINT%'"
    # # Crea una lista para guardar los deviceID de cada impresora
    # $deviceIDArray = New-Object System.Collections.Generic.List[System.Object]
    # # Iterar sobre la lista de impresoras USB conectadas
    # foreach($printer in $printersConnected)
    # {
    #     # Dividir por el token '&' el deviceID  USBPRINT\TSCTTP-247\6&2204DB7&0&USB002
    #     $strings = $printer.DeviceID.Split('&')
    #     # Si se fue posible dividir el string deviceID
    #     if ($strings.Count -gt 0) {
    #         # Agregar a la lista la cadena USB002 el cual esta en la ultima posicion
    #         $deviceIDArray.Add($strings[$strings.Count - 1])
    #     }
    # }

    # # To test some usb printers connected
    # # $deviceIDArray.Add('USB003')
    # # $deviceIDArray.Add('USB004')
    
    # # Check flag to know if a usbPortName is not in deviceIDArray
    # $check = 0
    # # Iter for each usbPortName
    # foreach($usbPortName in $usbPortsNames)
    # {
    #     # If a usbPortName is not in deviceIDArray, check flag 1
    #     if ($usbPortName -notin $deviceIDArray) {
    #         $check = 1
    #     }
    # }
    # # If a usbPortName was not int a deviceIDArray, show message
    # if ($check) {
    #     [System.Windows.MessageBox]::Show('Las impresoras no estan conectadas', 'Error')
    #     exit
    # }



    # [System.Windows.MessageBox]::Show('Las impresoras se instalaron correctamente', 'Éxito')
}else {
    [System.Windows.MessageBox]::Show('Arranca USB Server', 'Error')
}

# Motor_Print_Robot.exe
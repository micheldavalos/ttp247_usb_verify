$_proccess = Get-Process | Where-Object {$_.MainWindowTitle -eq "USB Server"}
if ($_proccess.MainWindowTitle -eq "USB Server") {
    Start-Process -FilePath "$env:USERPROFILE\Desktop\32bits\ticket_a.exe"
    Start-Sleep -s 5
    Start-Process -FilePath "$env:USERPROFILE\Desktop\32bits\ticket_b.exe"
    Start-Sleep -s 5
    Start-Process -FilePath "$env:USERPROFILE\Desktop\32bits\ticket_c.exe"
}else {
    Write-Output "No Existe"
}
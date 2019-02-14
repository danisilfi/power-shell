@echo off
schtasks.exe /Change /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\WindowsUpdate\sih" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\WindowsUpdate\sihboot" /Disable

echo Se han detenido las tareas programadas de Windows Update

pause


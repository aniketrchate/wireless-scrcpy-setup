@echo off
REM ------------------------------------------
REM Script to connect to Android device over Wi-Fi only and start scrcpy
REM Created by: blancfox
REM ------------------------------------------

REM Set the background color to black and text color to light gray
color 0A

REM Print header with color
echo -----------------------------------------------------------
echo.
echo     Welcome! This script will help you connect to your Android device
echo     over Wi-Fi and start scrcpy to mirror your device screen.
echo     Created by: blancfox
echo.
echo -----------------------------------------------------------

REM Ensure adb is installed
where adb >nul 2>nul
if %errorlevel% neq 0 (
    REM Print error in red using PowerShell
    powershell -Command "Write-Host '[ERROR] ADB is not installed or not found in the system PATH.' -ForegroundColor Red"
    echo Please install ADB and ensure it is added to your PATH environment variable.
    pause
    exit /b
)

REM Ensure at least one device is connected via USB
echo.
powershell -Command "Write-Host '[INFO] Checking for connected devices via USB...' -ForegroundColor Cyan"
adb devices
for /f "tokens=1" %%a in ('adb devices ^| findstr /r /c:"device$"') do set DEVICE_ID=%%a

if not defined DEVICE_ID (
    REM Print error in red using PowerShell
    echo.
    powershell -Command "Write-Host '[ERROR] No device connected via USB. Please connect your Android device via USB and try again.' -ForegroundColor Red"
    pause
    exit /b
)

REM Get the device's IP address using adb shell ip route
echo.
powershell -Command "Write-Host '[INFO] Retrieving the device''s IP address over USB...' -ForegroundColor Cyan"
for /f "tokens=9" %%i in ('adb -s %DEVICE_ID% shell ip route') do set DEVICE_IP=%%i

REM Check if the IP address was successfully retrieved
if not defined DEVICE_IP (
    REM Print error in red using PowerShell
    echo.
    powershell -Command "Write-Host '[ERROR] Could not retrieve the IP address. Please ensure your device has Wi-Fi enabled and is connected properly.' -ForegroundColor Red"
    pause
    exit /b
)

echo.
powershell -Command "Write-Host '[INFO] Device IP address detected: %DEVICE_IP%' -ForegroundColor Cyan"
echo.

REM Enable ADB over TCP/IP on the device (using the USB connection)
powershell -Command "Write-Host '[INFO] Enabling ADB over Wi-Fi on the device...' -ForegroundColor Cyan"
adb -s %DEVICE_ID% tcpip 5555

REM Disconnect the USB connection, as we want to use Wi-Fi only
powershell -Command "Write-Host '[INFO] Disconnecting the USB connection to ensure Wi-Fi only connection...' -ForegroundColor Cyan"
adb -s %DEVICE_ID% disconnect

REM Now connect to the device over Wi-Fi
powershell -Command "Write-Host '[INFO] Attempting to connect to device at %DEVICE_IP%:5555 over Wi-Fi...' -ForegroundColor Cyan"
adb connect %DEVICE_IP%:5555

REM Verify if the device is successfully connected over Wi-Fi
adb devices
for /f "tokens=1" %%a in ('adb devices ^| findstr /r /c:"device$"') do set WIFI_DEVICE=%%a

if not defined WIFI_DEVICE (
    REM Print error in red using PowerShell
    echo.
    powershell -Command "Write-Host '[ERROR] Failed to connect to the device over Wi-Fi. Please ensure the device is properly connected to the network.' -ForegroundColor Red"
    pause
    exit /b
)

echo.
powershell -Command "Write-Host '[INFO] Device successfully connected over Wi-Fi.' -ForegroundColor Green"
echo.

REM Explicitly select the device for scrcpy using the IP address
powershell -Command "Write-Host '[INFO] Launching scrcpy to mirror your device screen...' -ForegroundColor Green"

scrcpy -s %DEVICE_IP%

REM End script
echo.
echo -----------------------------------------------------------
powershell -Command "Write-Host '[INFO] Script execution completed. Thank you for using this tool!' -ForegroundColor Green"
echo -----------------------------------------------------------
pause
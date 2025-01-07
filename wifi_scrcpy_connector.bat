@echo off
REM ------------------------------------------
REM Script to connect to Android device over Wi-Fi only and start scrcpy
REM Created by: blancfox
REM ------------------------------------------

echo -----------------------------------------------------------
echo Welcome! This script will help you connect to your Android device
echo over Wi-Fi and start scrcpy to mirror your device screen.
echo Created by: blancfox
echo -----------------------------------------------------------

REM Ensure adb is installed
where adb >nul 2>nul
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] ADB is not installed or not found in the system PATH.
    echo Please install ADB and ensure it is added to your PATH environment variable.
    pause
    exit /b
)

REM Ensure at least one device is connected via USB
echo.
echo [INFO] Checking for connected devices via USB...
adb devices
for /f "tokens=1" %%a in ('adb devices ^| findstr /r /c:"device$"') do set DEVICE_ID=%%a

if not defined DEVICE_ID (
    echo.
    echo [ERROR] No device connected via USB. Please connect your Android device via USB and try again.
    pause
    exit /b
)

REM Get the device's IP address using adb shell ip route
echo.
echo [INFO] Retrieving the device's IP address over USB...
for /f "tokens=9" %%i in ('adb -s %DEVICE_ID% shell ip route') do set DEVICE_IP=%%i

REM Check if the IP address was successfully retrieved
if not defined DEVICE_IP (
    echo.
    echo [ERROR] Could not retrieve the IP address. Please ensure your device has Wi-Fi enabled and is connected properly.
    pause
    exit /b
)

echo [INFO] Device IP address detected: %DEVICE_IP%
echo.

REM Enable ADB over TCP/IP on the device (using the USB connection)
echo [INFO] Enabling ADB over Wi-Fi on the device...
adb -s %DEVICE_ID% tcpip 5555

REM Disconnect the USB connection, as we want to use Wi-Fi only
echo [INFO] Disconnecting the USB connection to ensure Wi-Fi only connection...
adb -s %DEVICE_ID% disconnect

REM Now connect to the device over Wi-Fi
echo [INFO] Attempting to connect to device at %DEVICE_IP%:5555 over Wi-Fi...
adb connect %DEVICE_IP%:5555

REM Verify if the device is successfully connected over Wi-Fi
adb devices
for /f "tokens=1" %%a in ('adb devices ^| findstr /r /c:"device$"') do set WIFI_DEVICE=%%a

if not defined WIFI_DEVICE (
    echo.
    echo [ERROR] Failed to connect to the device over Wi-Fi. Please ensure the device is properly connected to the network.
    pause
    exit /b
)

echo [INFO] Device successfully connected over Wi-Fi.
echo.

REM Explicitly select the device for scrcpy using the IP address
echo [INFO] Launching scrcpy to mirror your device screen...

scrcpy -s %DEVICE_IP%

REM End script
echo.
echo -----------------------------------------------------------
echo [INFO] Script execution completed. Thank you for using this tool!
echo -----------------------------------------------------------
pause

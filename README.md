# Android Wi-Fi ADB Connection and Scrcpy Launcher

This script helps you connect your Android device to your computer over Wi-Fi and automatically launches **scrcpy** to mirror your device's screen. The script performs the necessary steps to ensure the device is connected via USB first, retrieves the device's IP address, enables ADB over Wi-Fi, and then disconnects the USB connection to establish a wireless connection for screen mirroring.

---

## Table of Contents

1. [Prerequisites]()
2. [Script Overview]()
3. [Usage]()
4. [How It Works]()
5. [Troubleshooting]()
6. [License]()

---

## Prerequisites

Before running this script, ensure the following:

* **ADB** (Android Debug Bridge) is installed on your computer.
  * If not, you can install it via the [official Android developer documentation](https://developer.android.com/studio/command-line/adb).
  * Make sure the `adb` command is added to your system's PATH environment variable.
* **scrcpy** is installed. Scrcpy is a tool for displaying and controlling Android devices connected via USB (or wirelessly).
  * Install scrcpy by following the instructions on [GitHub](https://github.com/Genymobile/scrcpy).
* Your Android device has **Developer Options** and **USB Debugging** enabled.
  * To enable Developer Options: Go to *Settings* > *About phone* > Tap on *Build number* 7 times.
  * To enable USB Debugging: Go to *Settings* > *Developer options* > Turn on  *USB debugging* .

---

## Script Overview

The script does the following:

1. **Checks if ADB is installed** : Ensures that ADB is available and in the system PATH.
2. **Verifies device connection** : Ensures that at least one Android device is connected to the computer via USB.
3. **Retrieves device's IP address** : The script retrieves the IP address of the connected Android device using ADB commands.
4. **Enables ADB over TCP/IP** : It sets up ADB over Wi-Fi on the device.
5. **Disconnects USB** : The USB connection is disconnected to switch to Wi-Fi-only communication.
6. **Connects over Wi-Fi** : The script connects to the device over Wi-Fi using its IP address.
7. **Launches scrcpy** : The script launches **scrcpy** to mirror the device screen.

---

## Usage

1. **Download the script** : Download the script (usually named `wifi_scrcpy_connector.bat`) to your computer.
2. **Connect your Android device** : Use a USB cable to connect your Android device to your computer.
3. **Run the script** : Double-click on the `.bat` script to run it.

* The script will automatically check if ADB is installed, verify the device connection, enable ADB over Wi-Fi, and then launch scrcpy to mirror your device’s screen.

1. **Enjoy** : Your Android device's screen will be mirrored on your computer, and you can interact with it using the mouse and keyboard.

---

## How It Works

### 1. Check if ADB is installed

The script first checks if ADB is installed and available in the system’s PATH. If not, the script will prompt the user to install ADB.

### 2. Verify device connection

The script then verifies if any Android device is connected via USB. It uses the `adb devices` command to check for a connected device. If no device is found, the script will exit.

### 3. Retrieve device IP address

Once a device is detected, the script uses the `adb shell ip route` command to retrieve the device's IP address. This IP address is essential for connecting to the device over Wi-Fi.

### 4. Enable ADB over TCP/IP

The script enables ADB over TCP/IP using the command `adb -s <device_id> tcpip 5555`. This step allows ADB to communicate with the device over Wi-Fi on port 5555.

### 5. Disconnect USB connection

After enabling ADB over Wi-Fi, the script disconnects the USB connection using `adb -s <device_id> disconnect`. This ensures that the communication happens wirelessly.

### 6. Connect over Wi-Fi

The script attempts to connect to the device via its IP address (retrieved earlier) using `adb connect <device_ip>:5555`.

### 7. Launch scrcpy

Finally, the script runs **scrcpy** to display and control the device’s screen on your computer.

---

## Troubleshooting

### ADB not found

* **Error** : `[ERROR] ADB is not installed or not found in the system PATH.`
* **Solution** : Ensure that ADB is installed and added to your system's PATH environment variable.

### Device not detected

* **Error** : `[ERROR] No device connected via USB.`
* **Solution** : Ensure your Android device is properly connected via USB and that USB debugging is enabled on the device.

### IP address retrieval failed

* **Error** : `[ERROR] Could not retrieve the IP address.`
* **Solution** : Ensure your device is connected to a Wi-Fi network and USB debugging is enabled. You can also try restarting your device and reconnecting it to the computer.

### Wi-Fi connection failed

* **Error** : `[ERROR] Failed to connect to the device over Wi-Fi.`
* **Solution** : Make sure the Android device and the computer are on the same Wi-Fi network. Double-check that the IP address is correct and that the device is reachable.

### Scrcpy not launching

* **Error** : `scrcpy command not recognized.`
* **Solution** : Ensure scrcpy is properly installed and added to the PATH environment variable.

---

Feel free to modify and distribute the script as needed.

---

### Note:

* If you encounter any issues or need further assistance, please feel free to open an issue or contribute to the repository!

---

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

* **scrcpy** is installed. Scrcpy includes the required ADB files (`adb.exe`), so you don't need to install ADB separately.

  * Install scrcpy by following the instructions on [GitHub](https://github.com/Genymobile/scrcpy).
* Put the **scrcpy** folder location in your system’s **PATH** environment variable.
* Download the script (e.g., `wifi_scrcpy_connector.bat`) and paste it into the **scrcpy** folder.
* Your Android device has **Developer Options** and **USB Debugging** enabled.

  * To enable Developer Options: Go to *Settings* > *About phone* > Tap on *Build number* 7 times.
  * To enable USB Debugging: Go to *Settings* > *Developer options* > Turn on *USB debugging*.

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

1. **Download the script** : Download the script (e.g., `wifi_scrcpy_connector.bat`) and paste it in the **scrcpy** folder.
2. **Connect your Android device** : Use a USB cable to connect your Android device to your computer.
3. **Run the script** : Open **PowerShell** or **Command Prompt**, type the script name (e.g., `wifi_scrcpy_connector.bat`), and press **Enter**.

   * Alternatively, you can **double-click** the script file to run it.
4. **Enjoy** : Your Android device's screen will be mirrored on your computer, and you can interact with it using the mouse and keyboard.

---

## How It Works

### 1. Check if ADB is installed

The script ensures that ADB is available by checking if `adb.exe` is in the system's **PATH**, as scrcpy includes the necessary ADB tool.

### 2. Verify device connection

The script verifies if any Android device is connected via USB using the `adb devices` command. If no device is found, the script exits.

### 3. Retrieve device IP address

Once a device is detected, the script retrieves the device's IP address using the `adb shell ip route` command.

### 4. Enable ADB over TCP/IP

The script enables ADB over Wi-Fi using the command `adb -s <device_id> tcpip 5555`. This allows ADB to communicate with the device over Wi-Fi.

### 5. Disconnect USB connection

The script disconnects the USB connection using `adb -s <device_id> disconnect` to switch to wireless communication.

### 6. Connect over Wi-Fi

The script connects to the device via its IP address using `adb connect <device_ip>:5555`.

### 7. Launch scrcpy

Finally, the script runs **scrcpy** to display and control the device’s screen on your computer.

---

## Troubleshooting

### ADB not found

* **Error** : `[ERROR] ADB is not installed or not found in the system PATH.`
  **Solution** : Ensure that you have added the **scrcpy** folder to the system's **PATH**. Since scrcpy includes `adb.exe`, you do not need to install ADB separately.

### Device not detected

* **Error** : `[ERROR] No device connected via USB.`
* **Solution** : Ensure your Android device is connected via USB, and **USB debugging** is enabled.

### IP address retrieval failed

* **Error** : `[ERROR] Could not retrieve the IP address.`
* **Solution** : Ensure your device is connected to a Wi-Fi network and USB debugging is enabled. You can also try restarting your device and reconnecting it to the computer.

### Wi-Fi connection failed

* **Error** : `[ERROR] Failed to connect to the device over Wi-Fi.`
* **Solution** : Make sure the Android device and the computer are on the same Wi-Fi network. Double-check that the IP address is correct and that the device is reachable.

### Scrcpy not launching

* **Error** : `scrcpy command not recognized.`
* **Solution** : Ensure **scrcpy** is properly installed and the **scrcpy folder** is added to the **PATH**.

---

Feel free to modify and distribute the script as needed.

---

### Note:

* If you encounter any issues or need further assistance, please feel free to open an issue or contribute to the repository!

---

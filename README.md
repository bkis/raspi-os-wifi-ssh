# raspi-os-wifi-ssh 📡

**_Raspberry Pi OS Lite_ (headless) WiFi and SSH setup script for OS images freshly flashed to SD card**


## ⏱ It saves you 3 minutes of precious time

This simple **bash** script helps with the process of setting up WiFi connectivity and enabling SSH at boot time for headless installs of [Raspberry Pi OS Lite](https://downloads.raspberrypi.org/raspios_lite_armhf/images).

It is supposed to be used with a **mounted**, freshly flashed **SD card**.

```
> Raspberry Pi OS Lite (headless) WiFi and SSH setup script

Enter path to SD card 'boot' partition [/media/username/boot]: 
Enter WiFi name (SSID): My-Fancy-WiFi-Name
Enter WiFi passphrase: 
Enter WiFi key management mode [WPA-PSK]: 
Enter WiFi country code [US]: DE

> Writing /media/username/boot/wpa_supplicant.conf ...
> OK
> Writing /media/username/boot/ssh ...
> OK
> Done. Raspberry Pi OS Lite will boot with WiFi configured and SSH enabled.
```

> 🤔 **Note to myself and potential contributors:** It would be nice to extend
> this script to also take the path to the `.iso` image file and do to flashing
> of the SD card at the beginning of the process.
> It could even do an optional `sudo apt-get update -y && sudo apt-get updgrade -y`.
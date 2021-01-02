#!/bin/bash

#
# Raspberry Pi OS Lite (headless) WiFi and SSH setup script
# for RasPi OS Lite images freshly flashed to SD card
#
# by bkis (https://github.com/bkis)
#

# say hello
echo
echo "> Raspberry Pi OS Lite (headless) WiFi and SSH setup script"
echo

### SET DEFAULT VALUES

WIFI_KEY_MGMT="WPA-PSK" # WiFi key mgmt
WIFI_COUNTRY="US" # WiFi country code
SD_BOOT_PARTITION="/media/$(whoami)/boot" # path to sd card's "boot" partition
ERRORS=0 # error counter

### PROMPT USER FOR REQUIRED DATA

# prompt for SD card boot partition path
read -p "Enter path to SD card 'boot' partition [$SD_BOOT_PARTITION]: " input
SD_BOOT_PARTITION=${input:-$SD_BOOT_PARTITION}

# prompt for wifi data
read -p "Enter WiFi name (SSID): " WIFI_SSID
read -s -p "Enter WiFi passphrase: " WIFI_PASSPHRASE; echo
read -p "Enter WiFi key management mode [$WIFI_KEY_MGMT]: " input
WIFI_KEY_MGMT=${input:-$WIFI_KEY_MGMT}
read -p "Enter WiFi country code [$WIFI_COUNTRY]: " input
WIFI_COUNTRY=${input:-$WIFI_COUNTRY}

### START DOING STUFF

echo
echo "> Writing $SD_BOOT_PARTITION/wpa_supplicant.conf ..."

# write wpa_supplicant.conf
cat > "$SD_BOOT_PARTITION/wpa_supplicant.conf" << EOF
country=$WIFI_COUNTRY
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev 
update_config=1
network={
    ssid="$WIFI_SSID"
    psk="$WIFI_PASSPHRASE"
    key_mgmt=$WIFI_KEY_MGMT
}
EOF

if [ $? -eq 0 ]; then
    echo "> OK"
else
    echo "> ERROR"
    ERRORS=$((ERRORS + 1))
fi

echo "> Writing $SD_BOOT_PARTITION/ssh ..."

# write ssh hint
echo "" > "$SD_BOOT_PARTITION/ssh"

if [ $? -eq 0 ]; then
    echo "> OK"
else
    echo "> ERROR"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -eq 0 ]; then
    echo "> Done. Raspberry Pi OS Lite will boot with WiFi configured and SSH enabled."
    exit 0
else
    echo "> Error! Something went wrong :("
    echo "> Please see the error messages above!"
    exit 1
fi

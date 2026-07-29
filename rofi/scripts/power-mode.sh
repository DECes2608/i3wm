#!/bin/bash

if [ "$1" = "--status" ]; then
    powerprofilesctl get    # sadece "balanced" / "performance" / "power-saver" döner
    exit 0
fi

current=$(powerprofilesctl get)
choice=$(echo -e "Performance\nBalanced\nPower Saver" | rofi -dmenu -p "Mode: $current")

[ -z "$choice" ] && exit 0   # rofi kapatılırsa hata vermesin

notify-send "Power Mode" "$choice Activated"

case "$choice" in
  "Performance")  powerprofilesctl set performance ;;
  "Balanced")     powerprofilesctl set balanced ;;
  "Power Saver")  powerprofilesctl set power-saver ;;
esac

#!/bin/bash

# Seçenekleri belirle (Menüde görünecek sıra)
option=$(printf "Exit i3\nReboot\nShutdown" | rofi -dmenu -p "Session")

# Seçime göre işlemi çalıştır
case "$option" in
"Exit i3")
  pkill i3
  ;;
"Reboot")
  systemctl reboot
  ;;
"Shutdown")
  systemctl poweroff
  ;;
esac

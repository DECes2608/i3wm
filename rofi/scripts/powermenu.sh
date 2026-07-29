#!/bin/bash

# Seçenekleri belirle (Menüde görünecek sıra)
option=$(printf "Lock\nExit Hyprland\nReboot\nShutdown" | rofi -dmenu -p "Session")

# Seçime göre işlemi çalıştır
case "$option" in
"Lock")
  hyprlock # Kilit ekranı için hyprlock kullanıyorsan
  ;;
"Exit Hyprland")
  pkill hyprland exit # Oturumu güvenli kapatmak için
  ;;
"Reboot")
  systemctl reboot
  ;;
"Shutdown")
  systemctl poweroff
  ;;
esac

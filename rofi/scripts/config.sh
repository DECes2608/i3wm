#!/bin/bash

# Seçenekleri belirle (Menüde görünecek sıra)
option=$(printf "Rofi\nHyprland\nWaybar\nconfig" | rofi -dmenu -p "Session")

# Seçime göre işlemi çalıştır
case "$option" in
"Rofi")
  kitty --title nvim -e nvim ~/.config/rofi
  ;;
"Hyprland")
  kitty --title nvim -e nvim ~/.config/hypr
  ;;
"Waybar")
  kitty --title nvim -e nvim ~/.config/waybar
  ;;
"config")
  kitty --title nvim -e nvim ~/.config
  ;;
esac

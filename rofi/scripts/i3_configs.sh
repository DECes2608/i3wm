#!/bin/bash

# Seçenekleri belirle (Menüde görünecek sıra)
option=$(printf "i3\nRofi\nPolybar\nPicom\nconfig" | rofi -dmenu -p "Session")

# Seçime göre işlemi çalıştır
case "$option" in
"i3")
  st -t "nvim" -e nvim ~/.config/i3
  ;;
"Rofi")
  st -t "nvim" -e nvim ~/.config/rofi
  ;;
"Polybar")
  st -t "nvim" -e nvim ~/.config/polybar
  ;;
"Picom")
  st -t "nvim" -e nvim ~/.config/picom
  ;;
"config")
  st -t "nvim" -e nvim ~/.config
  ;;
esac

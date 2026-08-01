#!/bin/bash

# Seçenekleri belirle (Menüde görünecek sıra)
option=$(printf "i3\nRofi\nPolybar\nPicom\nconfig" | rofi -dmenu -p "Session")

# Seçime göre işlemi çalıştır
case "$option" in
"i3")
  kitty --title nvim -e nvim ~/.config/i3
  ;;
"Rofi")
  kitty --title nvim -e nvim ~/.config/rofi
  ;;
"Polybar")
  kitty --title nvim -e nvim ~/.config/polybar
  ;;
"Picom")
  kitty --title nvim -e nvim ~/.config/picom
  ;;
"config")
  kitty --title nvim -e nvim ~/.config
  ;;
esac

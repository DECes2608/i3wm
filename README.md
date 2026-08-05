# i3wm

<img width="1920" height="1080" alt="resim" src="https://github.com/user-attachments/assets/1ebf8c0d-2370-49cb-bf45-31764a18f7b0" />


i3 için kişisel dotfiles: `i3`, `polybar`, `rofi`, `picom`, `kitty`, `dunst`.

- **WM:** i3 (X11)
- **Bar:** polybar
- **Compositor:** picom (blur, gölge, custom shader)
- **Launcher:** rofi (tema seçenekleri: dracula, gruvbox, meadow, pure-black)
- **Bildirim:** dunst (Papirus-Dark ikonları)
- **Terminal:** kitty

## 📦 Kurulum

### Düz kurulum

```bash
git clone https://github.com/DECes2608/i3wm
cd i3wm
cp -r i3 ~/.config/
cp -r rofi ~/.config/
cp -r polybar ~/.config/
cp -r picom ~/.config/
cp -r kitty ~/.config/
cp -r dunst ~/.config/
```

### Basit kurulum (sadece Void Linux için)

```bash
git clone https://github.com/DECes2608/i3wm
cd i3wm && bash install.sh
```

`install.sh`, xbps ile gerekli tüm paketleri (i3, polybar, rofi, picom, dunst,
kitty, thunar, zathura, nvidia sürücüsü vb.) kurar, config'leri `~/.config`
altına kopyalar ve Monocraft fontunu indirir. Hiçbir şeyi kaynaktan derlemez.

## Gereksinimler

- Void Linux (xbps)
- Nvidia GPU (Optimus hybrid destekli, `nvidia` sürücüsü kurulur)

## Kısayollar

Tüm kısayollar `i3/config.d/binds.conf` içinde. Öne çıkanlar:

| Tuş | İşlev |
|---|---|
| `$mod+Return` | st |
| `$mod+d` | rofi (drun) |
| `$mod+b` | librewolf |
| `$mod+e` | yazi |
| `$mod+c` | nvim |
| `$mod+x` | powermenu |

## Lisans

Kişisel kullanım için paylaşılmıştır, dilediğin gibi kullanabilirsin.

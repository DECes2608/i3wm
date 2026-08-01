#!/bin/bash
# ╔══════════════════════════════════════════════════════╗
# ║            i3wm — Void Linux Kurulum Scripti          ║
# ║                                                      ║
# ║  Kullanım: bash install.sh                           ║
# ╚══════════════════════════════════════════════════════╝

set -e  # Hata olursa dur

# ── Renkler ───────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ── Yardımcı fonksiyonlar ─────────────────────────────────
info()    { echo -e "${CYAN}[→]${NC} $1"; }
success() { echo -e "${GREEN}[✓]${NC} $1"; }
warning() { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✗]${NC} $1"; exit 1; }
header()  { echo -e "\n${BOLD}${BLUE}══ $1 ══${NC}\n"; }

# ── xbps'de paket var mı? ─────────────────────────────────
xbps_has() {
    xbps-query -R "$1" &>/dev/null
}

# ── Banner ────────────────────────────────────────────────
echo -e "${BOLD}"
echo "  ██╗██████╗ ██╗    ██╗███╗   ███╗"
echo "  ██║╚════██╗██║    ██║████╗ ████║"
echo "  ██║ █████╔╝██║ █╗ ██║██╔████╔██║"
echo "  ██║ ╚═══██╗██║███╗██║██║╚██╔╝██║"
echo "  ██║██████╔╝╚███╔███╔╝██║ ╚═╝ ██║"
echo "  ╚═╝╚═════╝  ╚══╝╚══╝ ╚═╝     ╚═╝"
echo -e "${NC}"
echo -e "  ${CYAN}i3wm Dotfiles — Void Linux Kurulum Scripti${NC}"
echo -e "  ${CYAN}github.com/DECes2608/i3wm${NC}\n"
echo -e "  ${YELLOW}Not: Script soru sormadan otomatik ilerler, hiçbir kaynak derlemesi yapılmaz.${NC}\n"

# ── Sistem kontrolü ───────────────────────────────────────
header "Sistem Kontrolü"

if ! command -v xbps-install &>/dev/null; then
    error "Bu script sadece Void Linux için tasarlandı (xbps bulunamadı)!"
fi
success "Void Linux (xbps) tespit edildi"

if [[ $EUID -eq 0 ]]; then
    error "Bu scripti root olarak çalıştırma! Normal kullanıcı ile çalıştır."
fi
success "Kullanıcı: $(whoami)"

if ! ping -c 1 voidlinux.org &>/dev/null; then
    error "İnternet bağlantısı yok!"
fi
success "İnternet bağlantısı mevcut"

# ── Repo senkronizasyonu ──────────────────────────────────
header "XBPS Repo Güncelleme"

info "Paket veritabanı güncelleniyor..."
sudo xbps-install -Su xbps
sudo xbps-install -S
success "Repo indeksi güncellendi"

# ── Temel sistem paketleri ────────────────────────────────
header "Temel Sistem Paketleri"

XBPS_PKGS=(
    # i3 ekosistemi
    i3
    i3status
    rofi
    picom
    feh
    i3lock

    # Terminal & kabuk
    kitty
    fish

    # Ses
    pipewire
    wireplumber
    pavucontrol
    pamixer
    playerctl

    # Bluetooth
    bluez
    blueman

    # Ekran görüntüsü & clipboard (X11)
    maim
    xclip

    # Sistem araçları
    polkit-gnome
    brightnessctl
    upower
    gtk+3
    gtk4
    qt5
    qt6-base
    xorg-server
    xorg-input-drivers
    xorg-video-drivers
    xdg-user-dirs
    dunst

    # Dosya yönetimi
    yazi
    thunar
    thunar-volman
    gvfs
    zathura
    zathura-pdf-mupdf
    poppler
    ffmpegthumbnailer
    jq
    fd
    ripgrep
    fzf
    zoxide
    ImageMagick

    # Geliştirme
    neovim
    vim
    git
    lazygit
    nodejs
    python3
    python3-pip
    unzip
    base-devel

    # Medya
    mpd
    ncmpcpp
    mpc
)

info "Kurulacak paketler:"
echo ""
printf '  %s\n' "${XBPS_PKGS[@]}" | column
echo ""

sudo xbps-install -S --yes "${XBPS_PKGS[@]}"
success "Tüm paketler kuruldu!"

# ── Eskiden AUR gerektiren paketler ───────────────────────
header "Eskiden AUR Gerektiren Paketler"

# Arch/yay sürümünde AUR'dan kurulan paketler: ncspot, localsend-bin, copyq
# Void'de AUR yok ve hiçbir şey kaynaktan derlenmiyor. Sadece resmi xbps
# repolarında bulunanlar kurulur, bulunmayanlar sessizce atlanır.

declare -A EXTRA_PKGS=(
    [ncspot]="ncspot"
    [copyq]="CopyQ"
    [localsend]="localsend"
)

TO_INSTALL=()
for label in "${!EXTRA_PKGS[@]}"; do
    pkg="${EXTRA_PKGS[$label]}"
    if xbps_has "$pkg"; then
        success "$label → xbps repolarında mevcut ($pkg), kuruluma eklendi"
        TO_INSTALL+=("$pkg")
    else
        warning "$label → xbps repolarında yok, atlanıyor (derleme yapılmıyor)"
    fi
done

if [[ ${#TO_INSTALL[@]} -gt 0 ]]; then
    sudo xbps-install -S --yes "${TO_INSTALL[@]}"
    success "Ekstra paketler kuruldu!"
fi

# ── Servisleri aktif et (runit) ───────────────────────────
header "Servis Aktivasyonları (runit)"

if [[ -d /etc/sv/bluetoothd ]]; then
    sudo ln -sf /etc/sv/bluetoothd /var/service/
    success "bluetoothd servisi aktif edildi"
fi

if [[ -d /etc/sv/mpd ]]; then
    sudo ln -sf /etc/sv/mpd /var/service/
    success "mpd servisi aktif edildi"
    info "Kullanıcına özel ayarlar için /etc/mpd.conf dosyasını düzenlemen gerekebilir"
fi

# ── Fish shell varsayılan kabuk ───────────────────────────
header "Fish Shell"

if [[ "$SHELL" != *"fish"* ]]; then
    sudo chsh -s "$(which fish)" "$(whoami)"
    success "Fish varsayılan kabuk olarak ayarlandı (yeniden giriş gerekli)"
else
    success "Fish zaten varsayılan kabuk"
fi

# ── Dotfiles kurulumu (kopyalama) ─────────────────────────
header "Dotfiles Kurulumu"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

info "Dotfiles dizini: $DOTFILES_DIR"
info "Config dizini: $CONFIG_DIR"
echo ""

# Yedek al
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
warning "Mevcut config yedekleniyor: $BACKUP_DIR"
cp -r "$CONFIG_DIR" "$BACKUP_DIR" 2>/dev/null || true
success "Yedek alındı: $BACKUP_DIR"

# Kopyala (symlink değil)
for dir in i3 picom dunst kitty yazi nvim zathura; do
    if [[ -d "$DOTFILES_DIR/$dir" ]]; then
        rm -rf "$CONFIG_DIR/$dir"
        cp -r "$DOTFILES_DIR/$dir" "$CONFIG_DIR/$dir"
        success "$dir → kopyalandı"
    else
        warning "$dir klasörü repoda bulunamadı, atlanıyor"
    fi
done

# ── Neovim dagzirvesi teması ──────────────────────────────
header "Neovim Teması (dagzirvesi)"

mkdir -p ~/.config/nvim/colors
if [[ -f "$DOTFILES_DIR/dagzirvesi.lua" ]]; then
    cp "$DOTFILES_DIR/dagzirvesi.lua" ~/.config/nvim/colors/
    success "dagzirvesi.lua kuruldu"
else
    warning "dagzirvesi.lua bulunamadı, manuel kopyalaman gerekiyor"
    info "Beklenen konum: $DOTFILES_DIR/dagzirvesi.lua"
fi

# ── Fish PATH ayarı ───────────────────────────────────────
header "PATH Ayarları"

info "~/.local/bin PATH'e ekleniyor..."
if fish -c "fish_add_path ~/.local/bin" 2>/dev/null; then
    success "PATH güncellendi"
else
    warning "Fish ile PATH güncellenemedi"
    info "Manuel eklemek için: fish_add_path ~/.local/bin"
fi

# ── Özet ──────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}╔══════════════════════════════════════╗${NC}"
echo -e "${BOLD}${GREEN}║        Kurulum Tamamlandı! 🏔️         ║${NC}"
echo -e "${BOLD}${GREEN}╚══════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${CYAN}Sonraki adımlar:${NC}"
echo -e "  1. Sistemi yeniden başlat veya yeniden giriş yap"
echo -e "  2. startx ya da ekran yöneticinden i3'ü başlat"
echo -e "  3. ${YELLOW}i3-msg reload${NC} ile config'i yükle"
echo -e "  4. Neovim'i aç ve ${YELLOW}:Lazy sync${NC} yaz"
echo -e "  5. Fish için yeni terminal aç"
echo ""
echo -e "  ${CYAN}Sorun olursa:${NC}"
echo -e "  → Config yedeği: ${YELLOW}~/.config-backup-*${NC}"
echo -e "  → Repo: ${YELLOW}github.com/DECes2608/i3wm${NC}"
echo ""

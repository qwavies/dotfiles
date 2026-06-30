#!/bin/bash

set -e # exit on error

BOLD_PURPLE="\e[1;35m"
RESET="\e[0m"

source packages/pacman.conf
source packages/aur.conf

mkdir --parents ~/Downloads
mkdir --parents ~/Documents
mkdir --parents ~/Pictures/Screenshots
mkdir --parents ~/Videos

if ! command -v yay >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    echo -e "${BOLD_PURPLE}yay not found in system, installing now...${RESET}"
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

echo -e "${BOLD_PURPLE}Updating system...${RESET}"
sudo pacman -Syu --noconfirm

echo -e "${BOLD_PURPLE}Installing pacman packages...${RESET}"
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

echo -e "${BOLD_PURPLE}Installing aur packages...${RESET}"
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

if ! which "$SHELL" | grep -q "zsh"; then
    echo -e "${BOLD_PURPLE}Changing default shell to zsh. You may need to restart for changes to take effect...${RESET}"
    chsh -s $(which zsh)
fi

create_symlink() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        rm -rf "${dest}.bak"
	mv "$dest" "${dest}.bak"
    elif [ -L "$dest" ]; then
	rm -f "$dest"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sfn "$src" "$dest"
}

echo -e "${BOLD_PURPLE}Setting dotfile symlinks...${RESET}"
DOTFILE_CONFIGS_DIR="$(pwd)/configs"

create_symlink "${DOTFILE_CONFIGS_DIR}/.zshrc" "$HOME/.zshrc"
create_symlink "${DOTFILE_CONFIGS_DIR}/starship.toml" "$HOME/.config/starship.toml"
create_symlink "${DOTFILE_CONFIGS_DIR}/bat" "$HOME/.config/bat"
create_symlink "${DOTFILE_CONFIGS_DIR}/fastfetch" "$HOME/.config/fastfetch"
create_symlink "${DOTFILE_CONFIGS_DIR}/hypr" "$HOME/.config/hypr"
create_symlink "${DOTFILE_CONFIGS_DIR}/rofi" "$HOME/.config/rofi"
create_symlink "${DOTFILE_CONFIGS_DIR}/swaync" "$HOME/.config/swaync"
create_symlink "${DOTFILE_CONFIGS_DIR}/waybar" "$HOME/.config/waybar"
create_symlink "${DOTFILE_CONFIGS_DIR}/waybar-weather" "$HOME/.config/waybar-weather"
create_symlink "${DOTFILE_CONFIGS_DIR}/wezterm" "$HOME/.config/wezterm"
create_symlink "${DOTFILE_CONFIGS_DIR}/wlogout" "$HOME/.config/wlogout"
create_symlink "${DOTFILE_CONFIGS_DIR}/yazi" "$HOME/.config/yazi"
create_symlink "${DOTFILE_CONFIGS_DIR}/nvim" "$HOME/.config/nvim"

if grep -q "^#\s*Color" /etc/pacman.conf; then
    sudo sed -i "s/^#\s*Color/Color/" /etc/pacman.conf
    echo -e "${BOLD_PURPLE}Adding colours to pacman/yay...${RESET}"
fi

sudo cp -r "${DOTFILE_CONFIGS_DIR}/sddm/minecraft" "/usr/share/sddm/themes"

if ! grep -q "Current=minecraft" /etc/sddm.conf 2>/dev/null; then
    echo -e "${BOLD_PURPLE}Changing sddm theme... (avatar can be changed by using the provided script)${RESET}"
    sudo tee /etc/sddm.conf > /dev/null << 'EOF'
[General]
InputMethod=qtvirtualkeyboard
GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/minecraft/components/,QT_IM_MODULE=qtvirtualkeyboard

[Theme]
Current=minecraft
CursorSize=32
EOF
fi

# TODO: 
# - [ ] fix/redo waybar
# - [ ] hyprlock
# - [ ] hypridle
# - [ ] wlogout
# - [ ] resize swaync & notifs
# - [ ] plymouth
# - [ ] switch hyprland over to lua

echo -e "${BOLD_PURPLE}Post-install script finished successfully! A full system restart is recommended.${RESET}"

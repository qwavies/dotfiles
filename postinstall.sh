#!/bin/bash

set -e # exit on error

source packages/pacman.conf
source packages/aur.conf

mkdir --parents ~/Downloads
mkdir --parents ~/Documents
mkdir --parents ~/Pictures/Screenshots
mkdir --parents ~/Videos

if ! command -v yay >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    echo "yay not found in system, installing now..."
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

echo "updating system..."
sudo pacman -Syu --noconfirm

echo "installing pacman packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

echo "installing aur packages..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

if ! which "$SHELL" | grep -q "zsh"; then
    echo "changing default shell to zsh. You may need to restart for changes to take effect."
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

echo "setting dotfile symlinks"
DOTFILE_CONFIGS_DIR="$(pwd)/configs"

create_symlink "${DOTFILE_CONFIGS_DIR}/.zshrc" "$HOME/.zshrc"
create_symlink "${DOTFILE_CONFIGS_DIR}/starship.toml" "$HOME/.config/starship.toml"
create_symlink "${DOTFILE_CONFIGS_DIR}/bat" "$HOME/.config/bat"
create_symlink "${DOTFILE_CONFIGS_DIR}/fastfetch" "$HOME/.config/fastfetch"
create_symlink "${DOTFILE_CONFIGS_DIR}/hypr" "$HOME/.config/hypr"
create_symlink "${DOTFILE_CONFIGS_DIR}/rofi" "$HOME/.config/rofi"
create_symlink "${DOTFILE_CONFIGS_DIR}/swaync" "$HOME/.config/swaync"
create_symlink "${DOTFILE_CONFIGS_DIR}/waybar" "$HOME/.config/waybar"
create_symlink "${DOTFILE_CONFIGS_DIR}/wezterm" "$HOME/.config/wezterm"
create_symlink "${DOTFILE_CONFIGS_DIR}/wlogout" "$HOME/.config/wlogout"
create_symlink "${DOTFILE_CONFIGS_DIR}/yazi" "$HOME/.config/yazi"
create_symlink "${DOTFILE_CONFIGS_DIR}/nvim" "$HOME/.config/nvim"

if grep -q "^#\s*Color" /etc/pacman.conf; then
    sudo sed -i "s/^#\s*Color/Color/" /etc/pacman.conf
    echo "Adding colours to pacman/yay"
fi
# TODO: sddm, cursor

echo "post-install script finished successfully. A full system restart is recommended."

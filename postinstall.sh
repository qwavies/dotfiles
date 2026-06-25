#!/bin/bash

set -e # exit on error

source packages/pacman.conf
source packages/aur.conf

if ! command -v yay >/dev/null 2>&1; then
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

echo "setting dotfile symlinks"
DOTFILE_CONFIGS_DIR="$(pwd)/configs"
ln -sf ${DOTFILE_CONFIGS_DIR}/.zshrc ~/.zshrc
ln -sf ${DOTFILE_CONFIGS_DIR}/starship.toml ~/.config/starship.toml
ln -sfn ${DOTFILE_CONFIGS_DIR}/bat ~/.config/bat
ln -sfn ${DOTFILE_CONFIGS_DIR}/fastfetch ~/.config/fastfetch
ln -sfn ${DOTFILE_CONFIGS_DIR}/hypr ~/.config/hypr
ln -sfn ${DOTFILE_CONFIGS_DIR}/rofi ~/.config/rofi
ln -sfn ${DOTFILE_CONFIGS_DIR}/swaync ~/.config/swaync
ln -sfn ${DOTFILE_CONFIGS_DIR}/waybar ~/.config/waybar
ln -sfn ${DOTFILE_CONFIGS_DIR}/wezterm ~/.config/wezterm
ln -sfn ${DOTFILE_CONFIGS_DIR}/wlogout ~/.config/wlogout
ln -sfn ${DOTFILE_CONFIGS_DIR}/yazi ~/.config/yazi

if grep -q "^#\s*Color" /etc/pacman.conf; then
    sudo sed -i "s/^#\s*Color/Color/" /etc/pacman.conf
    echo "Adding colours to pacman/yay"
fi
# TODO: sddm, nvim

echo "post-install script finished successfully. A full system restart is recommended."

#!/bin/bash
set -eu

dpkg -s stow > /dev/null 2>&1 || sudo apt install -y stow

apt_packages=(
    git 
    neovim 
    tmux 
    zsh
)

for pkg in "${apt_packages[@]}"; do
    echo "Setting up $pkg"
    dpkg -s "$pkg" >/dev/null 2>&1 || sudo apt install -y "$pkg"

    stow $pkg
done

echo "Setting up starship"
if ! command -v starship >/dev/null; then
    curl -sS https://starship.rs/install.sh | sh
fi
stow starship

echo "Done"

#!/usr/bin/env bash

Install_hypr() {
    echo "Installing hyprland waybar"
    sudo pacman -S --noconfirm --needed hyprland waybar
}

Config_hypr() {
    echo "Removing $HOME/.config/hypr/ $HOME/.config/waybar/"
    trash "$HOME/.config/hypr/" "$HOME/.config/waybar/"

    echo "Mkdir $HOME/.config/hypr/ $HOME/.config/waybar/"
    mkdir -p "$HOME/.config/hypr/"
    mkdir -p "$HOME/.config/waybar/"

    echo "Copying $HOME/.config/hypr/ $HOME/.config/waybar/"
    cp -r "$HOME/dev/resource/hypr/." "$HOME/.config/hypr/"
    cp -r "$HOME/dev/resource/waybar/." "$HOME/.config/waybar/"

}

Main() {
    Install_hypr
    Config_hypr
}

Main

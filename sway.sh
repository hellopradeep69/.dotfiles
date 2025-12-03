#!/usr/bin/env bash
# Install Sway | i3wm replacement

Install_sway() {
    sudo pacman -Syu
    sudo pacman -S sway swaylock i3status rofi-wayland brightnessctl mako
}

Make_dir() {
    mkdir -p $HOME/.config/i3status/
    mkdir -p $HOME/.config/sway/
}

Copy_it() {
    cp -r $HOME/dev/resource/sway/. $HOME/.config/sway
    cp -r $HOME/dev/resource/i3status/. $HOME/.config/i3status
}

Main() {
    echo "Rofi doesnt need any like config"
    Install_sway
    Make_dir
    Copy_it
}

Main

#!/bin/bash
# My development setup for linux Arch

Options=$1

Install_pack() {
    echo "Installing variour package fastfetch ghostty fd ripgrep tmux zsh btop curl wget trash-cli gcc nodejs npm "
    sudo pacman -S --noconfirm --needed fastfetch ghostty fd ripgrep tmux zsh \
        btop curl wget trash-cli gcc nodejs npm wl-clipboard cliphist grim telegram-desktop
}

Install_font() {
    echo "Installing font"
    sudo pacman -S --noconfirm --needed ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-jetbrains-mono
    fc-cache -f -v
}

Install_zplugin() {
    echo "Installin zsh plugin"

    # Create the directory if missing
    mkdir -p ~/.oh-my-zsh/custom/plugins

    # Install plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

    git clone https://github.com/zsh-users/zsh-completions \
        ~/.oh-my-zsh/custom/plugins/zsh-completions
}

Zsh_setup() {
    Shell=$(echo "$SHELL")
    if [[ $Shell == "/usr/bin/zsh" ]]; then
        echo "zsh"
    else
        echo "not zsh"
        chsh -s $(which zsh)
    fi

    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo "zsh available not touching"
    else
        echo "Downloading oh my zsh"
        # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        Install_zplugin
    fi

    echo "Reinstalling zsh and zsh conf"
    [[ -f "$HOME/.zshrc" ]] && trash "$HOME/.zshrc"
    cp -r "$HOME/dev/.zshrc" "$HOME/.zshrc"

}

Tmux_in() {
    echo ""
    echo "Reinstalling tmux and tmux conf"
    [[ -f "$HOME/.tmux.conf" ]] && trash "$HOME/.tmux.conf"
    cp -r "$HOME/dev/.tmux.conf" "$HOME/.tmux.conf"
}

Nvim_setup() {
    echo ""
    echo "Nvim setuping.."
    rm -rf ~/.config/nvim
    mkdir -p ~/.config/nvim
    git clone https://github.com/hellopradeep69/nvim.git ~/.config/nvim/
    rm -rf ~/.config/nvim/.git
    rm -rf ~/.config/nvim/README.md
}

Ghostty_setup() {
    echo ""
    echo "Resetting ghostty config"
    rm -rf ~/.config/ghostty
    mkdir -p ~/.config/ghostty
    cp -r $HOME/dev/resource/ghostty/config ~/.config/ghostty/
}

Script_install() {
    echo "Scripting Install"

    trash "$HOME/.local/bin/"
    mkdir -p "$HOME/.local/bin/"

    cp -r $HOME/dev/resource/scripts/. $HOME/.local/bin/
    echo "Scripts copied to $HOME/.local/bin/"
}

Main() {
    Ghostty_setup
    Install_font
    Install_pack
    Tmux_in
    Nvim_setup
    Zsh_setup
    Script_install
    echo ""
    echo "Basic Setup done"
}

case "$Options" in
-help)
    echo "Usage:"
    echo "./Arch.sh -hyprland        to install hyprland and config"
    echo "./Arch.sh -sway            to install hyprland and config"
    ;;
-hyprland)
    bash $HOME/dev/hyprland.sh
    ;;
-sway)
    $HOME/dev/sway.sh
    ;;
*)
    Main
    echo "-help for info on installing hyprland and sway "
    ;;
esac

echo ""
echo "Now You can proudly say I use arch btw"

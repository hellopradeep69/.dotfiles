#!/usr/bin/env bash
# Will i ever be using Arch

# Install package
Install_pack() {
  sudo pacman -Syu --noconfirm
  sudo pacman -S --noconfirm \
    cmake picom rofi wezterm alacritty zsh btop dunst git curl wget tmux bat unzip fzf neovim fastfetch fd
}

Install_font() {
  mkdir -p ~/.local/share/fonts

  wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip JetBrainsMono.zip -d ~/.local/share/fonts
  fc-cache -fv

}

Install_font1() {

  mkdir -p ~/.local/share/fonts

  wget -O Terminus.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Terminus.zip
  unzip Terminus.zip -d ~/.local/share/fonts
  fc-cache -fv
}

Plugin_zsh() {
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-completions.git \
    ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
}

Install_nvimconf() {
  mkdir -p "$HOME/.config/nvim"
  git clone https://github.com/hellopradeep69/Hello-Nvim.git "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git" "$HOME/.config/nvim/README.md"
}

# Install packages
echo "Installing necessary packages..."
install_packages
echo "Packages installed!"

# Install font
echo "Installing Fonts"
Install_font
echo "....."
Install_font1

# Install neovim config
echo " Install neovim config "
Install_nvimconf

# Install zsh plugins
echo "Install zsh plugin"
Plugin_zsh

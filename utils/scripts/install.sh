#!/usr/bin/env bash

# Confirms you want to start installation
read -p "This script is intended to be ran directly after using archinstall to install the hyprland profile. Continue? [Y/n] " continue_install
continue_install=${continue_install:-n}

case $continue_install in
  [yY] )
    echo -e "\e[1;32mContinuing installation...\e[0m"
    ;;
  * )
    echo -e "\e[1;31mAborting installation...\e[0m"
    exit 1
    ;;
esac

# Renames arch-dotfiles to dotfiles, fails if either arch-dotfiles doesn't exist or dotfiles directory already exists
if [[ -d "$HOME/arch-dotfiles" ]] && [[ ! -d "$HOME/dotfiles" ]]; then
  echo -e "\e[1;37mRenaming \e[1;31march-dotfiles \e[1;37mto \e[1;32mdotfiles\e[1;37m...\e[0m"
  mv $HOME/arch-dotfiles/ $HOME/dotfiles
else
  echo -e "\e[1;31mError with directory structure: \e[0;37mPlease ensure no other dotfiles folder in '\e[1;32m$HOME'\e[0m"
  exit 1
fi

# Installs base packages
cd ~
sudo pacman -Syu aspnet-runtime base-devel blueman brightnessctl cifs-utils curl discord docker dotnet-runtime dotnet-sdk fastfetch flatpak fzf gcc ghostty git github-cli hypridle hyprlock hyprpaper jdk-openjdk kitty libreoffice-fresh man maven networkmanager nm-connection-editor nvim nodejs npm nwg-dock-hyprland obsidian pipewire pgcli postgresql ripgrep stow swaync tmux tree ttf-font-awesome $(pacman -Sgq nerd-fonts) unzip waybar wireplumber zip zoxide zsh

# Clones and Installs yay
git clone https://aur.archlinux.org/yay
cd yay
makepkg -si
cd ~

# Installs Prism Minecraft Launcher
flatpak install org.prismlauncher.PrismLauncher

# Installs yay packages
yay -S google-chrome hyprshot mirage montserrat-otf

# Installs SDKMan and Spring CLI
curl -s "https://get.sdkman.io" | bash
source $HOME/.sdkman/bin/sdkman-init.sh
sdk install springboot

# Downloads TPM and Catppuccin theme for TMUX
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Installs NPM Packages
sudo npm install -g @google/gemini-cli nodemon prettier-plugin-tailwindcss typescript typescript-language-server @tailwindcss/language-server

# SDDM Theme
if [[ -d "$HOME/sddm-astronaut-theme" ]]; then
  rm -rf $HOME/sddm-astronaut-theme
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"

# NetworkManager setup
sudo systemctl disable --now systemd-networkd
sudo systemctl enable --now NetworkManager
sudo systemctl disable --now iwd
sudo systemctl enable --now wpa_supplicant
sudo systemctl enable --now bluetooth
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

if [[ -f /etc/NetworkManager/conf.d/dns.conf ]]; then
  sudo mv /etc/NetworkManager/conf.d/dns.conf /etc/NetworkManager/conf.d/dns.conf.bak
fi
echo -e "\n\e[1;32mEditing dns.conf...\e[0m"
echo -e "[main]\ndns=none" | sudo tee /etc/NetworkManager/conf.d/dns.conf

if [[ -f /etc/resolv.conf ]]; then # replace these with your desired nameserver/s
  sudo mv /etc/resolv.conf /etc/resolv.conf.bak
fi
echo -e "\n\e[1;32mEditing resolved.conf...\e[0m"
echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4\nnameserver 127.0.0.1" | sudo tee /etc/resolv.conf

if [[ -f /etc/NetworkManager/NetworkManager.conf ]]; then
  sudo mv /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf.bak
fi
echo -e "\n\e[1;32mEditing NetworkManager.conf...\e[0m"
echo -e "[backend]\nbackend=wpa_supplicant" | sudo tee /etc/NetworkManager/NetworkManager.conf

# Final Setup
source ~/dotfiles/utils/scripts/stow.sh
cd && clear && fastfetch

echo -e "\e[1;37mNext Steps\e[0m:"
echo -e "* Add network connection in \e[1;31m[nm-connection-editor]\e[0m and \e[1;32mReboot\e[0m"
echo -e "* Run \e[1;35m[chsh]\e[0m and change user shell to \e[1;35m/usr/bin/zsh\e[0m"
echo -e "* Run \e[1;32m[tmux]\e[0m and press \e[1;32m[<ctrl>+b, i]\e[0m to install tmux plugins"
echo -e "* Run \e[1;34m:MasonInstallAll\e[0m inside \e[1;34mNeovim\e[0m"
echo -e "* Run \e[1;36m[bash ~/dotfiles/utils/scripts/post_setup.sh]\e[0m to finish setting up."

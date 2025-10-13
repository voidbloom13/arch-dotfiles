#!/usr/bin/env bash

if [[ -d "~/arch-dotfiles" ]] && [[ ! -d "~/dotfiles" ]]; then
  mv ~/arch-dotfiles/ ~/dotfiles
else
  echo -e "Error with directory structure: Please ensure no other dotfiles folder in '$HOME'"
fi

read -p "This script is intended to be ran directly after using archinstall to install the hyprland profile. Continue? [Y/n] " continue_install

case $continue_install in
  [yY] )
    echo -e "Continuing installation..."
    ;;
  * )
    echo -e "Aborting installation..."
    ;;
esac

# Installs base packages
cd ~
sudo pacman -Syu aspnet-runtime base-devel blueman cifs-utils curl dotnet-runtime dotnet-sdk fastfetch fzf gcc ghostty git github-cli hypridle hyprlock hyprpaper jdk-openjdk kitty libreoffice-fresh man maven network-manager nm-connection-editor nvim nodejs npm obsidian ripgrep stow tmux tree ttf-font-awesome $(pacman -Sgq nerd-fonts) unzip waybar zoxide zsh
# sudo pacman -S $(pacman -Sgq nerd-fonts) # Uncomment this line and remove from above line if error is thrown

# Clones and Installs yay
git clone https://aur.archlinux.org/yay
cd yay
makepkg -si
cd ~

# Installs yay packages
yay -S google-chrome hyprshot mirage visual-studio-code-bin

# Downloads TPM and Catppuccin theme for TMUX
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Installs NPM Packages
sudo npm install -g nodemon typescript typescript-language-server @tailwindcss/language-server

# SDDM Theme
sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"

# NetworkManager setup
if [[ -f /etc/NetworkManager/conf.d/dns.conf ]]; then
  sudo mv /etc/NetworkManager/conf.d/dns.conf /etc/NetworkManager/conf.d/dns.conf.bak
  echo -e "[main]\ndns=none" | sudo tee /etc/NetworkManager/conf.d/dns.conf
fi

if [[ -f /etc/resolv.conf ]]; then # replace these with your desired nameserver/s
  sudo mv /etc/resolv.conf /etc/resolv.conf.bak
  echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4\nnameserver127.0.0.1" | sudo tee /etc/resolv.conf
fi

sudo systemctl disable --now systemd-networkd && sudo systemctl enable --now NetworkManager

# Final Setup
source ~/dotfiles/utils/scripts/stow.sh
cd && clear && fastfetch

read -p "Setup git/github? [Y/n] " setup_git
case $setup_git in
  [yY] )
    read -p "Git config name: " git_name
    read -p "Git config email: " git_email
    git config --global user.name "$git_name" && git config --global user.email "$git_email"
    gh auth login
esac

echo -e "Next Steps:\n* Run [chsh] and change user shell to /usr/bin/zsh\n* Run [tmux] and press [<ctrl>+b, i] to install tmux plugins\n* Reboot"

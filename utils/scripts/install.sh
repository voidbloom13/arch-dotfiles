#!/usr/bin/env bash

if [[ -d "$HOME/arch-dotfiles" ]] && [[ ! -d "$HOME/dotfiles" ]]; then
  echo -e "\e[1;37mRenaming \e[1;31march-dotfiles \e[1;37mto \e[1;32mdotfiles\e[1;37m...\e[0m"
  mv $HOME/arch-dotfiles/ $HOME/dotfiles
else
  echo -e "\e[1;31mError with directory structure: \e[0;37mPlease ensure no other dotfiles folder in '\e[1;32m$HOME'\e[0m"
  exit 1
fi

read -p "This script is intended to be ran directly after using archinstall to install the hyprland profile. Continue? [Y/n] " continue_install
continue_install=${continue_install:-Y}

case $continue_install in
  [yY] )
    echo -e "\e[1;32mContinuing installation...\e[0m"
    ;;
  * )
    echo -e "\e[1;31mAborting installation...\e[0m"
    exit 1
    ;;
esac

# Installs base packages
cd ~
sudo pacman -Syu aspnet-runtime base-devel blueman cifs-utils curl dotnet-runtime dotnet-sdk fastfetch fzf gcc ghostty git github-cli hypridle hyprlock hyprpaper jdk-openjdk kitty libreoffice-fresh man maven networkmanager nm-connection-editor nvim nodejs npm obsidian postgresql ripgrep stow tmux tree ttf-font-awesome $(pacman -Sgq nerd-fonts) unzip waybar zoxide zsh

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
if [[ -d "$HOME/sddm-astronaut-theme" ]]; then
	rm -rf $HOME/sddm-astronaut-theme
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"

# NetworkManager setup
if [[ -f /etc/NetworkManager/conf.d/dns.conf ]]; then
  sudo mv /etc/NetworkManager/conf.d/dns.conf /etc/NetworkManager/conf.d/dns.conf.bak
  echo -e "[main]\ndns=none" | sudo tee /etc/NetworkManager/conf.d/dns.conf
fi

if [[ -f /etc/resolv.conf ]]; then # replace these with your desired nameserver/s
  sudo mv /etc/resolv.conf /etc/resolv.conf.bak
  echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4\nnameserver 127.0.0.1" | sudo tee /etc/resolv.conf
fi

sudo systemctl disable --now systemd-networkd && sudo systemctl enable --now NetworkManager

# Final Setup
source ~/dotfiles/utils/scripts/stow.sh
cd && clear && fastfetch

# Git Config and GH Authorization
read -p "Setup git/github? [Y/n] " setup_git
setup_git=${setup_git:-Y}
case $setup_git in
  [yY] )
    read -p "Git config name: " git_name
    read -p "Git config email: " git_email
    git config --global user.name "$git_name" && git config --global user.email "$git_email"
    gh auth login
    ;;
  * )
    echo "Exiting git setup..."
    ;;
esac

# PostgreSQL Setup
echo -e "\n"
read -p "Setup postgresql? [Y/n] " setup_pqsl
setup_psql=${setup_psql:-Y}
case $setup_psql in
  [yY] )
    read -p "Where do you want to initialize the database? Enter path from root (default /var/lib/postgres/data): " db_location
    db_location=${db_location:-/var/lib/postgres/data}
    echo -e "\e[0;37mInitializing DB at \e[1;34m$db_location\e[0m."
    sudo -u postgres initdb -D "$db_location"
    echo -e "\e[0;37mEnabling \e[1;34mpostgresql.service\e[0m."
    sudo systemctl enable --now postgresql
    echo -e "\e[0;37mCreating a new \e[1;34mPostgreSQL User\e[0m."
    sudo -u postgres createuser --interactive
    echo -e "\n\e[1;37mNext: Create a new database using \e[1;34m[createdb <\e[0;34mmyDatabaseName>]\e[0m\n"
    ;;
  * )
    echo -e "To set up \e[1;34mPostgreSQL\e[0m, follow instructions in the \e]8;;https://wiki.archlinux.org/title/PostgreSQL\a\e[1;4;36mArch Wiki\e[0m\e]8;;\a"
    ;;
esac

echo -e "\e[1;37mNext Steps\e[0m:\n* Run \e[1;31m[chsh]\e[0m and change user shell to \e[1;31m/usr/bin/zsh\e[0m\n* Run \e[1;32m[tmux]\e[0m and press \e[1;32m[<ctrl>+b, i]\e[0m to install tmux plugins\n* Reboot"

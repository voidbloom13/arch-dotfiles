#!/usr/bin/env bash

function gnome_setup {
    sudo pacman -Syu \
        gnome \
        gnome-tweaks \
        extension-manager
    yay -S gdm-settings
}

function hypr_setup {
    # Hyrpland-specific Packages
    sudo pacman -S \
        blueman \
        brightnessctl \
        hypridle \
        hyprlock \
        hyprpaper \
        networkmanager \
        nm-connection-editor \
        nwg-dock-hyprland \
        pipewire \
        swaync \
        waybar \
        wireplumber
    yay -S \
        hyprshot \
        mirage

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
}

function create_symlinks {
    local dotfiles_dir="$HOME/.dotfiles"
    local dotfiles_target="$HOME"

    # 1. Top-level items in $dotfiles_dir
    find "$dotfiles_dir" -mindepth 1 -maxdepth 1 | while IFS= read -r item; do
        name=$(basename "$item")
        [[ "$name" == ".git" ]] && continue

        if [[ -f "$item" ]]; then
            rel="${item#$dotfiles_dir/}"
            dest="$dotfiles_target/$rel"
            if [[ -e "$dest" && ! -L "$dest" ]]; then
                echo "Backing up $dest -> ${dest}.bak_$(date +%F_%H:%M:%S)"
                mv "$dest" "${dest}.bak_$(date +%F_%H:%M:%S)"
            fi
        fi

        if [[ -d "$item" ]]; then
            # 2. One level deeper for subdirs (e.g. .config/nvim)
            find "$item" -mindepth 1 -maxdepth 1 | while IFS= read -r sub; do
                rel="${sub#$dotfiles_dir/}"
                dest="$dotfiles_target/$rel"
                if [[ -e "$dest" && ! -L "$dest" ]]; then
                    echo "Backing up $dest -> ${dest}.bak_$(date +%F_%H:%M:%S)"
                    mv "$dest" "${dest}.bak_$(date +%F_%H:%M:%S)"
                fi
            done
        fi
    done
    echo "Running stow..."
    stow -v -t "$dotfiles_target" -d "$dotfiles_dir" .
}

function dotfiles_setup {
    local dotfiles_repo="https://github.com/voidbloom13/arch-dotfiles"
    local dotfiles_dir="$HOME/.dotfiles"
    local temp_dir="$HOME/repo_dotfiles"

    echo -e "\e[1;44;87m             Import dotfiles?             \e[0m"
    read -p "Would you like to sync dotfiles? [Y/n] " dotfiles_setup
    dotfiles_setup=${dotfiles_setup:-Y}
    case $dotfiles_setup in
        [yY] )
            echo "Importing dotfiles now..."
            mkdir -p $dotfiles_dir
            git clone $dotfiles_repo $temp_dir
            rsync -av --backup --backup-dir="$dotfiles_dir/.backups" --suffix=".bak" $temp_dir/.dotfiles/ $dotfiles_dir
            rm -rf $temp_dir
            echo "Import complete."
            create_symlinks
            ;; 
        [nN] )
            echo "Skipping dotfiles import."
            ;; 
        * )
            echo "Skipping dotfiles import."
            ;; 
    esac
}

function git_setup {
    # Git Config and GH Authorization
    echo -e "\e[1;44;87m             Git and Github Setup             \e[0m"
    read -p "Setup git/github? [Y/n] " setup_git
    setup_git=${setup_git:-Y}
    case $setup_git in
        [yY] )
            read -p "Git config name: " git_name
            read -p "Git config email: " git_email
            git config --global user.name "$git_name" && git config --global user.email "$git_email"
            gh auth login
            ;; 
        [nN] )
            echo "Exiting git setup..."
            ;; 
        * )
            echo "Exiting git setup..."
            ;; 
    esac
}

function main {
    # Installs base packages
    cd $HOME
    sudo pacman -Syu \
        aspnet-runtime \
        base-devel \
        bat \
        cifs-utils \
        curl \
        docker \
        dotnet-runtime \
        dotnet-sdk \
        fastfetch \
        flatpak \
        fzf \
        gcc \
        ghostty \
        git \
        github-cli \
        jdk-openjdk \
        man \
        maven \
        nvim \
        nodejs \
        npm \
        pgcli \
        postgresql \
        ripgrep \
        rsync \
        stow \
        tailscale \
        tmux \
        tree \
        ttf-font-awesome \
        $(pacman -Sgq nerd-fonts) \
        unzip \
        zip \
        zoxide \
        zsh

    # Clones and Installs yay
    git clone https://aur.archlinux.org/yay
    cd yay
    makepkg -si
    cd $HOME

    # Installs SDKMan and Spring CLI
    curl -s "https://get.sdkman.io" | bash
    source $HOME/.sdkman/bin/sdkman-init.sh
    sdk install springboot

    # Downloads TPM and Catppuccin theme for TMUX
    mkdir -p ~/.config/tmux/plugins/catppuccin
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

    # Installs NPM Packages
    sudo npm install -g \
        @angular/cli \
        @angular/language-server \
        @google/gemini-cli \
        nodemon \
        prettier-plugin-tailwindcss \
        typescript \
        typescript-language-server \
        @tailwindcss/language-server

    # Sets up additional Hyprland/Gnome packages
    echo -e "\e[1;44;87m             Additional DE Packages             \e[0m"
    echo "[1] to set up Gnome Desktop Environment"
    echo "[2] to set up Hyprland Profile"
    read -p "Default [1]: " de_setup
    de_setup=${de_setup:-1}
    case $de_setup in
        1 )
            gnome_setup
            ;; 
        2 )
            hypr_setup
            ;; 
        * )
            echo "No option selected. Skipping additional setup..."
            ;; 
    esac

    # Final Setup
    sudo systemctl enable --now tailscaled
    sudo systemctl enable --now docker
    sudo usermod -aG docker $USER
    cd $HOME 
    dotfiles_setup
    git_setup
    clear && fastfetch

    echo -e "\e[1;37mNext Steps\e[0m:"
    echo -e "* Run \e[1;33m[sudo tailscale up]\e[0m and follow the link to set up \e[1;33mTailscale VPN\e[0m"
    echo -e "* Run \e[1;35m[chsh]\e[0m and change user shell to \e[1;35m/usr/bin/zsh\e[0m"
    echo -e "* Run \e[1;32m[tmux]\e[0m and press \e[1;32m[<ctrl>+b, i]\e[0m to install tmux plugins"
    echo -e "* Run \e[1;34m:MasonInstallAll\e[0m inside \e[1;34mNeovim\e[0m"
    echo -e "* \e[1;84msudo nvim /etc/pacman.conf\e[0m, uncomment lib32 section, and \e[1;84msudo pacman -Syu steam\e[0m to install Steam"
}

main

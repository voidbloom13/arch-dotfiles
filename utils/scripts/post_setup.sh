#!/usr/bin/env bash

echo -e "This script runs through setting up \e[1;31mOpenWebUI with Ollama\e[0m, \e[1;35mGit/Github\e[0m configuration and authentication, and \e[1;34mPostgreSQL\e[0m setup."

# Ollama and Open-WebUI Setup
echo -e "\n"
read -p "Setup Open-WebUI and Ollama? [Y/n] " setup_ai
setup_ai=${setup_ai:-Y}
case $setup_ai in
  [yY] )
    pci_devices=$(lspci -nn | grep -i VGA)
    if echo "$pci_devices" | grep -q NVIDIA; then
      sudo pacman -Syu nvidia-container-toolkit
    fi
    sudo systemctl enable --now docker
    sudo usermod -aG docker $USER
    sudo docker run -d -p 3000:8080 --gpus=all -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
    echo -e "\e[1mNext Steps: \e[0mOpen Open-WebUI by clicking the icon or pressing <SUPER+C> and install some models."
    ;;
  * )
    echo "Skipping AI Setup..."
    ;;
esac

# Git Config and GH Authorization
echo -e "\n"
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

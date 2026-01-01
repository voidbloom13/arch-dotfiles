#!/usr/bin/env bash

echo -e "This script runs through setting up \e[1;35mGit/Github\e[0m configuration and authentication and \e[1;34mPostgreSQL\e[0m setup."

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
  [nN] )
    echo "Exiting git setup..."
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
  [nN] )
    echo -e "To set up \e[1;34mPostgreSQL\e[0m, follow instructions in the \e]8;;https://wiki.archlinux.org/title/PostgreSQL\a\e[1;4;36mArch Wiki\e[0m\e]8;;\a"
    ;;
  * )
    echo -e "To set up \e[1;34mPostgreSQL\e[0m, follow instructions in the \e]8;;https://wiki.archlinux.org/title/PostgreSQL\a\e[1;4;36mArch Wiki\e[0m\e]8;;\a"
    ;;
esac

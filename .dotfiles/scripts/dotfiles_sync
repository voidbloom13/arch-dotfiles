#!/usr/bin/env bash

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

  echo -e "\e[1;44;87m                  Sync dotfiles?                  \e[0m"
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

dotfiles_setup

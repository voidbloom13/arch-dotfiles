#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles/.dotfiles"
DOTFILES_TARGET="$HOME"

backup_conflicts() {
  # 1. Top-level items in $DOTFILES_DIR
  find "$DOTFILES_DIR" -mindepth 1 -maxdepth 1 | while IFS= read -r item; do
    name=$(basename "$item")
    [[ "$name" == ".git" ]] && continue

    if [[ -f "$item" ]]; then
      rel="${item#$DOTFILES_DIR/}"
      dest="$DOTFILES_TARGET/$rel"
      if [[ -e "$dest" && ! -L "$dest" ]]; then
        echo "Backing up $dest -> ${dest}_bak"
        mv "$dest" "${dest}_bak"
      fi
    fi

    if [[ -d "$item" ]]; then
      # 2. One level deeper for subdirs (e.g. .config/nvim)
      find "$item" -mindepth 1 -maxdepth 1 | while IFS= read -r sub; do
        rel="${sub#$DOTFILES_DIR/}"
        dest="$DOTFILES_TARGET/$rel"
        if [[ -e "$dest" && ! -L "$dest" ]]; then
          echo "Backing up $dest -> ${dest}_bak"
          mv "$dest" "${dest}_bak"
        fi
      done
    fi
  done
}

main() {
  backup_conflicts
  echo "Running stow..."
  stow -v -t "$DOTFILES_TARGET" -d "$DOTFILES_DIR" .
}

main


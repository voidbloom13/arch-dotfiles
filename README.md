# My Arch Linux Dotfiles

### Key Features
- Hyprland Tiling Window Manager for seamlessly switching between windows
- Your choice of Kitty or Ghostty for terminal emulation
![Screenshot of terminals](https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-terminals.png)
- Custom Oh-My-Posh Theme with transient prompt *(based on Catppuccin)*
- Awesome Neovim config inspired by NvChad
![Screenshot of NVIM](https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-nvim.png)
- Hyprlock and Hypridle to keep your device secure
![Screenshot of Hyprlock](https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-hyprlock.png)
- Hyprpaper for managing wallpapers
- Hyprshot to capture your screen
- Sleek Waybar config to track Hyprland workspaces and device metrics
![Screenshot of waybar](https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-waybar.png)
- Using [Keyitdev's SDDM Astronaut Theme](https://github.com/Keyitdev/sddm-astronaut-theme) (hyprland_kath preset) for my SDDM Login Theme

### How to Use
*Note: This setup is meant to be used directly after a fresh archinstall using the hyprland profile, choosing pipewire as your audio driver, and importing the installation media network configuration.*
*If you are using a **dotfiles** folder in your $HOME directory, make sure to back it up and delete, rename, or move the directory.*
1. Update your system and install git using `sudo pacman -Syu git`
2. Clone the repo from your home directory `cd ~ && git clone https://github.com/voidbloom13/arch-dotfiles`
3. Run the installation script using `bash ~/arch-dotfiles/utils/scripts/install.sh`
4. Change your shell using `chsh` to /usr/bin/zsh and install `tmux` plugins by pressing [ \<ctrl\>+b, i ].
5. `rm -rf ~/dotfiles/.git` and set up your own repo to track your personalized changes.

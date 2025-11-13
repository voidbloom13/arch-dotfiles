# My Arch Linux Dotfiles

## Key Features
<div style="display:flex;align-items:center;">
    <p>Hyprland Tiling Window Manager for seamlessly switching between windows</p>
    <img alt="Screenshot of Hyprland Tiling" src="https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland.png" style="width:50%;" />
    <p>Your choice of Kitty or Ghostty for terminal emulation</p>
    <img alt="Screenshot of terminals" src="https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-terminals.png" style="width:50%;" />
    <p>Custom Oh-My-Posh Theme with transient prompt <i>based on Catppuccin)</i></p>
    <img alt="Screenshot of OMP Theme" src="https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/omp-theme.png" style="width:50%;" />
    <p>Awesome Neovim config inspired by NvChad</p>
    <img alt="Screenshot of NVIM" src="https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-nvim.png" style="width:50%;" />
    <p>Gemini CLI for integrated AI</p>
    <img alt="Screenshot of Gemini" src="https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/gemini.png" style="width:50%;" />
    <p>Hyprlock and Hypridle to keep your device secure</p>
    <img alt="Screenshot of Hyprlock" src="https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-hyprlock.png" style="width:50%;" />
    <p>Sleek Waybar config to track Hyprland workspaces and device metrics</p>
    <img alt="Screenshot of waybar" src="https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-waybar.png" style="width:50%;" />
    <p>Simple, yet elegant, dock using <a href="https://github.com/nwg-piotr/nwg-dock-hyprland">nwg-dock-hyprland</a></p>
    <img alt="Screenshot of dock" src="https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-dock.png" style="width:50%;" />
    <p>Wofi theme that matches waybar and nwg-dock</p>
    <img alt="Screenshot of Wofi" src="https://github.com/voidbloom13/arch-dotfiles/blob/main/utils/assets/hyprland-wofi.png" style="width:50%;" />
    <p>Hyprpaper for managing wallpapers</p>
    <p>Hyprshot to capture your screen</p>
    <p>Using <a href="https://github.com/Keyitdev/sddm-astronaut-theme">Keyitdev's SDDM Astronaut Theme</a> <i>hyprland_kath preset</i> for my SDDM Login Theme</p>
</div>

## How to Use
*Note: This setup is meant to be used directly after a fresh archinstall using the hyprland profile, choosing pipewire as your audio driver, and importing the installation media network configuration.*
*If you are using a **dotfiles** folder in your $HOME directory, make sure to back it up and delete, rename, or move the directory.*
1. Update your system and install git using `sudo pacman -Syu git`
2. Clone the repo from your home directory `cd ~ && git clone https://github.com/voidbloom13/arch-dotfiles`
3. Run the installation script using `bash ~/arch-dotfiles/utils/scripts/install.sh`
4. Follow the post-install instructions that display after the installation is complete.
5. `rm -rf ~/dotfiles/.git` and set up your own repo to track your personalized changes.

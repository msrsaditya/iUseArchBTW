#!/bin/sh

# Install Apps
sudo pacman -Syu --noconfirm bemenu-wayland bluez bluez-utils brightnessctl curl dunst ffmpeg foot fzf gammastep git grim gvfs-mtp htop i3blocks lf libnotify libqalculate man-db mpv mtpfs neofetch neovim networkmanager noto-fonts-emoji otf-font-awesome pavucontrol pcmanfm-gtk3 polkit p7zip slurp sway swaybg swayimg swaylock tar ttf-jetbrains-mono-nerd unrar unzip wf-recorder reflector upower wget wireless_tools wl-clipboard wlroots xdg-utils yt-dlp zathura zathura-pdf-poppler zsh zsh-autosuggestions zsh-syntax-highlighting 
# Install AUR Manager
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd
sudo rm -rf yay

# Install AUR Apps
yay brave-bin
yay autotiling
yay jmtpfs

# Remove Orphaned Packages 
sudo pacman -Rns $(pacman -Qdtq)

# Create Necessary Folders
sudo mkdir -p ~/Downloads
sudo mkdir -p ~/.config/dunst/
sudo mkdir -p ~/.config/foot/
sudo mkdir -p ~/.config/i3blocks/
sudo mkdir -p ~/.config/lf/
sudo mkdir -p ~/.config/mpv/
sudo mkdir -p ~/.config/nvim/
sudo mkdir -p ~/.config/sway/
sudo mkdir -p ~/.config/zathura/
sudo mkdir -p ~/.config/gtk-3.0/
sudo mkdir -p /usr/local/bin/Scripts/Battery/
sudo mkdir -p /usr/local/bin/Scripts/Bluetooth/
sudo mkdir -p /usr/local/bin/Scripts/Network/
sudo mkdir -p /usr/local/bin/Scripts/Sound/
sudo mkdir -p /usr/local/bin/Scripts/Tools/
sudo mkdir -p ~/.local/share/Trash/files

# Download Wallpaper
sudo wget -P ~/Downloads -O Downloads/Wallpaper.png https://4kwallpapers.com/images/wallpapers/iron-man-marvel-superheroes-amoled-pitch-black-minimal-art-7680x6200-6293.png

## Copy Dotfiles from Git Repo to System

# Applications
sudo cp ~/dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc
sudo cp ~/dotfiles/foot/foot.ini ~/.config/foot/foot.ini
sudo cp ~/dotfiles/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
sudo cp ~/dotfiles/git/gitconfig ~/.gitconfig
sudo cp ~/dotfiles/i3blocks/config ~/.config/i3blocks/config
sudo cp ~/dotfiles/lf/colors ~/.config/lf/colors
sudo cp ~/dotfiles/lf/icons ~/.config/lf/icons
sudo cp ~/dotfiles/lf/lfrc ~/.config/lf/lfrc
sudo cp ~/dotfiles/mpv/input.conf ~/.config/mpv/input.conf
sudo cp ~/dotfiles/mpv/mpv.conf ~/.config/mpv/mpv.conf
sudo cp ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
sudo cp ~/dotfiles/sway/config ~/.config/sway/config
sudo cp ~/dotfiles/zathura/zathurarc ~/.config/zathura/zathurarc
sudo cp ~/dotfiles/zsh/zshrc ~/.zshrc
sudo cp ~/dotfiles/mimeapps.list ~/.config/mimeapps.list
sudo cp ~/dotfiles/git/gitconfig ~/.config/.gitconfig

# Scripts
sudo cp ~/dotfiles/scripts/Battery/battery.sh /usr/local/bin/Scripts/Battery/battery.sh
sudo cp ~/dotfiles/scripts/Bluetooth/blueauto.sh /usr/local/bin/Scripts/Bluetooth/blueauto.sh
sudo cp ~/dotfiles/scripts/Bluetooth/blueicon.sh /usr/local/bin/Scripts/Bluetooth/blueicon.sh
sudo cp ~/dotfiles/scripts/Bluetooth/blueoff.sh /usr/local/bin/Scripts/Bluetooth/blueoff.sh
sudo cp ~/dotfiles/scripts/Bluetooth/bluesearch.sh /usr/local/bin/Scripts/Bluetooth/bluesearch.sh
sudo cp ~/dotfiles/scripts/Network/essid.sh /usr/local/bin/Scripts/Network/essid.sh
sudo cp ~/dotfiles/scripts/Network/wifi-connect.sh /usr/local/bin/Scripts/Network/wifi-connect.sh
sudo cp ~/dotfiles/scripts/Sound/sound.sh /usr/local/bin/Scripts/Sound/sound.sh
sudo cp ~/dotfiles/scripts/Tools/brightness.sh /usr/local/bin/Scripts/Tools/brightness.sh
sudo cp ~/dotfiles/scripts/Tools/calc.sh /usr/local/bin/Scripts/Tools/calc.sh
sudo cp ~/dotfiles/scripts/Tools/date.sh /usr/local/bin/Scripts/Tools/date.sh
sudo cp ~/dotfiles/scripts/Tools/emoji /usr/local/bin/Scripts/Tools/emoji
sudo cp ~/dotfiles/scripts/Tools/emoji.sh /usr/local/bin/Scripts/Tools/emoji.sh
sudo cp ~/dotfiles/scripts/Tools/movie.sh /usr/local/bin/Scripts/Tools/movie.sh
sudo cp ~/dotfiles/scripts/Tools/power.sh /usr/local/bin/Scripts/Tools/power.sh
sudo cp ~/dotfiles/scripts/Tools/share.sh /usr/local/bin/Scripts/Tools/share.sh
sudo cp ~/dotfiles/scripts/Tools/tools.sh /usr/local/bin/Scripts/Tools/tools.sh

# Give Execution Permissions to All Scripts in /usr/local/bin/Scripts/
sudo chmod -R +x /usr/local/bin/Scripts/

# Systemd Auto/Start Commands
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
bluetoothctl power on

# Change Shell to zsh
chsh -s /usr/bin/zsh

# AutoLogin Configure
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf >/dev/null <<EOL
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin shashank --noclear %I foot
ExecStartPre=-/bin/sh -c "TERM=linux setterm --blank 0 >/dev/tty1"
EOL
sudo systemctl enable getty@tty1.service

# Git SSH Configure

ssh-keygen -t ed25519 -C "msrsaditya@gmail.com

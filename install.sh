#!/bin/bash

# Install the 'base-devel' group (if it is not installed already)
sudo pacman -S --needed base-devel

# Install the 'paru' AUR helper
sudo pacman -S --noconfirm --needed git && git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin && cd /tmp/paru-bin && makepkg -si && cd

# Essentials
xorg="xorg-server xorg-xinit"
gpu="xf86-video-intel"
wifi="broadcom-wl"
audio="pulseaudio pulseaudio-alsa"
touchpad="libinput"
webcam="linux-headers v4l2loopback-dkms" # FIXES WEBCAM RANDOMLY NOT WORKING
batterysaver="tlp powertop"
bluetooth="bluez bluez-utils bcm43142a0-firmware" # AUR
backlight="acpilight"
fonts="ttf-dejavu terminus-font nerd-fonts-dejavu-complete" # AUR

ESSENTIALS="
    $xorg
    $gpu
    $wifi
    $audio
    $touchpad
    $webcam
    $batterysaver
    $bluetooth
    $backlight
    $fonts
    "

# WM
i3="i3-gaps i3blocks sxhkd"

WM="
    $i3
    "

# Aestethics
iconfonts="ttf-font-awesome"
emojifonts="ttf-joypixels"
icontheme="papirus-icon-theme"
gtktheme="arc-gtk-theme lxappearance" # CLONE THEMES FROM GITHUB

AESTETHICS="
    $iconfonts
    $emojifonts
    $icontheme
    $gtktheme
    "

# Software
shell="zsh zsh-syntax-highlighting dash dashbinsh" # AUR
terminal="alacritty"
#dropdownterminal="tdrop-git" # Does not build from the AUR
#launcher="dmenu" # Clone dmenu build
notifications="libnotify dunst"
browser="brave-bin" # AUR
calculator="bc"
calendar="calcurse"
compositor="xcompmgr"
taskmanager="htop"
audiomixer="pulsemixer"
filemanager="ranger ueberzug dragon-drag-and-drop" # AUR
mediaplayer="mpv"
musicplayer="mpd ncmpcpp mpc"
imageviewer="sxiv"
imageeditor="gimp"
webcammanager="guvcview"
displaysettings="xorg-xrandr arandr"
nightlight="sct" # AUR
printscreen="maim"
ssh="openssh"
pdfviewer="zathura zathura-pdf-poppler"
unclutter="unclutter"
locate="mlocate"
manuals="man-db man-pages"
documents="libreoffice hunspell-en_us hunspell-hu hunspell-ro texlive-most pandoc" # AUR
spreadsheets="libxlsxwriter sc-im-git" # AUR
ocr="tesseract tesseract-data-eng tesseract-data-hun tesseract-data-ron" # AUR
#sync="syncthing" # Not as useful as I thought
fstools="dosfstools mtools simple-mtpfs ntfs-3g" # AUR

SOFTWARE="
    $shell
    $terminal
    $dropdownterminal
    $launcher
    $notifications
    $browser
    $calculator
    $calendar
    $compositor
    $taskmanager
    $audiomixer
    $filemanager
    $mediaplayer
    $imageviewer
    $imageeditor
    $webcammanager
    $displaysettings
    $nightlight
    $printscreen
    $ssh
    $pdfviewer
    $unclutter
    $locate
    $manuals
    $documents
    $spreadsheets
    $ocr
    $sync
    $fstools
    "

# My script dependencies
DEPENDENCIES="
    lm_sensors
    xss-lock
    xorg-xset
    xdotool
    xclip
    exa
    playerctl
    imagemagick
    xwallpaper
    wmctrl
    rar
    unzip
    zip
    rsync
    reflector
    i3lock
    youtube-dl
    pamixer
    xdg-user-dirs
    xorg-xrdb
    acpi_call
    fzf
    cronie
    xorg-xinput
    "

# Set up the install command
install="paru -Syu --needed
    $ESSENTIALS
    $WM
    $AESTETHICS
    $SOFTWARE
    $DEPENDENCIES
    "

# Run the install command
$install

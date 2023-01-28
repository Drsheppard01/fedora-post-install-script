#! /bin/bash
# ./scripts/installMyDailyApps.sh
# SPDX-License-Identifier: GPL-3.0-or-later

# fedora-post-install-script
# Copyright (C) 2022 davidhoang05022009(Hoàng Minh Thiên)
# This program comes with ABSOLUTELY NO WARRANTY
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

echo -e "The script will install the following packages: \n\npangox-compat (Fedora 32) \nredhat-lsb-core \nanydesk \ngoogle-chrome-stable \nvlc \nobs-studio \n@virtualization \nshotcut \
\nseahorse \nclang \ncmake \nninja-build \npkg-config \ngtk3-devel \nxz-devel \nvariety \nDiscord with BetterDiscord and Dracula theme \nSignal \nTelegram \nRemmina \nGeoGebra \nBitwarden \nDocker and Docker Desktop for Linux (Rootless) \
\nFirfox from Flatpak \x1B[31m(WILL REMOVE NORMAL FIREFOX PACKAGE)\x1B[0m \nGoogle Chrome \nhtop \nneofetch \nxclip \ngnome-tweaks \nmicro \nVS Code \ngh \nkitty \nFlutter SDK (will be installed at ~/flutter)"
echo -e "\nAnd then set Firefox Flatpak as the default browser"
while true; do
    read -rp "Continue? [y/N]: " yn
    
    case $yn in
    [Yy]*) 
        echo "Installing my daily apps"
        # Pre-install brave
        
        sudo dnf install dnf-plugins-core -y
        sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo -y
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc -y
        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
       
       
        sudo dnf install micro lsd bottom brave-browser telegram-desktop neofetch


        # Download appimaged for scanning AppImages
        axel -n 20 "https://github.com/probonopd/go-appimage/releases/download/continuous/appimaged-715-x86_64.AppImage" -o appimaged-x86_64.AppImage
        sudo mv ./appimaged-x86_64.AppImage /opt/
        
        # Download official Bitwarden AppImage
        axel -n 20 "https://vault.bitwarden.com/download/?app=desktop&platform=linux" -o Bitwarden-x86_64.AppImage
        sudo mv ./Bitwarden-x86_64.AppImage /opt/

        # Initialize the appimaged
        chmod u+x /opt/*.AppImage
        /opt/appimaged-x86_64.AppImage
        
        mkdir "$HOME"/.config/kitty/
        # Copy all of my config files to the config folder
        cp -r dotfiles/kitty/ ~/.config/kitty
       
        echo "Done configuring and install my daily apps"
        
        break
    ;; 

    *) 
        echo "Aborted"
        break
    ;;
    esac
done

read -rp "Press any key to continue" _

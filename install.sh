#!/bin/bash
# shellcheck disable=SC2046

pwd=$(pwd)

GitRepos="$HOME/GitRepos"
Suckless="$GitRepos/Suckless"
tools="$GitRepos/tools"

pkglist="pkg/pkglist"
gpclist="pkg/nvidia"
aurlist="pkg/aurlist"

yaylink="https://aur.archlinux.org/yay.git"
sldwm="https://git.suckless.org/dwm"
sldmenu="https://git.suckless.org/dmenu"
mydwm="https://github.com/TTlaugh/dwm"
mydmenu="https://github.com/TTlaugh/dmenu"

createDir() {
    [ ! -d "$GitRepos" ] && mkdir -p "$GitRepos"
    [ ! -d "$Suckless" ] && mkdir -p "$Suckless"
    [ ! -d "$tools"    ] && mkdir -p "$tools"
}

install_pacpack(){
    cd pkg && invalid_packages_name="$(./invalidname)" && cd ..
    if [ -n "$invalid_packages_name" ]; then
        echo "There are some packages with invalid names:"
        echo "$invalid_packages_name"
        read -r -p "Do you want to continue (they will be ignored)? [Y/n] " yn
        case $yn in
            ""|[Yy]* ) sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort $pkglist)) ;;
            * ) exit 1 ;;
        esac
    fi
}
install_graphics() {
    read -r -p "Do you want to install nvidia driver? [Y/n] " yn
    case $yn in
        ""|[Yy]* ) sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort $gpclist))
            read -r -p "Do you want to install Envycontrol? [Y/n] " yn
            case $yn in
                ""|[Yy]* ) yay -S envycontrol ;;
                * ) return ;;
            esac
            ;;
        * ) return ;;
    esac
}
install_yaypack() {
    yay -S --needed - < "$aurlist"
}
install_yay() {
    cd "$tools" && git clone "$yaylink" && cd yay && makepkg -si
    cd "$pwd" || exit
}
install_sl() {
    cd "$Suckless" && \
    git clone "$sldmenu" && cd dmenu && \
        git branch mydmenu && \
        git checkout mydmenu && \
        git pull "$mydmenu" master && \
        sudo make clean install
    cd "$Suckless" && \
    git clone "$sldwm" && cd dwm && \
        git branch mydwm && \
        git checkout mydwm && \
        git pull "$mydwm" master && \
        sudo make clean install
    cd "$pwd" || exit
}
apply_dotfiles() {
    cd "$pwd" && stow --no-folding -v -R -t ~ .
}
copy_symblink() {
    cd "$pwd" || exit
    cp -a ".xprofile" "$HOME"
    cp -a ".local/share/bg" "$HOME/.local/share/bg"
}
disable_services() {
    # start pipewire (with pipewire-pulse, wireplumber) via xprofile instead of systemd
    sudo systemctl --global disable pipewire pipewire-pulse wireplumber
}
enable_services() {
    printf "Please enable these services manually: \`systemctl enable ...\`
    - Networkmanager: NetworkManager.service
    - Thermald:       thermald.service (*)
    - Ufw:            ufw.service (Then run: ufw enable)
    - TRIM:           fstrim.timer (*)
    - Bluetooth:      bluetooth.service (Don't run if you not use Bluetooth)
(*) Check the wiki to ensure your system can do it
Press any key to continue..."
    read -r _
}

createDir
set -e
install_pacpack
install_graphics
install_yay
install_yaypack
install_sl
apply_dotfiles
copy_symblink
sudo usermod -aG wheel,video,audio,input,optical,storage "$USER"
printf "FONT=ter-132n" | sudo tee -a /etc/vconsole.conf
sudo cp "misc/etc/X11/xorg.conf.d/30-touchpad.conf" "/etc/X11/xorg.conf.d/30-touchpad.conf"
chsh -s "$(which zsh)"
disable_services
enable_services

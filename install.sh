#!/bin/bash

GitRepos="$HOME/GitRepos"
Suckless="$HOME/Suckless"

pkglist="pkg/pkglist"
aurlist="pkg/aurlist"

yaylink="https://aur.archlinux.org/yay.git"
sldwm="https://git.suckless.org/dwm"
sldmenu="https://tools.suckless.org/dmenu"
mydwm="https://github.com/nguyenletientrien/dwm"

createDir() {
    [[ ! -d "$GitRepos" ]] && mkdir -p "$GitRepos"
    [[ ! -d "$Suckless" ]] && mkdir -p "$Suckless"
}

install_pacpack(){
    sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort $pkglist))
}
install_yaypack() {
    yay -S - < "$aurlist"
}
install_yay() {
    cd "$GitRepos" || exit
    git clone "$yaylink"
    cd yay || exit
    makepkg -si
    cd ../..
}
install_sl() {
    cd "$Suckless" || exit
    git clone "$sldmenu"
    (cd dmenu || exit) && sudo make clean install && cd ..
    git clone "$sldwm"
    (cd dwm || exit) && \
        git branch mydwm && \
        git checkout mydwm && \
        git pull "$mydwm" master && \
        sudo make clean install && cd ..
    cd ..
}

createDir
install_pacpack
install_yay
install_yaypack
install_sl

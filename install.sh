#!/bin/bash

pwd=$(pwd)

GitRepos="$HOME/GitRepos"
Suckless="$GitRepos/Suckless"
tools="$GitRepos/tools"

pkglist="pkg/pkglist"
aurlist="pkg/aurlist"

yaylink="https://aur.archlinux.org/yay.git"
sldwm="https://git.suckless.org/dwm"
sldmenu="https://git.suckless.org/dmenu"
mydwm="https://github.com/TTlaugh/dwm"
mydmenu="https://github.com/TTlaugh/dmenu"

createDir() {
    [[ ! -d "$GitRepos" ]] && mkdir -p "$GitRepos"
    [[ ! -d "$Suckless" ]] && mkdir -p "$Suckless"
    [[ ! -d "$tools"    ]] && mkdir -p "$tools"
}

install_pacpack(){
    # shellcheck disable=SC2046
    sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort $pkglist))
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

createDir
install_pacpack
install_yay
install_yaypack
install_sl
apply_dotfiles
copy_symblink
sudo usermod -aG wheel,video,audio,input,optical,storage "$USER"
printf "FONT=ter-132n" | sudo tee -a /etc/vconsole.conf
sudo cp "misc/etc/X11/xorg.conf.d/30-touchpad.conf" "/etc/X11/xorg.conf.d/30-touchpad.conf"
chsh -s "$(which zsh)"

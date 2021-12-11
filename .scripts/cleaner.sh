#!/usr/bin/env bash

# Description: Arch linux cleanup script.
# Dependencies: pacman-contrib

set -euo pipefail

set_colors() {
    if [ -t 1 ]; then
        RAINBOW="
          $(printf '\033[38;5;196m')
          $(printf '\033[38;5;202m')
          $(printf '\033[38;5;226m')
          $(printf '\033[38;5;082m')
          $(printf '\033[38;5;226m')
          $(printf '\033[38;5;202m')
          $(printf '\033[38;5;196m')
        "
        RED=$(printf '\033[31m')
        GREEN=$(printf '\033[32m')
        YELLOW=$(printf '\033[33m')
        BLUE=$(printf '\033[34m')
        BOLD=$(printf '\033[1m')
        RESET=$(printf '\033[m')
    else
        RAINBOW=""
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        RESET=""
    fi
}

check_root() {
    if [[ "$(id -u)" != "0" ]]; then
        printf "%s%sYou need to run this as root script!%s\n" $BOLD $RED $RESET
        sudo true
    fi
}

print_banner() {
    clear
    printf "%s        _____  %s _     %s _____  %s ______  %s _   _  %s _____  %s ____    ${BOLD}${GREEN}        __     %s\n" $RAINBOW $RESET
    printf "%s       |  ___| %s| |    %s|  ___| %s|  __  | %s| \ | | %s|  ___| %s|  _ \\  ${BOLD}${GREEN}        /_/    %s\n" $RAINBOW $RESET
    printf "%s       | |     %s| |    %s| |_    %s| |__| | %s|  \| | %s| |_    %s| |_| |  ${BOLD}${RED}      / /        %s\n" $RAINBOW $RESET
    printf "%s       | |     %s| |    %s|  _|   %s|  __  | %s|     | %s|  _|   %s|   _/   ${BOLD}${RED}   __/_/__       %s\n" $RAINBOW $RESET
    printf "%s       | |___  %s| |__  %s| |___  %s| |  | | %s| |\  | %s| |___  %s| |\ \\  ${BOLD}${YELLOW} . /    . / . %s\n" $RAINBOW $RESET
    printf "%s       |_____| %s|____| %s|_____| %s|_|  |_| %s|_| \_| %s|_____| %s|_| \_\\ ${BOLD}${YELLOW} .////////. . %s\n" $RAINBOW $RESET
    echo
}

print_option() {
    printf "%s  [%s0%s] Check!%s\n"                                                   $BLUE $RESET $BLUE $RESET
    printf "%s  [%s1%s] Remove package cache.%s\n"                                    $BLUE $RESET $BLUE $RESET
    printf "%s  [%s2%s] Remove unused packages.%s\n"                                  $BLUE $RESET $BLUE $RESET
    printf "%s  [%s3%s] Clean the cache in your home directory.%s\n"                  $BLUE $RESET $BLUE $RESET
    printf "%s  [%s4%s] Remove old config files.%s\n"                                 $BLUE $RESET $BLUE $RESET
    printf "%s  [%s5%s] Clean Systemd journal.%s\n"                                   $BLUE $RESET $BLUE $RESET
    printf "%s  [%s6%s] Quick clean.%s\n"                                             $BLUE $RESET $BLUE $RESET
    echo
    printf "%s  [x] Exit.%s\n"                                                    $RED  $RESET
    printf "%s%sEnter your option (Default 0):%s " $BOLD $GREEN $RESET
}

option_0() {
    print_banner
    printf "${RED}Checking ...... ${RESET}\n"
    paccachesize="$(du -sh /var/cache/pacman/pkg/ | awk '{print $1}')"
    homecachesize="$(du -sh ${HOME}/.cache/ | awk '{print $1}')"
    homecachenum="$(find ${HOME}/.cache/* -type f | wc -l)"
    journalsize1="$(du -sh /var/log/journal/ | awk '{print $1}')"
    journalsize2="$(du -sh /run/log/journal/ | awk '{print $1}')"
    configfiles="$(ls -l ${HOME}/.config/ | grep -v "total" | wc -l) items"
    unpackage="$(pacman -Qtdq | wc -l || printf "") packages"
    printf "${GREEN}Done!${RESET}\n"
    printf "%s==> Package cache    :  %s/var/cache/pacman/pkg/   :%s%s$paccachesize\n%s"                    $BLUE $YELLOW $BOLD $GREEN $RESET
    printf "%s==> Home cache       :  %s${HOME}/.cache/       :%s%s$homecachesize ($homecachenum files)\n%s"  $BLUE $YELLOW $BOLD $GREEN $RESET
    printf "%s==> Systemd journal  :  %s/var/log/journal/        :%s%s$journalsize1\n%s"                    $BLUE $YELLOW $BOLD $GREEN $RESET
    printf "                        %s/run/log/journal/        :%s%s$journalsize2\n%s"                      $YELLOW $BOLD $GREEN $RESET
    printf "%s==> All config files :  %s%s$configfiles\n%s"                                                 $BLUE $BOLD $GREEN $RESET
    printf "%s==> Unused packages  :  %s%s$unpackage\n%s"                                                   $BLUE $BOLD $GREEN $RESET
    echo
    printf "%sEnter to go back.%s" $BOLD $RESET
    read
}

option_1() {
    print_banner
    printf "%s  [0] Go back <--%s\n"                                 $BLUE $RESET
    printf "%s  [1] Remove NOT installed packages from cache%s\n"    $BLUE $RESET
    printf "%s  [2] Remove ALL files from cache%s\n"                 $BLUE $RESET
    printf "%s%sEnter your option (Default 1):%s " $BOLD $GREEN $RESET
    read chosen1
    case $chosen1 in
        "") sudo pacman -Sc;;
        1)  sudo pacman -Sc;;
        2)  sudo pacman -Scc;;
        0)  return;;
        *)  return;;
    esac
    printf "\n%sDone! Enter to go back.%s" $BOLD $RESET
    read
}

option_2() {
    print_banner
    unusedpackages="$(sudo pacman -Qtdq || printf "")"
    if [[ -z "$unusedpackages" ]]; then
        printf "${BOLD}No unused packages to remove. Enter to continue.${RESET}"
    else
        sudo pacman -Rns $unusedpackages && printf "\n${BOLD}Done! Enter to go back.${RESET}"
    fi
    read
}

findcache30() {
    clear
    printf "${BOLD}${RED}Finding ......${RESET}\n"
    cache30="$(find ~/.cache/* -maxdepth 1 -type f -atime +30)"
    case $cache30 in
        "") echo "No old caches found.";;
        *)  echo "$cache30";;
    esac
}
findcache() {
    printf "${YELLOW}Enter the uninstalled package name:${RESET} "
    read upacname
    clear
    printf "${BOLD}${RED}Finding ......${RESET}\n"
    upacfind="$(find ${HOME}/.cache/* -maxdepth 1 | grep -w "$upacname" || printf "")"
    case $upacfind in
        "") printf "%s0 matches found.%s\n" ${GREEN} ${RESET};;
        *)  echo -e "$upacfind\n${GREEN}$(echo "$upacfind" | wc -l) matches found.${RESET}";;
    esac
}
option_3() {
    print_banner
    printf "     ${BOLD}${RED}!!! So dangerous to remove cache file!!!${RESET} \n"
    echo " ==> You should find manually and only delete files that are really not needed! "
    echo " ==> You can manual delete cache files of uninstalled app in ${HOME}/.cache/*     "
    echo
    printf "%sThere are some things you can do:%s\n"                         $YELLOW $RESET
    printf "%s  [0] Go back <--%s\n"                                         $BLUE $RESET
    printf "%s  [1] Find old cache files in ~/.cache/ (after 30 days)%s\n"   $BLUE $RESET
    printf "%s  [2] Find uninstalled app caches.%s\n"                        $BLUE $RESET
    echo
    printf "%s%sEnter your option (Default 0):%s "                           $BOLD $GREEN $RESET
    read chosen3
    case $chosen3 in
        1) findcache30;;
        2) findcache;;
        *) return;;
    esac
    printf "\n${BOLD}Enter to continue.${RESET}"
    read
}

findconfig() {
    printf "${YELLOW}Enter the uninstalled package name:${RESET} "
    read upacnamecfg
    clear
    printf "${BOLD}${RED}Finding ......${RESET}\n"
    upacnamecfg="$(find ${HOME}/.config/* ${HOME}/.local/share/* -maxdepth 1 | grep -w "$upacnamecfg" || printf "")"
    case $upacnamecfg in
        "") printf "%s0 matches found.%s\n" ${GREEN} ${RESET};;
        *)  echo -e "$upacnamecfg\n${GREEN}$(echo "$upacnamecfg" | wc -l) matches found.${RESET}";;
    esac
}
option_4() {
    print_banner
    echo "**********************************************************************************************"
    echo "*                                                                                            *"
    echo "* ==> Can't remove old config files automatically! You must find and remove them manually.   *"
    echo "*                                                                                            *"
    echo "* ==> You can find them at    ~/.config/                                                     *"
    echo "*                       or    ~/.local/share/                                                *"
    echo "*                                                                                            *"
    echo "**********************************************************************************************"
    echo
    read -p "Do you want to find old config files? [Y/n] " oldcfg
    if [[ "$oldcfg" = "y" ]] || [[ "$oldcfg" = "Y" ]] || [[ "$oldcfg" = "yes" ]] || [[ "$oldcfg" = "Yes" ]] || [[ -z "$oldcfg" ]]; then
        findconfig
    fi
    printf "\n%sDone! Enter to go back.%s" $BOLD $RESET
    read
}

option_5() {
    print_banner
    journalctl -p 3 -b
    printf "\n${BOLD}If you find some errors, ${GREEN}google${RESET} ${BOLD}them before deleting!${RESET}\n"
    read -p "Continue to delete? [Y/n] " djournal
    if [[ "$djournal" = "y" ]] || [[ "$djournal" = "Y" ]] || [[ "$djournal" = "yes" ]] || [[ "$djournal" = "Yes" ]] || [[ -z "$djournal" ]]; then
        sudo journalctl --vacuum-size=50M
    fi
    printf "\n%sDone! Enter to go back.%s" $BOLD $RESET
    read
}

option_6() {
    print_banner
    printf "${BOLD}${RED}Removing packages cache ......${RESET}\n"
    sudo pacman -Sc
    printf "${BOLD}${GREEN}Done! Enter to continue.${RESET}"
    read

    unusedpackages="$(sudo pacman -Qtdq || printf "")"
    if [[ "$unusedpackages" = "" ]]; then
        printf "\n${BOLD}${RED}!!! No unused packages to remove.\n${GREEN}Enter to continue.${RESET}"
    else
        printf "\n${BOLD}${RED}Removing unused packages ......${RESET}\n"
        sudo pacman -Rns $unusedpackages
        printf "${BOLD}${GREEN}Done! Enter to continue.${RESET}"
    fi
    read

    printf "\n${BOLD}${RED}Check Systemd journal ......${RESET}\n"
    journalctl -p 3 -b
    printf "\n${BOLD}If you find some errors, ${GREEN}google${RESET} ${BOLD}them before deleting!${RESET}\n"
    read -p "Continue to delete? [Y/n] " djournal
    if [[ "$djournal" = "y" ]] || [[ "$djournal" = "Y" ]] || [[ "$djournal" = "yes" ]] || [[ "$djournal" = "Yes" ]] || [[ -z "$djournal" ]]; then
        sudo journalctl --vacuum-size=50M
    fi

    printf "\n%sDone! Enter to go back.%s" $BOLD $RESET
    read
}

main() {
    set_colors
    check_root
    while :
    do
        print_banner
        print_option
        read chosen
        case "$chosen" in
            "")     option_0 ;;
            0)      option_0 ;;
            1)      option_1 ;;
            2)      option_2 ;;
            3)      option_3 ;;
            4)      option_4 ;;
            5)      option_5 ;;
            6)      option_6 ;;
            *)      exit 0 ;;
        esac
    done
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

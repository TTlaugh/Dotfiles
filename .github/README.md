# Set up Arch Linux

![](https://raw.githubusercontent.com/nguyenletientrien/Dotfiles/master/.github/qtile0.png)

<details>
  <summary>Previews</summary>

  - ***i3-wm, i3bar, pfetch, gotop.***
  ![](https://raw.githubusercontent.com/nguyenletientrien/Dotfiles/master/.github/i3.png)

  - ***Qtile, nvim, neofetch, gotop, rofi, conky, i3lock-color.***
  ![](https://raw.githubusercontent.com/nguyenletientrien/Dotfiles/master/.github/qtile1.png)
  ![](https://raw.githubusercontent.com/nguyenletientrien/Dotfiles/master/.github/qtile2.png)
  ![](https://raw.githubusercontent.com/nguyenletientrien/Dotfiles/master/.github/qtile3.png)
  ![](https://raw.githubusercontent.com/nguyenletientrien/Dotfiles/master/.github/qtile4.png)
  > [Download](https://github.com/nguyenletientrien/Wallpapers) Wallpapers.

</details>

# Table of contents

- [Installation](https://github.com/nguyenletientrien/Dotfiles#installation)
  - [Package List](https://github.com/nguyenletientrien/Dotfiles#install-packages-from-a-list)
  - [AUR Packages](https://github.com/nguyenletientrien/Dotfiles#aur-packages)
  - [Suckless](https://github.com/nguyenletientrien/Dotfiles#suckless)
  - [Optional](https://github.com/nguyenletientrien/Dotfiles#optional)
  - [Enable](https://github.com/nguyenletientrien/Dotfiles#enable)
- [Configuration](https://github.com/nguyenletientrien/Dotfiles#configuration)
- [Tips and Tricks](https://github.com/nguyenletientrien/Dotfiles#tips-and-tricks)
- [Other](https://github.com/nguyenletientrien/Dotfiles#other)

# Installation

### Install packages from a list
[pkglist.txt](https://github.com/nguyenletientrien/Dotfiles/blob/master/pkglist.txt)
```
pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))
```
> You must choose the following packages to suit your system carefully.
- Microcode: install `intel-ucode`(Intel) or `amd-ucode`(AMD).
- Graphics card, see Arch Wiki:
  - [Intel graphics](https://wiki.archlinux.org/title/Intel_graphics)
  - [AMDGPU](https://wiki.archlinux.org/title/AMDGPU)
  - [NVIDIA](https://wiki.archlinux.org/title/NVIDIA)
  - [Xorg](https://wiki.archlinux.org/title/Xorg)

### AUR Packages
> To install AUR packages: `makepkg -si`
- [yay](https://aur.archlinux.org/packages/yay)
- [all-repository-fonts](https://aur.archlinux.org/packages/all-repository-fonts)
- [nerd-fonts-complete](https://aur.archlinux.org/packages/nerd-fonts-complete)

### Suckless
> - To install Suckless softwares: `sudo make clean install`
> - To patch: `patch -p1 < your_patch_file`
- [dmenu](https://tools.suckless.org/dmenu)
- [st](https://st.suckless.org)
  - Patches: [font2](https://st.suckless.org/patches/font2), [dracula](https://st.suckless.org/patches/dracula), [alpha](https://st.suckless.org/patches/alpha), [dynamic-cursor-color](https://st.suckless.org/patches/dynamic-cursor-color), [scrollback + scrollback-mouse + scrollback-mouse-altscreen](https://st.suckless.org/patches/scrollback).

### Optional
<details>
  <summary>Click to expand!</summary>
  
  - Kdenlive
  - GIMP
  - Audacity
  - OBS
  - Simplescreenrecorder 
  - VirtualBox
  - Virt-Manager
    > - `pacman -S libvirt iptables-nft qemu virt-manager`
    > - `sudo systemctl start/enable libvirtd`
    > - `sudo usermod -G libvirt -a <username>`
  - LibreOffice 
    > *jre-openjdk* package is needed for LibreOffice Database.
  - conky
  - cmus
  - persepolis
  - onboard
  - xdotool
  - maim
  - acpi
  - pandoc
  - texlive-most
  - speedtest-cli
  - volumeicon
  - volnoti ([AUR](https://aur.archlinux.org/packages/volnoti))
  - shellcheck-bin ([AUR](https://aur.archlinux.org/packages/shellcheck-bin))
  - ttf-ms-fonts ([AUR](https://aur.archlinux.org/packages/ttf-ms-fonts))
  - teamviewer ([AUR](https://aur.archlinux.org/packages/teamviewer))
     > Note: If you use startx, you won't be able to open teamviewer
  - Powerline Fonts: [https://github.com/powerline/fonts](https://github.com/powerline/fonts)
</details>

### Enable
- lightdm: `systemctl enable lightdm`
- ufw (see Arch Wiki: [Uncomplicated Firewall](https://wiki.archlinux.org/title/Uncomplicated_Firewall))
- networkmanager: `systemctl enable NetworkManager`

# Configuration

<details>
  <summary>Unmute the sound card and disable auto mute on startup</summary>

  - Unmute:
  ```
  amixer sset Master unmute
  amixer sset Speaker unmute
  amixer sset Headphone unmute
  ```
  - Disable auto mute:
  ```
  amixer -c 0 sset "Auto-Mute Mode" Disabled
  ```
</details>

<details>
  <summary>i3</summary>

  - Copy ***i3*** folder to ***~/.config/***
  - Open ***i3/config*** file and edit for use!
  - See more: [i3-README.md](https://github.com/nguyenletientrien/Dotfiles/tree/master/.config/i3)
  - AutoTiling script: [https://github.com/nwg-piotr/autotiling](https://github.com/nwg-piotr/autotiling)
  - Set background with feh: `feh --bg-scale /path/to/picture`
</details>

<details>
  <summary>Neovim</summary>

  [See here.](https://github.com/nguyenletientrien/Dotfiles/tree/master/.github/NEOVIM.md)
</details>

<details>
  <summary>zsh</summary>

  - Copy ***zsh*** folder to ***~/.config/***
  - To use [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), git clone from repository into ***~/.config/zsh/plugins/***
    ```
    cd ~/.config/zsh/plugins
    ```
    ```
    git clone https://github.com/zsh-users/zsh-autosuggestions.git
    ```
    ```
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    ```
  - Install [Starship prompt](https://starship.rs) and copy ***starship.toml*** file to ***~/.config/***
    > Starship is available on the official repository.
</details>

<details>
  <summary>Vifm</summary>

  [See here.](https://github.com/nguyenletientrien/Dotfiles/tree/master/.github/VIFM.md)
</details>

<details>
  <summary>Kitty</summary>

  - Copy default config file to ***~/.config/***
  ```
  cp /usr/share/doc/kitty/kitty.conf /home/nltt/.config/kitty/
  ```
  - Configure
  ```
  line | config
  -----|---------------------------------------
     9 | font_family      FiraCode Nerd Font
    10 | bold_font        FiraCode Nerd Font Bold
    11 | italic_font      FiraCode Nerd Font Italic
    12 | bold_italic_font FiraCode Nerd Font Bold Italic
   762 | background_opacity 0.9
  ```
  - Theme: [Dracula](https://draculatheme.com/kitty), [TokyoNight](https://github.com/davidmathers/tokyo-night-kitty-theme)
</details>

<details>
  <summary>Dmenu</summary>

  - Edit *config.def.h*:
    - Font: `Hack Nerd Font`
    - Font size: `11`
    - Colors:
      ```
      [SchemeNorm] = { "#777c99", "#1a1b26" },
      [SchemeSel] = { "#0f0f14", "#7aa2f7" },
      ```
  - Edit *dmenu_run*
    - Add `-p "Run:"` after `dmenu "@"`
    - Example: `dmenu "$@" -p "Run:"`
</details>

<details>
  <summary>Lightdm, lightdm-slick-greeter</summary>

  #### Lightdm
  - Edit config file in ***/etc/lightdm/lightdm.conf***
  ```
  [Seat:*]
  .....
  greeter-session=lightdm-slick-greeter
  user-session=qtile
  #user-session=i3
  .....
  ```
  ##### lightdm-slick-greeter
  - Copy the picture you want to set background to ***/usr/share/backgrounds/***
  - Create slick-greeter.conf as /etc/lightdm/slick-greeter.conf and edit:
  ```
  [Greeter]
  background=/usr/share/backgrounds/<picture>
  ```
</details>

# Other

<details>
  <summary>Click to expand!</summary>

  ### Fonts
  - Roboto Mono (dunst)
  - sans (Qtile, [dwm](https://github.com/nguyenletientrien/dwm))
  - Ubuntu Nerd Font (Qtile, i3, [dwm](https://github.com/nguyenletientrien/dwm))
  - Fira Code (Kitty)
  - Hack Nerd Font (Alacritty, st, dmenu)
  
  ### Lxappearance
  - Arc Theme: [https://github.com/horst3180/Arc-theme](https://github.com/horst3180/Arc-theme)
  - Volantes Cursors: [https://www.gnome-look.org/p/1356095](https://www.gnome-look.org/p/1356095)
  - Tela circle icon theme: [https://www.gnome-look.org/p/1359276](https://www.gnome-look.org/p/1359276)
  
  ### Random color script for terminal
  - Install: [shell-color-scripts](https://aur.archlinux.org/packages/shell-color-scripts) (AUR)
  - Usage: add `colorscript random` to your **.zshrc** file.
  
  ### My Scripts
  [See here.](https://github.com/nguyenletientrien/Dotfiles/tree/master/.github/SCRIPTS.md)
</details>


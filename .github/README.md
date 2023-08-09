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
![](https://raw.githubusercontent.com/nguyenletientrien/Dotfiles/master/.github/qtile5.png)
> [Download](https://github.com/nguyenletientrien/Wallpapers) Wallpapers.

</details>

# Table of contents

- [Installation](https://github.com/nguyenletientrien/Dotfiles#installation)
- [Package List](https://github.com/nguyenletientrien/Dotfiles#install-packages-from-a-list)
- [AUR Packages](https://github.com/nguyenletientrien/Dotfiles#aur-packages)
- [Suckless](https://github.com/nguyenletientrien/Dotfiles#suckless)
- [Optional](https://github.com/nguyenletientrien/Dotfiles#optional)
- [Enable Service](https://github.com/nguyenletientrien/Dotfiles#enable-service)
- [Configuration](https://github.com/nguyenletientrien/Dotfiles#configuration)
- [Other](https://github.com/nguyenletientrien/Dotfiles#other)

# Installation

### Install packages from a list
[pkglist.txt](https://github.com/nguyenletientrien/Dotfiles/blob/master/pkg/pkglist.txt)
```
pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))
```
> Note: Install packages from pkglist will install `intel-ucode` by default. To install `amd-ucode` instead, you have to edit *pkglist.txt* manually:
>> **Comment line 14 and uncomment line 15.**

### Graphics card
See Arch Wiki:
- [Xorg](https://wiki.archlinux.org/title/Xorg)
- [Intel graphics](https://wiki.archlinux.org/title/Intel_graphics)
- [NVIDIA](https://wiki.archlinux.org/title/NVIDIA), [NVIDIA Optimus](https://wiki.archlinux.org/title/NVIDIA_Optimus)
- [AMDGPU](https://wiki.archlinux.org/title/AMDGPU)

### AUR Packages
> To install manually AUR packages: `makepkg -si`

First, install [yay](https://aur.archlinux.org/packages/yay), then install some necessary packages from [aurlist.txt](https://github.com/nguyenletientrien/Dotfiles/blob/master/pkg/aurlist.txt) using yay:
```
yay -S - < aurlist.txt
```

### Suckless
> - To install Suckless softwares: `sudo make clean install`
> - To patch: `patch -p1 < your_patch_file`
- [dmenu](https://tools.suckless.org/dmenu)
- [st](https://st.suckless.org)
  - Patches: [font2](https://st.suckless.org/patches/font2), [dracula](https://st.suckless.org/patches/dracula), [alpha](https://st.suckless.org/patches/alpha), [dynamic-cursor-color](https://st.suckless.org/patches/dynamic-cursor-color), [scrollback + scrollback-mouse + scrollback-mouse-altscreen](https://st.suckless.org/patches/scrollback).

### Optional
<details>
<summary>Optional</summary>

> NOTE: You should read the application documentation for more information on the Archwiki or the application main page.
- mutt-wizard ([LukeSmith](https://github.com/LukeSmithxyz/mutt-wizard))
- Kdenlive
- GIMP
- Audacity
- OBS
- VirtualBox
- Virt-Manager
  > - `pacman -S libvirt iptables-nft qemu virt-manager`
  > - `sudo systemctl start/enable libvirtd`
  > - `sudo usermod -G libvirt -a <username>`
- LibreOffice 
  > `jre-openjdk` is needed for LibreOffice Database.
- grub-customizer
- openssh
- reflector
- tlp
- auto-cpufreq ([github](https://github.com/AdnanHodzic/auto-cpufreq))
- redshift
- conky
- maim
- onboard
- cronie
- speedtest-cli
- teamviewer ([AUR](https://aur.archlinux.org/packages/teamviewer))
  > Note: If you use startx, you won't be able to open teamviewer
</details>

# Enable Service
- Networkmanager: `systemctl enable NetworkManager.service`
- Ufw\*: `systemctl enable ufw.service`
- Bluetooth: `systemctl enable bluetooth.service`
- Lightdm: `systemctl enable lightdm.service`
- Acpid: `systemctl enable acpid.service`
- Thermald: `systemctl enable thermald.service`
- TRIM: `systemctl enable fstrim.timer`
> (\*) Note: This command is only needed *once* the first time you install the package: `ufw enable`

# Configuration

> Before you use this configuration you need copy `.profile` and `.Xresources` to your home directory.

<details>
<summary>Lightdm, lightdm-slick-greeter</summary>

#### Lightdm
- Edit config file in */etc/lightdm/lightdm.conf*
  ```
  [Seat:*]
  .....
  greeter-session=lightdm-slick-greeter
  user-session=qtile
  #user-session=i3
  .....
  ```
##### lightdm-slick-greeter
- Copy the picture you want to set background to */usr/share/backgrounds/*
- Create *slick-greeter.conf* as */etc/lightdm/slick-greeter.conf* and edit:
  ```
  [Greeter]
  background=/usr/share/backgrounds/<picture>
  ```
</details>

<details>
<summary>Vifm</summary>

- Copy [dracula.vifm](https://github.com/vifm/vifm-colors/blob/master/dracula.vifm), [dwmlight.vifm](https://github.com/vifm/vifm-colors/blob/master/dwmlight.vifm) to `~/.config/vifm/colors/`
- Copy  **gitbranch**, **vifmrun** and **vifmimg** to `~/.config/vifm/scripts/`
- Copy **myvifmrc** to `~/.config/vifm/`
- In vifmrc files:
    - Comment or delete the line that set default colorscheme.
    - Search for `gvim` and comment or delete these lines.
    - Add this to your vifmrc: `source $HOME/.config/vifm/myvifmrc`
- If you want to have *image preview* then you need to read the **myvifmrc** and follow the steps in it (line 70).

> NOTE: you must execute **vifmrun** script to use vifm with Ueberzug support. In other way, you can create symbolic links to add this script to PATH (assuming ~/.local/bin is in your system-wide PATH): `ln -sf ~/.config/vifm/scripts/vifmrun ~/.local/bin/ifm`
</details>

<details>
<summary>zsh</summary>

- Copy ***zsh*** folder to **~/.config/**
- To use [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), git clone from repository into **~/.config/zsh/plugins/**
```
cd ~/.config/zsh/plugins
```
```
git clone https://github.com/zsh-users/zsh-autosuggestions.git
```
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```
- Install [Starship prompt](https://starship.rs) and copy **starship.toml*** file to ***~/.config/***
> Starship is available on the official repository.
</details>

<details>
<summary>Neovim</summary>

- Requirements:
  - Neovim >= 0.8.0
  - Git
  - Nerd Font
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [fd](https://github.com/sharkdp/fd)
  - Provider:
    - python & pip
    - nodejs & npm
    - clipboard: `xclip`
    - See `help provider`, `checkhealth provider`
- Usage: Copy **nvim** folder to **~/.config/**
</details>

<details>
<summary>Dmenu</summary>

- Edit *config.def.h*:
  - Font: `Hack Nerd Font`
  - Font size: `13`
  - Colors:
    ```
    [SchemeNorm] = { "#777c99", "#1a1b26" },
    [SchemeSel] = { "#0f0f14", "#7aa2f7" },
    ```
- Edit *dmenu_run*:
  - Add `-p "Run:"` after `dmenu "@"`
  - Example: `dmenu "$@" -p "Run:"`
</details>

<details>
<summary>Kitty</summary>

- Copy default config file to ***~/.config/***
    ```
    cp /usr/share/doc/kitty/kitty.conf /home/nltt/.config/kitty/
    ```
- Configure
    ```
    #: Fonts
    font_family      JetBrains Mono 
    bold_font        JetBrains Mono Bold
    italic_font      JetBrains Mono Italic
    bold_italic_font JetBrains Mono Bold Italic
    font_size 15.0
    
    #: Window layout
    window_padding_width 5
    hide_window_decorations yes
    
    #: Color scheme
    background_opacity 0.9
    
    #: TokyoNight theme
    include tokyonight_moon.conf
    #: Dracula theme
    # include dracula.conf
    ```
- Nerd Symbols
    ```
    # - Use additional nerd symbols
    # See https://github.com/be5invis/Iosevka/issues/248
    # See https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points
    
    # Seti-UI + Custom
    symbol_map U+E5FA-U+E6AC Symbols Nerd Font
    
    # Devicons
    symbol_map U+E700-U+E7C5 Symbols Nerd Font
    
    # Font Awesome
    symbol_map U+F000-U+F2E0 Symbols Nerd Font
    
    # Font Awesome Extension
    symbol_map U+E200-U+E2A9 Symbols Nerd Font
    
    # Material Design Icons
    symbol_map U+F0001-U+F1AF0 Symbols Nerd Font
    
    # Weather
    symbol_map U+E300-U+E3E3 Symbols Nerd Font
    
    # Octicons
    symbol_map U+F400-U+F532,U+2665,U+26A1 Symbols Nerd Font
    
    # Powerline Symbols
    symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3 Symbols Nerd Font
    
    # Powerline Extra Symbols
    symbol_map U+E0A3,U+E0B4-U+E0C8,U+E0CA,U+E0CC-U+E0D4 Symbols Nerd Font
    
    # IEC Power Symbols
    symbol_map U+23FB-U+23FE,U+2B58 Symbols Nerd Font
    
    # Font Logos
    symbol_map U+F300-U+F32F Symbols Nerd Font
    
    # Pomicons
    symbol_map U+E000-U+E00A Symbols Nerd Font
    
    # Codicons
    symbol_map U+EA60-U+EBEB Symbols Nerd Font
    
    # Additional sets
    symbol_map U+E276C-U+E2771 Symbols Nerd Font # Heavy Angle Brackets
    symbol_map U+2500-U+259F Symbols Nerd Font # Box Drawing
    
    # Some symbols not covered by Symbols Nerd Font
    # nonicons contains icons in the range: U+F101-U+F27D
    # U+F167 is HTML logo, but YouTube logo in Symbols Nerd Font
    symbol_map U+F102,U+F116-U+F118,U+F12F,U+F13E,U+F1AF,U+F1BF,U+F1CF,U+F1FF,U+F20F,U+F21F-U+F220,U+F22E-U+F22F,U+F23F,U+F24F,U+F25F nonicons
    ```
- Icons: download your favourite [icons](https://sw.kovidgoyal.net/kitty/faq/#i-do-not-like-the-kitty-icon) and edit `/usr/share/applications/kitty.desktop` to replace the `Icon` path
- Theme: [Dracula](https://draculatheme.com/kitty), [TokyoNight](https://github.com/folke/tokyonight.nvim/tree/main/extras/kitty)
</details>

<details>
<summary>i3</summary>

- Copy ***i3*** folder to ***~/.config/***
- Open ***i3/config*** file and edit for use!
- See more: [i3-README.md](https://github.com/nguyenletientrien/Dotfiles/tree/master/.config/i3)
- AutoTiling script: [https://github.com/nwg-piotr/autotiling](https://github.com/nwg-piotr/autotiling)
- Set background with feh: `feh --bg-fill /path/to/picture`
</details>

<details>
<summary>Tmux</summary>

#### Installation
Install [Oh my tmux](https://github.com/gpakosz/.tmux)
> [A list of awesome resources for tmux.](https://github.com/rothgar/awesome-tmux)
#### Configuration
> Pressing `<prefix> e` will open `~/.tmux.conf.local` with the editor defined by the `$EDITOR` environment variable (defaults to `vim` when empty).
- [Enable the Powerline look](https://github.com/gpakosz/.tmux#enabling-the-powerline-look)
- Theme colors
```
# custom theme
tmux_conf_theme_colour_1="#16161e"
tmux_conf_theme_colour_2="#24283b"
tmux_conf_theme_colour_3="#a9b1d6"
tmux_conf_theme_colour_4="#8be9fd"
tmux_conf_theme_colour_5="#f1fa8c"
tmux_conf_theme_colour_6="#16161e"
tmux_conf_theme_colour_7="#f8f8f2"
tmux_conf_theme_colour_8="#16161e"
tmux_conf_theme_colour_9="#f1fa8c"
tmux_conf_theme_colour_10="#ff79c6"
tmux_conf_theme_colour_11="#50fa7b"
tmux_conf_theme_colour_12="#a9b1d6"
tmux_conf_theme_colour_13="#f8f8f2"
tmux_conf_theme_colour_14="#16161e"
tmux_conf_theme_colour_15="#16161e"
tmux_conf_theme_colour_16="#ff5555"
tmux_conf_theme_colour_17="#f8f8f2"
```
- Configuring the status line:
```
tmux_conf_theme_status_left=" ❐ #S "
tmux_conf_theme_status_right=" #{prefix} #{mouse}#{pairing}#{synchronized} | #{username}#{root} | #{hostname} "
```
#### Fix *Neovim losing colorscheme when in tmux*:
> `$TERM` must be set to `xterm-256color`
- tmux.conf:
```
set-option -ga terminal-overrides ",xterm-256color:Tc"
```
</details>

<details>
<summary>Power Management</summary>

- [Hibernation](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Hibernation)
- [Hibernate on low battery level](https://wiki.archlinux.org/title/laptop#Hibernate_on_low_battery_level)
- [Hybrid graphics](https://wiki.archlinux.org/title/hybrid_graphics)
- [TLP](https://linrunner.de/tlp/), [Arch Wiki](https://wiki.archlinux.org/title/TLP)
</details>

## Appearance
- Fonts
  - <details>
    <summary>Dependencies</summary>
      
      - Roboto Mono (dunst)
      - sans (Qtile, [dwm](https://github.com/nguyenletientrien/dwm))
      - Ubuntu Nerd Font (Qtile, i3, [dwm](https://github.com/nguyenletientrien/dwm))
      - Hack Nerd Font (Dmenu)
      - JetBrains Mono (Kitty)
    </details>
  - <details>
    <summary>Nerd Fonts</summary>

      - Arimo
      - CodeNewRoman
      - DejaVuSansMono
      - DroidSansMono
      - FiraCode
      - Go-Mono
      - Hack
      - JetBrainsMono
      - LiberationMono
      - Meslo
      - Mononoki
      - ProFont
      - RobotoMono
      - SourceCodePro
      - Ubuntu
    </details>
- Themes:
    - [Dracula](https://draculatheme.com)
    - [Catppuccin](https://github.com/catppuccin/catppuccin)
    - [arc-gtk](https://github.com/horst3180/Arc-theme)
    - TokyoNight ([1](https://github.com/folke/tokyonight.nvim)), ([2](https://github.com/enkia/tokyo-night-vscode-theme)), ([3](https://www.gnome-look.org/p/1681315/))
- Icons:
    - [Volantes Cursors](https://www.gnome-look.org/p/1356095)
    - [Tela circle icon](https://www.gnome-look.org/p/1359276)

### Tips and Tricks
- [Linux](https://github.com/nguyenletientrien/Dotfiles/tree/master/.github/TIPS.md)

### My Scripts
Please read the [documentation](https://github.com/nguyenletientrien/Dotfiles/tree/master/.github/SCRIPTS.md) for more information before using [my scripts](https://github.com/nguyenletientrien/Dotfiles/tree/master/.scripts).


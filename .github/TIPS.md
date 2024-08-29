# Tips and Tricks

### Vim Tips
[See here.](https://github.com/nguyenletientrien/Dotfiles/tree/master/.github/VIMTIPS.md)

### Use script or app as root without password
> Edit ***/etc/sudoers***
```
sudo nvim /etc/sudoers
```
- **Method 1**, Add this line:
  ```
  <user name>  ALL=NOPASSWD: /path/to/<script1>, /path/to/<script2>
  ```
  Example: `hehe  ALL=NOPASSWD: /usr/bin/udisksctl, /usr/bin/mount, /usr/bin/unmount`
- **Method 2**, Uncomment this line (will allow all sudo command):
  ```
  %wheel ALL=(ALL) NOPASSWD: ALL
  ```

### Useful command
- `sudoedit`: to edit root file by editor with user config.
- `sudo !!`
- `popd`
- `xev`: print out the user's keyboard input.

### udisksctl
- `udisksctl power-off -b /dev/<drive>` (to power off drive or safely to remove drive)
- `udisksctl mount -b /dev/<drive>`     (to mount drive)
- `udisksctl unmount -b /dev/<drive>`   (to unmount drive)

### xset
- `xset s off`
- `xset -dpms`
- `xset s noblank`

## Pacman
- To use pacman with more colors, uncomment this line in ***/etc/pacman.conf***
```
#Colors -> Color
```

#### Basics
> Note: make sure you run 'sudo pacman -Fy' at least once to use the -F option.
- `pacman -Q`                               : list all installed packages.
- `pacman -Qe`                              : list installed packages by user.
- `pacman -Qn`                              : list installed packages from official repository.
- `pacman -Qm`                              : list installed AUR packages.
- `pacman -Qlq` *`<package>`*               : list of installed package contents.
- `pacman -Flq` *`<package>`*               : list of remote package contents.
- `pacman -Qo` *`<file name>`*              : search for installed package containing the file.
- `pacman -F` *`<file name>`*               : search for remote package containing the file.
- `pacman -Qi` *`<package>`*                : installed package information.
- `pacman -Si` *`<package>`*                : remote package information.
- `pacman -Qs` *`<string1>`* *`<string2>`*  : search for installed package.
- `pacman -Ss` *`<string1>`* *`<string2>`*  : search for packages.
- `pacman -Sc`                              : remove package caches.
- `pacman -Scc`                             : remove package caches and packages files.
- `pacman -Syu`                             : update.
- `pacman -Rns` *`<package>`*               : remove package + dependencies + config file.
- `pacman -Rcns` *`<package>`*              : remove group package + dependencies + config file.
#### Advance
- To remove unused packages:
  ```
  pacman -Qtdq | sudo pacman -Rns -
  ```
- Getting the dependencies list of several packages:
  - Repo:
    ```
    LC_ALL=C pacman -Si <package> | awk -F'[:<=>]' '/^Depends/ {print $2}' | xargs -n1 | sort -u
    ```
  - Local:
    ```
    LC_ALL=C pacman -Qi <package> | awk -F'[:<=>]' '/^Depends/ {print $2}' | xargs -n1 | sort -u
    ```
- Listing files owned by a package with size:
  ```
  pacman -Qlq <package> | grep -v '/$' | xargs -r du -h | sort -h
  ```
#### With FZF
- Search packages with information:
  - Installed:
    ```
    pacman -Qq | fzf --preview 'pacman -Qil {}' --preview-window nohidden --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
    ```
  - Repo:
    ```
    pacman -Slq | fzf --preview 'pacman -Si {}' --preview-window nohidden --layout=reverse
    ```
- Install:
  ```
  pacman -Slq | fzf --multi --preview 'pacman -Si {1}' --preview-window nohidden | xargs -ro sudo pacman -S
  ```
- Remove:
  ```
  pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' --preview-window nohidden | xargs -ro sudo pacman -Rns
  ```

### Archive

Some old configurations

<details>
<summary>Lightdm, lightdm-slick-greeter</summary>

#### Lightdm
- Edit config file in */etc/lightdm/lightdm.conf*
  ```
  [Seat:*]
  .....
  greeter-session=lightdm-slick-greeter
  user-session=dwm
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

- Copy **myvifmrc** to `~/.config/vifm/`
- In default *vifmrc* files:
    - Comment or delete the line that set default colorscheme.
    - Search for `gvim` and comment or delete these lines.
    - Add this to your vifmrc: `source $HOME/.config/vifm/myvifmrc`
- If you want to have *image preview* then you need to read the **myvifmrc** and follow the steps in it.

> NOTE: you must execute **vifmrun** script to use vifm with Ueberzug support. In other way, you can create symbolic links to add this script to PATH (assuming ~/.local/bin is in your system-wide PATH): `ln -sf ~/.config/vifm/scripts/vifmrun ~/.local/bin/ifm`
</details>

<details>
<summary>Kitty</summary>

- Copy default config file to ***~/.config/***
    ```
    cp /usr/share/doc/kitty/kitty.conf ~/.config/kitty/
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
- Theme: [Dracula](https://draculatheme.com/kitty), [TokyoNight](https://github.com/folke/tokyonight.nvim/tree/main/extras/kitty)
</details>


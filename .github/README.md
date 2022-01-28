# Set up Arch Linux

![](https://raw.githubusercontent.com/nguyenletientrien/Dotfiles/master/.github/i3.png)
![](https://raw.githubusercontent.com/nguyenletientrien/Dotfiles/master/.github/qtile.png)

# Table of contents

- [Installation](https://github.com/nguyenletientrien/Dotfiles#installation)
  - [Base Packages](https://github.com/nguyenletientrien/Dotfiles#base-packages)
  - [Window Manager](https://github.com/nguyenletientrien/Dotfiles#window-manager)
  - [Apps](https://github.com/nguyenletientrien/Dotfiles#apps)
  - [AUR Packages](https://github.com/nguyenletientrien/Dotfiles#aur-packages)
  - [Suckless](https://github.com/nguyenletientrien/Dotfiles#suckless)
  - [Optional](https://github.com/nguyenletientrien/Dotfiles#optional)
- [Configuration](https://github.com/nguyenletientrien/Dotfiles#configuration)
  - [Unmute the sound card and disable auto mute on startup](https://github.com/nguyenletientrien/Dotfiles#unmute-the-sound-card-and-disable-auto-mute-on-startup)
  - [i3](https://github.com/nguyenletientrien/Dotfiles#i3)
  - [Qtile](https://github.com/nguyenletientrien/Dotfiles#qtile)
  - [Neovim](https://github.com/nguyenletientrien/Dotfiles#neovim)
  - [Environment variables](https://github.com/nguyenletientrien/Dotfiles#environment-variables)
  - [ZSH](https://github.com/nguyenletientrien/Dotfiles#zsh)
  - [Vifm](https://github.com/nguyenletientrien/Dotfiles#vifm)
  - [Picom](https://github.com/nguyenletientrien/Dotfiles#picom)
  - [Alacritty](https://github.com/nguyenletientrien/Dotfiles#alacritty)
  - [Kitty](https://github.com/nguyenletientrien/Dotfiles#kitty)
  - [Dmenu](https://github.com/nguyenletientrien/Dotfiles#dmenu)
  - [St](https://github.com/nguyenletientrien/Dotfiles#st)
  - [Dunst](https://github.com/nguyenletientrien/Dotfiles#dunst)
  - [Zathura](https://github.com/nguyenletientrien/Dotfiles#zathura)
  - [Lightdm](https://github.com/nguyenletientrien/Dotfiles#lightdm)
  - [Pacman](https://github.com/nguyenletientrien/Dotfiles#pacman)
- [Tips and Tricks](https://github.com/nguyenletientrien/Dotfiles#tips-and-tricks)
- [Other](https://github.com/nguyenletientrien/Dotfiles#other)

# Installation

### Base Packages
- Base:
  ```
  base base-devel linux linux-headers linux-firmware intel-ucode
  ```
  > Replace `intel-ucode` with `amd-ucode` if you have **AMD** cpu.
- Grub:
  ```
  grub efibootmgr dosfstools os-prober mtools
  ```
- Firewall, Network:
  ```
  ufw networkmanager
  ```
  > - Enable ufw (see Arch Wiki: [Uncomplicated Firewall](https://wiki.archlinux.org/title/Uncomplicated_Firewall))
  > - Enable networkmanager: `systemctl enable NetworkManager`
- Graphics driver (intel):
  ```
  mesa lib32-mesa vulkan-intel
  ```
  > If you use other graphics card, see Arch Wiki:
    > - [Intel graphics](https://wiki.archlinux.org/title/Intel_graphics)
    > - [AMDGPU](https://wiki.archlinux.org/title/AMDGPU)
    > - [NVIDIA](https://wiki.archlinux.org/title/NVIDIA)
    > - [Xorg](https://wiki.archlinux.org/title/Xorg)

- Sound:
  ```
  alsa-utils pulseaudio pulseaudio-alsa pamixer pulsemixer
  ```

### Window Manager
- Xorg:
  ```
  xorg xorg-drivers xorg-xinit libx11 libxinerama libxft
  ```
  > See also: [Xorg](https://wiki.archlinux.org/title/Xorg)
- Some lib:
  ```
  webkit2gtk libnotify gcr gstreamer gst-libav gst-plugins-good
  ```
- i3:
  ```
  i3-wm i3status i3lock
  ```
- Qtile:
  ```
  qtile xcb-util-cursor python-psutil
  ```

### Apps
```
neovim vim nano zsh neofetch htop git wget curl zip unzip unrar p7zip gzip bzip2 tar pavucontrol pcmanfm vifm ueberzug ffmpegthumbnailer ffmpeg atool feh sxiv mpv cmus imagemagick firefox chromium lxappearance picom fzf bat ripgrep the_silver_searcher fd exa net-tools pacman-contrib network-manager-applet zathura zathura-pdf-poppler zathura-djvu zathura-ps dunst gcc gdb cmake kitty alacritty lightdm lightdm-slick-greeter xclip fuse2
```
> Enable lightdm: `systemctl enable lightdm`
- If you want to use [screenshot](https://github.com/nguyenletientrien/Dotfiles/blob/master/.scripts/screenshot) script with *selected option*, install `slop` package.

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
  - persepolis
  - onboard
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

# Configuration

## Unmute the sound card and disable auto mute on startup
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

## i3
- Copy ***i3*** folder to ***~/.config/***
- Open ***i3/config*** file and edit for use!
- You can read readme for more.
- Set background with feh: `feh --bg-scale /path/to/picture`
- See more: [i3-README.md](https://github.com/nguyenletientrien/Dotfiles/tree/master/.config/i3)

## Qtile
- Copy ***qtile*** folder to ***~/.config/***
- Set background with feh: `feh --bg-scale /path/to/picture`

## Neovim
##### Installation
- neovim
- [vim-plug](https://github.com/junegunn/vim-plug)
- nodejs *lastest version*
- npm
- npm *provider*: `sudo npm install -g neovim`
- python, python-pip, python2, python2-pip.
  > If you can't find the ***python2-pip*** package, see this [documentation](https://pip.pypa.io/en/latest/installation/).
  >> Remember to replace `python` with `python2` to install pip2.
- pynvim:
    ```
    python2 -m pip install --user --upgrade pynvim 
    python3 -m pip install --user --upgrade pynvim
    ```
- ccls (for C/C++)
##### Copy config folder
- Copy ***nvim*** folder to ***~/.config/***
##### Finally
1. Open nvim (don't worry with some error message) and run `:PlugInstall` and wait to install plugins.
   > - You will get "**post-update hook for fzf...**" error message if you installed fzf with "`pacman -S fzf`".
   > - Press 'R' to retry.
2. You will see the CoC extension installation after all plugins are successfully installed.
3. Close nvim and open again, run `:VimspectorInstal vscode-cpptools` (for C/C++ debugging).
   > You can use *Tab* and choose adapter.
4. Done.

## Environment variables:
  - Copy ***.profile*** file to your home directory.

## ZSH
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

## Vifm
##### General
- Copy [dracula.vifm](https://github.com/vifm/vifm-colors) to ***~/.vifm/colors/***
- Copy  ***gitbranch***, ***vifmrun*** and ***vifmimg*** to ***~/.vifm/scripts/***
  > NOTE: you must execute **vifmrun** script to use vifm with ueberzug support.
##### Config in vifmrc
- Line 14: change "**vim**" to "**nvim**" (`set vicmd=nvim`).
- Line 62: change theme to "**dracula**" (`colorscheme dracula`).
- Line 132: change "**vim**" to "**nvim**" (`command! diff nvim -d %f %F`).
- Search for `gvim` and comment or delete these lines.
- General config:
  ```
  only
  set number
  set relativenumber
  map af za
  map <c-j> 5j
  map <c-k> 5k
  map <space>f /
  map f<space> /
  map q :q<CR>
  ```
- status line
  - Default format with add more colors:
    ```
    highlight User1 ctermfg=cyan
    highlight User2 ctermfg=yellow
    highlight User3 ctermfg=red
    highlight User4 ctermfg=green
    highlight User5 ctermfg=magenta
    set statusline="%1*%z%=    %2*%A %3*%10u:%-7g %4*%10s %5*%20d"
    ```
  - Add my git branch script:
    ```
    highlight User1 ctermfg=cyan
    highlight User2 ctermbg=cyan ctermfg=black
    highlight User3 ctermfg=yellow
    highlight User4 ctermfg=red
    highlight User5 ctermfg=green
    highlight User6 ctermfg=magenta
    set statusline="%1*%2*%{extcached('gitbranch', expand('%d'), 'gitbranch ' . expand('%d'))}%1*%*%=%3*%A %4*%10u:%-7g %5*%10s %6*%20d"
    ```
- Sxiv:
  ```
  command sxiv sxiv -ft .
  ```
- Atool:
  ```
  command extract atool -x -e %f
  command compressZ atool -a -F .zip -e %f
  command compressT atool -a -F .tar.xz -e %f
  map <space>e  :extract<CR>
  map <space>c  :compressZ<CR>
  map <space>ct :compressT<CR>
  ```
  > #### Now you can use:
  > - `:sxiv` to list all images in current directory.
  > - *space+e* to extract file.
  > - *space+c* to compress `.zip`.
  > - *space+c+t* to compress `.tar.xz`.
- Filextype and fileviewer config:
  - Images
    ```
    filextype {*.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm},<image/*>
            \ {View in sxiv}
            \ sxiv %f &,
            \ {View in feh}
            \ feh -d -g 800x600 --scale-down %c &,
    fileviewer {*.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm},<image/*>
            \ vifmimg draw %px %py %pw %ph %c
            \ %pc
            \ vifmimg clear
    ```
  - Videos
    > Use **mpv** as default.
    ```
    filextype {*.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
              \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
              \*.as[fx]},
             \<video/*>
            \ {View using mpv}
            \ mpv %f 2>/dev/null &,
            \ {View using ffplay}
            \ ffplay -fs -autoexit %f,
    fileviewer {*.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
               \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
               \*.as[fx]},
              \<video/*>
             \ vifmimg videopreview %px %py %pw %ph %c
             \ %pc
             \ vifmimg clear
    ```
  - Audio
    > Use **mpv** as default.
    ```
    filetype {*.wav,*.mp3,*.flac,*.m4a,*.wma,*.ape,*.ac3,*.og[agx],*.spx,*.opus},
            \<audio/*>
           \ {Play using mpv}
           \ mpv %f,
           \ {Play using ffplay}
           \ ffplay -nodisp -autoexit %c,
    ```
- Optional:
  - Preview with syntax highlighting using bat
    ```
    fileviewer *[^/],.*[^/] bat --color=always %c -pp
    ```
  - Preview directory using ls command
    ```
    fileviewer */,.*/ ls -1 --color=always %c
    ```
- Icons:
To display icons, add this after line `" filetype * start, explorer`:
```
" file types
set classify=' :dir:/, :exe:, :reg:, :link:'
" various file names
set classify+=' ::../::, ::*.sh::, ::*.[hc]pp::, ::*.[hc]::, ::/^copying|license$/::, ::.git/,,*.git/::, ::*.epub,,*.fb2,,*.djvu::, ::*.pdf::, ::*.htm,,*.html,,**.[sx]html,,*.xml::'
" archives
set classify+=' ::*.7z,,*.ace,,*.arj,,*.bz2,,*.cpio,,*.deb,,*.dz,,*.gz,,*.jar,,*.lzh,,*.lzma,,*.rar,,*.rpm,,*.rz,,*.tar,,*.taz,,*.tb2,,*.tbz,,*.tbz2,,*.tgz,,*.tlz,,*.trz,,*.txz,,*.tz,,*.tz2,,*.xz,,*.z,,*.zip,,*.zoo::'
" images
set classify+=' ::*.bmp,,*.gif,,*.jpeg,,*.jpg,,*.ico,,*.png,,*.ppm,,*.svg,,*.svgz,,*.tga,,*.tif,,*.tiff,,*.xbm,,*.xcf,,*.xpm,,*.xspf,,*.xwd::'
" audio
set classify+=' ::*.aac,,*.anx,,*.asf,,*.au,,*.axa,,*.flac,,*.m2a,,*.m4a,,*.mid,,*.midi,,*.mp3,,*.mpc,,*.oga,,*.ogg,,*.ogx,,*.ra,,*.ram,,*.rm,,*.spx,,*.wav,,*.wma,,*.ac3::'
" media
set classify+=' ::*.avi,,*.ts,,*.axv,,*.divx,,*.m2v,,*.m4p,,*.m4v,,.mka,,*.mkv,,*.mov,,*.mp4,,*.flv,,*.mp4v,,*.mpeg,,*.mpg,,*.nuv,,*.ogv,,*.pbm,,*.pgm,,*.qt,,*.vob,,*.wmv,,*.xvid::'
" office files
set classify+=' ::*.doc,,*.docx::, ::*.xls,,*.xls[mx]::, ::*.pptx,,*.ppt::'
```

## Picom
- Copy ***picom*** folder to ***~/.config/***

## Alacritty
- Copy ***alacritty*** folder to ***~/.config/***

## Kitty
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
- Theme
See [Dracula Theme](https://draculatheme.com/kitty)

## Dmenu
- Edit *config.def.h*:
  - Font: `Hack Nerd Font`
  - Font size: `11`
  - Colors:
    ```
    [SchemeNorm] = { "#bbbbbb", "#282a36" },
    [SchemeSel] = { "#000000", "#f59cff" },
    ```
    ```
    [SchemeNorm] = { "#777c99", "#282a36" },
    [SchemeSel] = { "#bd93f9", "#22232e" },
    ```
- Edit *dmenu_run*
  - Add `-p "Run:"` after `dmenu "@"`
  - Example: `dmenu "$@" -p "Run:"`

## St
- Change font (font2) and font size.
  > Hack Nerd Font, JoyPixels, Symbola (AUR)
- Patch, Fix and config MANUALLY (Goodluck!!).

## Dunst
Copy ***dunst*** folder to ***~/.config/***
> If the config work incorrect, you need read all content of dunstrc file and edit for work correct.
>
> Something incorrect as: font, dmenu path, icon path, ...
>
> You should view `man dunst` to find default config file.
>
> You can follow this *dunstrc* to manually configure the default dunstrc on your system.

## Zathura
- Copy ***zathura*** folder to ***~/.config/***

## Lightdm
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

## sxiv
- Copy ***sxiv*** folder to ***~/.config/***
- Copy **.Xresources** to your home directory and run `xrdb -load ~/.Xresources`

## Pacman
- To use pacman with more colors, uncomment this line in ***/etc/pacman.conf***
```
#Colors -> Color
```

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
  Example: `nltt  ALL=NOPASSWD: /usr/bin/udisksctl, /usr/bin/mount, /usr/bin/unmount`
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

### Pacman
> Note: make sure you run 'sudo pacman -Fy' at least once to use the -F option.
#### Basics
- `pacman -Q`                       : list all installed packages.
- `pacman -Qe`                      : list installed packages by user.
- `pacman -Qn`                      : list installed packages from official repository.
- `pacman -Qm`                      : list installed AUR packages.
- `pacman -Qlq` *`<package>`*       : list of installed package contents.
- `pacman -Flq` *`<package>`*           : list of remote package contents.
- `pacman -Qo` *`<file name>`*      : search for installed package containing the file.
- `pacman -F` *`<file name>`*       : search for remote package containing the file.
- `pacman -Qi` *`<package>`*        : installed package information.
- `pacman -Si` *`<package>`*        : remote package information.
- `pacman -Qs` *`<string1>`* *`<string2>`*  : search for installed package.
- `pacman -Ss` *`<string1>`* *`<string2>`*  : search for packages.
- `pacman -Sc`                      : remove package caches.
- `pacman -Scc`                     : remove package caches and packages files.
- `pacman -Syu`                     : update.
- `pacman -Rns` *`<package>`*       : remove package + dependencies + config file.
- `pacman -Rcns` *`<package>`*      : remove group package + dependencies + config file.
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

# Other

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

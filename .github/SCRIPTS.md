# Readme

- *Copy* **.scripts** *folder to your home directory.*
- Add this to **.profile**:
  ```
  export PATH="$PATH:${HOME}/.scripts"
  ```

### Dependencies:
```
pacman-contrib dunst python feh xdotool xclip ffmpeg maim slop curl jq rofi
```
- dmenu
- i3lock-color
- nvidia-prime (for NVIDIA graphics card)
- *Browser*
- *Terminal*
- Any Nerd Font
- ...

Example for Arch:
```
sudo pacman -S pacman-contrib dunst pyhon feh xclip ffmpeg slop alacritty
```
> For dmenu, see [Suckless](https://github.com/nguyenletientrien/Dotfiles#suckless).

### NOTE
#### dmupdate
- You need to specify terminal (with option run command):
  ```
  dmupdate "alacritty -e"
  dmupdate "kitty"
  dmupdate "st"
  ```
#### dmeditconf
> ### This script use st terminal and nvim as default.
> You can use other apps by modifying the variables (DMTERM, DMEDITOR) in the dmeditconf.

#### dmwebsearch
> ### This script use chromium browser as default.
> You can use other browser by modifying the DMBROWSER variables in the dmwebsearch.

#### dmmount, dmunmount
- Add this line to ***/etc/sudoers***
```
<user-name>  ALL=NOPASSWD: /usr/bin/udisksctl, /usr/bin/mount, /usr/bin/unmount
```

### Window manager with key binding
#### Example for i3 (use alacritty terminal):

```
# dmupdate
exec --no-startup-id dmupdate 'alacritty -e'
```
```
# lockscreen
bindsym $mod+Escape exec --no-startup-id lockscreen
```
```
# screenshot
bindsym Print exec --no-startup-id screenshot
bindsym Shift+Print exec --no-startup-id screenshot selected
```
```
mode "dmscripts" {
    bindsym q exec --no-startup-id dmpower, mode "default"
    bindsym e exec --no-startup-id dmeditconf, mode "default"
    bindsym s exec --no-startup-id dmwebsearch, mode "default"
    bindsym b exec --no-startup-id dmsetbg, mode "default"
    bindsym w exec --no-startup-id dmwifi, mode "default"
    bindsym t exec --no-startup-id dmtranslate, mode "default"
    bindsym k exec --no-startup-id dmkill, mode "default"
    bindsym p exec --no-startup-id dmmaim, mode "default"
    bindsym i exec --no-startup-id dmicons, mode "default"
    bindsym c exec --no-startup-id dmcalc, mode "default"
    bindsym n exec --no-startup-id dmprime-run, mode "default"
    bindsym m exec --no-startup-id dmmount, mode "default"
    bindsym Shift+m exec --no-startup-id dmunmount, mode "default"
    bindsym Print exec --no-startup-id dmrecord, mode "default"
    bindsym Shift+Print exec --no-startup-id dmrecord kill, mode "default"

    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+p mode "dmscripts"
```

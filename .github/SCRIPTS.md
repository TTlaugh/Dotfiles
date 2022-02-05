# Readme

- *Copy* **.scripts** *folder to your home directory.*
- Add this to **.profile**:
  ```
  export PATH="$PATH:${HOME}/.scripts"
  ```

### Dependencies:
- dmenu
- pacman-contrib
- dunst
- pyhon
- feh
- xclip
- ffmpeg
- slop
- Your favorite terminal

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
- You should add this line to ***/etc/sudoers***
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
    bindsym k exec --no-startup-id dmkill, mode "default"
    bindsym m exec --no-startup-id dmmount, mode "default"
    bindsym p exec --no-startup-id dmmaim, mode "default"
    bindsym Shift+m exec --no-startup-id dmunmount, mode "default"
    bindsym $mod+Print exec --no-startup-id dmrecord, mode "default"
    bindsym $mod+Shift+Print exec --no-startup-id dmrecord kill, mode "default"
    bindsym $mod+c exec --no-startup-id dmcalc, mode "default"

    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+p mode "dmscripts"
```

# Readme

- ***Copy this folder to your home directory.***
- Add this to **.zshrc**:
  ```
  export PATH="$PATH:$HOME/.scripts"
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
#### dmvifm, dmpacupdate
- You need to specify terminal (with option run command) to use.
##### Example
- With alacritty terminal:
```
dmvifm "alacritty -e"
dmpacupdate "alacritty -e"
```
- With kitty terminal:
```
dmvifm "kitty"
dmpacupdate "kitty"
```
- With st terminal:
```
dmvifm "st"
dmpacupdate "st"
```
- ......

#### dmmount, dmunmount
- You should add this line to ***/etc/sudoers***
```
<user-name>  ALL=NOPASSWD: /usr/bin/udisksctl, /usr/bin/mount, /usr/bin/unmount
```

### Window manager with key binding
#### Example for i3 (use alacritty terminal):

```
# dmpacupdate
exec --no-startup-id ~/.scripts/dmpacupdate "alacritty -e"
```
```
# dmpower
bindsym $mod+F1 exec --no-startup-id ~/.scripts/dmpower "Are you sure you want to exit i3?"   "i3-msg exit"
bindsym $mod+F2 exec --no-startup-id ~/.scripts/dmpower "Are you sure you want to suspend?"   "systemctl suspend"
bindsym $mod+F3 exec --no-startup-id ~/.scripts/dmpower "Are you sure you want to reboot?"    "reboot"
bindsym $mod+F4 exec --no-startup-id ~/.scripts/dmpower "Are you sure you want to shutdown?"  "shutdown now"
```
```
# dmsetbg
bindsym $mod+b exec --no-startup-id ~/.scripts/dmsetbg ~/Wallpapers

# dmwifi
bindsym $mod+mod1+w exec --no-startup-id ~/.scripts/dmwifi

# dmkill
bindsym $mod+Escape exec --no-startup-id ~/.scripts/dmkill

# dmmount
bindsym $mod+F5 exec --no-startup-id ~/.scripts/dmmount
# dmunmount
bindsym $mod+Shift+F5 exec --no-startup-id ~/.scripts/dmunmount

# dmvifm
bindsym $mod+slash exec --no-startup-id ~/.scripts/dmvifm "alacritty -e"

# screenshot
### Full screen
bindsym Print exec --no-startup-id ~/.scripts/screenshot
### Selected region
bindsym Shift+Print exec --no-startup-id ~/.scripts/screenshot selected

# record
bindsym $mod+Print exec --no-startup-id ~/.scripts/dmrecord
bindsym $mod+Shift+Print exec --no-startup-id ~/.scripts/dmrecord kill

# cleaner
bindsym $mod+$mod1+c exec --no-startup-id alacritty -e ~/.scripts/cleaner

# dmcalc
bindsym $mod+c exec --no-startup-id ~/.scripts/dmcalc
```

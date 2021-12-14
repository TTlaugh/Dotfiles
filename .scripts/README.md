# Readme

- ***Copy this folder to your home directory.***

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
#### dmvifm.sh, dmpacupdate.sh
- You need to specify terminal (with option run command) to use.
##### Example
- With alacritty terminal:
```
./dmvifm.sh "alacritty -e"
./dmpacupdate.sh "alacritty -e"
```
- With kitty terminal:
```
./dmvifm.sh "kitty"
./dmpacupdate.sh "kitty"
```
- With st terminal:
```
./dmvifm.sh "st"
./dmpacupdate.sh "st"
```
- ......

#### dmmount.sh, dmunmount.sh
- You should add this line to ***/etc/sudoers***
```
<user-name>  ALL=NOPASSWD: /usr/bin/udisksctl, /usr/bin/mount, /usr/bin/unmount
```

### Window manager with key binding
#### Example for i3 (use alacritty terminal):

```
# dmpacupdate.sh
exec --no-startup-id ~/.scripts/dmpacupdate.sh "alacritty -e"
```
```
# dmpower.sh
bindsym $mod+F1 exec --no-startup-id ~/.scripts/dmpower.sh "Are you sure you want to exit i3?"   "i3-msg exit"
bindsym $mod+F2 exec --no-startup-id ~/.scripts/dmpower.sh "Are you sure you want to suspend?"   "systemctl suspend"
bindsym $mod+F3 exec --no-startup-id ~/.scripts/dmpower.sh "Are you sure you want to reboot?"    "reboot"
bindsym $mod+F4 exec --no-startup-id ~/.scripts/dmpower.sh "Are you sure you want to shutdown?"  "shutdown now"
```
```
# dmsetbg.sh
bindsym $mod+b exec --no-startup-id ~/.scripts/dmsetbg.sh ~/Wallpapers

# dmwifi.sh
bindsym $mod+mod1+w exec --no-startup-id ~/.scripts/dmwifi.sh

# dmkill.sh
bindsym $mod+Escape exec --no-startup-id ~/.scripts/dmkill.sh

# dmmount.sh
bindsym $mod+F5 exec --no-startup-id ~/.scripts/dmmount.sh
# dmunmount.sh
bindsym $mod+Shift+F5 exec --no-startup-id ~/.scripts/dmunmount.sh

# dmvifm.sh
bindsym $mod+slash exec --no-startup-id ~/.scripts/dmvifm.sh "alacritty -e"

# screenshot.sh
### Full screen
bindsym Print exec --no-startup-id ~/.scripts/screenshot.sh
### Selected region
bindsym Shift+Print exec --no-startup-id ~/.scripts/screenshot.sh selected

# record
bindsym $mod+Print exec --no-startup-id ~/.scripts/dmrecord.sh
bindsym $mod+Shift+Print exec --no-startup-id ~/.scripts/dmrecord.sh kill

# cleaner.sh
bindsym $mod+$mod1+c exec --no-startup-id alacritty -e ~/.scripts/cleaner.sh

# dmcalc.sh
bindsym $mod+c exec --no-startup-id ~/.scripts/dmcalc.sh
```

#### Createproject.sh
> With createproject.sh you can set alias in your .bashrc or .zshrc
##### Example
```
alias mkpr="~/.scripts/createproject.sh"
```

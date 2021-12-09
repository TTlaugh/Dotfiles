# Readme

- ***Copy this folder to your home directory.***

### Dependencies:
- dmenu
- pacman-contrib
- dunst
- pyhon
- feh
- Your favorite terminal
- ...

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

##### cleaner.sh
```
bindsym $mod+$mod1+c exec --no-startup-id alacritty -e ~/.scripts/cleaner.sh
```
##### dmpacupdate.sh
```
exec --no-startup-id ~/.scripts/dmpacupdate.sh "alacritty -e"
```
##### dmpower.sh
```
bindsym $mod1+Shift+F1 exec --no-startup-id ~/.scripts/dmpower.sh "Are you sure you want to exit i3?"   "i3-msg exit"
bindsym $mod1+Shift+F2 exec --no-startup-id ~/.scripts/dmpower.sh "Are you sure you want to suspend?"   "systemctl suspend"
bindsym $mod1+Shift+F3 exec --no-startup-id ~/.scripts/dmpower.sh "Are you sure you want to reboot?"    "reboot"
bindsym $mod1+Shift+F4 exec --no-startup-id ~/.scripts/dmpower.sh "Are you sure you want to shutdown?"  "shutdown now"
```
##### dmmount.sh & dmunmount.sh
```
bindsym $mod+$mod1+m exec --no-startup-id ~/.scripts/dmmount.sh
bindsym $mod+$mod1+u exec --no-startup-id ~/.scripts/dmunmount.sh
```
##### dmwifi.sh
```
bindsym $mod+mod1+w exec --no-startup-id ~/.scripts/dmwifi.sh
```
##### dmvifm.sh
```
bindsym $mod1+Shift+Return exec --no-startup-id ~/.scripts/dmvifm.sh "alacritty -e"
```
##### screenshot.sh
```
bindsym Print exec --no-startup-id ~/.scripts/screenshot.sh
```
##### dmcalc.sh
```
bindsym $mod+c exec --no-startup-id ~/.scripts/dmcalc.sh
```
##### dmsetbg.sh
```
bindsym $mod+mod1+b exec --no-startup-id ~/.scripts/dmsetbg.sh ~/Wallpapers
```
##### dmkill.sh
```
bindsym $mod+Escape exec --no-startup-id ~/.scripts/dmkill.sh
```

#### Createproject.sh
> With createproject.sh you can set alias in your .bashrc or .zshrc
##### Example
```
alias mkpr="~/.scripts/createproject.sh"
```

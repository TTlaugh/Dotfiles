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
#### d_vifm.sh, d_Arch-update.sh
- You need to specify terminal (with option run command) to use.
##### Example
- With alacritty terminal:
```
./d_vifm.sh "alacritty -e"
./d_Arch-update.sh "alacritty -e"
```
- With kitty terminal:
```
./d_vifm.sh "kitty"
./d_Arch-update.sh "kitty"
```
- With st terminal:
```
./d_vifm.sh "st"
./d_Arch-update.sh "st"
```
- ......

#### d_mount.sh, d_unmount.sh
- You should add this line to ***/etc/sudoers***
```
<user-name>  ALL=NOPASSWD: /usr/bin/udisksctl, /usr/bin/mount, /usr/bin/unmount
```

### Window manager with key binding
#### Example for i3 (use alacritty terminal):

##### Arch_cleaner.sh
```
bindsym $mod+$mod1+c exec --no-startup-id alacritty -e ~/.scripts/Arch_cleaner.sh
```
##### d_Arch_update.sh
```
exec --no-startup-id ~/.scripts/d_Arch_update.sh "alacritty -e"
```
##### d_Arch_power.sh
```
bindsym $mod1+Shift+F1 exec --no-startup-id ~/.scripts/d_Arch_power.sh "Are you sure you want to exit i3?"   "i3-msg exit"
bindsym $mod1+Shift+F2 exec --no-startup-id ~/.scripts/d_Arch_power.sh "Are you sure you want to suspend?"   "systemctl suspend"
bindsym $mod1+Shift+F3 exec --no-startup-id ~/.scripts/d_Arch_power.sh "Are you sure you want to reboot?"    "reboot"
bindsym $mod1+Shift+F4 exec --no-startup-id ~/.scripts/d_Arch_power.sh "Are you sure you want to shutdown?"  "shutdown now"
```
##### d_mount.sh & d_unmount.sh
```
bindsym $mod+$mod1+m exec --no-startup-id ~/.scripts/d_mount.sh
bindsym $mod+$mod1+u exec --no-startup-id ~/.scripts/d_unmount.sh
```
##### d_wifi.sh
```
bindsym $mod+mod1+w exec --no-startup-id ~/.scripts/d_wifi.sh
```
##### d_vifm.sh
```
bindsym $mod1+Shift+Return exec --no-startup-id ~/.scripts/d_vifm.sh "alacritty -e"
```
##### ffmpeg-screenshot.sh
```
bindsym Print exec --no-startup-id ~/.scripts/ffmpeg-screenshot.sh
```
##### d_calc_py.sh
```
bindsym $mod+c exec --no-startup-id ~/.scripts/d_calc_py.sh
```
##### d_setbg.sh
```
bindsym $mod+mod1+b exec --no-startup-id ~/.scripts/d_setbg.sh ~/Wallpapers
```
##### d_kill_proc.sh
```
bindsym $mod+Escape exec --no-startup-id ~/.scripts/d_kill_proc.sh
```

#### Createproject.sh
> With createproject.sh you can set alias in your .bashrc or .zshrc
##### Example
```
alias mkpr="~/.scripts/createproject.sh"
```

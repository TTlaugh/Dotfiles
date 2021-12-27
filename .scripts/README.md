# Readme

- ***Copy this folder to your home directory.***
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
#### dmvifm, dmupdate
- You need to specify terminal (with option run command) to use.
##### Example
- With alacritty terminal:
```
dmvifm "alacritty -e"
dmupdate "alacritty -e"
```
- With kitty terminal:
```
dmvifm "kitty"
dmupdate "kitty"
```
- With st terminal:
```
dmvifm "st"
dmupdate "st"
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
# dmupdate
exec --no-startup-id dmupdate "alacritty -e"
```
```
# dmpower
bindsym $mod+F4 exec --no-startup-id dmpower
```
```
# dmsetbg
bindsym $mod+b exec --no-startup-id dmsetbg ~/Wallpapers

# dmwifi
bindsym $mod+mod1+w exec --no-startup-id dmwifi

# dmkill
bindsym $mod+Escape exec --no-startup-id dmkill

# dmmount
bindsym $mod+F5 exec --no-startup-id dmmount
# dmunmount
bindsym $mod+Shift+F5 exec --no-startup-id dmunmount

# dmvifm
bindsym $mod+slash exec --no-startup-id dmvifm "alacritty -e"

# screenshot
### Full screen
bindsym Print exec --no-startup-id screenshot
### Selected region
bindsym Shift+Print exec --no-startup-id screenshot selected

# record
bindsym $mod+Print exec --no-startup-id dmrecord
bindsym $mod+Shift+Print exec --no-startup-id dmrecord kill

# cleaner
bindsym $mod+$mod1+c exec --no-startup-id alacritty -e cleaner

# dmcalc
bindsym $mod+c exec --no-startup-id dmcalc
```

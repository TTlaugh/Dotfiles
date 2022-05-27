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

## Pacman
- To use pacman with more colors, uncomment this line in ***/etc/pacman.conf***
```
#Colors -> Color
```

#### Basics
> Note: make sure you run 'sudo pacman -Fy' at least once to use the -F option.
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

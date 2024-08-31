<div align="center">
    <img src="banner.png" alt="banner">
</div>
<h3 align="center">
    The <b>Arch Linux & DWM</b> dotfiles!
</h3>

<div align="center">
    <a href="#Previews">Previews</a>
    ·
    <a href="#Installation">Installation</a>
    ·
    <a href="https://github.com/TTlaugh/dwm">DWM</a>
    ·
    <a href="https://github.com/TTlaugh/dmenu">Dmenu</a>
    ·
    <a href="https://github.com/TTlaugh/Wallpapers">Wallpapers</a>
</div>

<br>

## 👋 Welcome!

<table align="right">
  <tr>
    <td align="center">
      <sup>
        <samp>
            If you like this setup or even use it,<br>
            can you drop a star please? <br>
            I really appreciate it.
            Thanks!
        </samp>
      </sup>
    </td>
  </tr>
<table>

Hey, thanks for visiting ❤️!

There are my Arch Linux and DWM configuration files.

Minimal, performance-focused. Extremely fast and small without sacrificing convenience.

</table>

## 🖼️ Previews
![](https://raw.githubusercontent.com/TTlaugh/Dotfiles/master/.github/screenshot1.png)
<details>
<summary>show previews</summary>

![](https://raw.githubusercontent.com/TTlaugh/Dotfiles/master/.github/screenshot2.png)
![](https://raw.githubusercontent.com/TTlaugh/Dotfiles/master/.github/screenshot3.png)
![](https://raw.githubusercontent.com/TTlaugh/Dotfiles/master/.github/screenshot4.png)
![](https://raw.githubusercontent.com/TTlaugh/Dotfiles/master/.github/screenshot5.png)
</details>

## ⬇️  Installation

On an Arch-based distribution, run the following:
```
git clone https://github.com/TTlaugh/Dotfiles.git
cd Dotfiles
chmod +x install.sh
./install.sh
```

## ⚡️What does this script do?
- 💫 **Autoinstalls and autoconfigures for:**
    - [x] Fresh install of Arch-based distribution
    - [x] Intel CPU, iGPU
    - [x] Nvidia GPU (appropriate driver)
    - [x] Nvidia Optimus (envycontrol)
- 📦 **Install these programs:**
    - All dependencies, useful tools, font, graphic driver,... [Check here](https://github.com/TTlaugh/Dotfiles/blob/master/pkg/)
    - [dwm](https://github.com/TTlaugh/dwm)
    - [dmenu](https://github.com/TTlaugh/dmenu)
- 🐧 **Apply my dotfiles using `stow`:**
    - Default zsh shell
    - Neovim, alacritty, vifm, dunst,...
    - Login prompt font size
    - Touchpad configuration
    - Useful [scripts](https://github.com/TTlaugh/Dotfiles/tree/master/.local/bin) are in `~/.local/bin/`
- 🔥 **It doesn't come by default but you might need it.**
    - [mutt-wizard](https://github.com/LukeSmithxyz/mutt-wizard)
    - reflector
    - aria2
    - yt-dlp

## ✨ Appearance
- ☄️ Themes: [Dracula](https://draculatheme.com), [Catppuccin](https://github.com/catppuccin/catppuccin), [arc-gtk](https://github.com/horst3180/Arc-theme), TokyoNight ([1](https://github.com/folke/tokyonight.nvim)) ([2](https://github.com/enkia/tokyo-night-vscode-theme)) ([3](https://www.gnome-look.org/p/1681315/))
- 🌸 Icons:
    - [Volantes Cursors](https://www.gnome-look.org/p/1356095)
    - [Tela circle icon](https://www.gnome-look.org/p/1359276)

## 💡 Acknowledgements
- Graphics driver
    - [Xorg](https://wiki.archlinux.org/title/Xorg)
    - [Intel graphics](https://wiki.archlinux.org/title/Intel_graphics)
    - [NVIDIA](https://wiki.archlinux.org/title/NVIDIA), [NVIDIA Optimus](https://wiki.archlinux.org/title/NVIDIA_Optimus)
    - [AMDGPU](https://wiki.archlinux.org/title/AMDGPU)
- Power Management
    - [Hibernation](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Hibernation)
    - [Hibernate on low battery level](https://wiki.archlinux.org/title/laptop#Hibernate_on_low_battery_level)
    - [Hybrid graphics](https://wiki.archlinux.org/title/hybrid_graphics)
    - [Hardware video acceleration](https://wiki.archlinux.org/title/Hardware_video_acceleration)
    - [TLP](https://linrunner.de/tlp/) ([Arch Wiki](https://wiki.archlinux.org/title/TLP))
    - [auto-cpufreq](https://github.com/AdnanHodzic/auto-cpufreq)
- [Maybe Useful tips and tricks](https://github.com/TTlaugh/Dotfiles/tree/master/.github/TIPS.md)

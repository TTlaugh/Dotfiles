<div align="center">
    <img src="banner.png" alt="banner">
</div>
<h3 align="center">
    The <b>Arch Linux & DWM</b> dotfiles!
</h3>

<div align="center">
    <a href="#Screenshots">Screenshots</a>
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

## Screenshots

<p align="center">
  <img align="center" width="49%" src="https://raw.githubusercontent.com/TTlaugh/Dotfiles/master/.github/screenshot1.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/TTlaugh/Dotfiles/master/.github/screenshot2.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/TTlaugh/Dotfiles/master/.github/screenshot3.png" />
  <img align="center" width="49%" src="https://raw.githubusercontent.com/TTlaugh/Dotfiles/master/.github/screenshot4.png" />
</p>

<br>

## ⬇️  Installation

On an Arch-based distribution, run the following:
```
git clone https://github.com/TTlaugh/Dotfiles.git
cd Dotfiles
chmod +x install.sh
./install.sh
```

## 💡 What does this script do?
- 💫 **Autoinstalls and autoconfigures for:**
    - [x] Fresh install of Arch-based distribution
    - [x] Intel CPU, iGPU
    - [x] Nvidia GPU (appropriate driver)
    - [x] Nvidia Optimus (envycontrol)
- 📦 **Install these programs:**
    - All dependencies, useful tools, fonts, graphic drivers,... [Check here](https://github.com/TTlaugh/Dotfiles/blob/master/pkg/)
    - [dwm](https://github.com/TTlaugh/dwm)
    - [dmenu](https://github.com/TTlaugh/dmenu)
- 🐧 **Apply my dotfiles using `stow`:**
    - Default zsh shell
    - Settings for Neovim, alacritty, vifm, dunst,...
    - Login prompt font size
    - Touchpad configuration
    - Useful [scripts](https://github.com/TTlaugh/Dotfiles/tree/master/.local/bin) are in `~/.local/bin/`
- 🔥 **It doesn't come by default but you might need it.**
    - [mutt-wizard](https://github.com/LukeSmithxyz/mutt-wizard)
    - reflector
    - aria2
    - yt-dlp

## ✨ Appearance
- 🌌 Themes: [Dracula](https://draculatheme.com), [Catppuccin](https://github.com/catppuccin/catppuccin), [arc-gtk](https://github.com/horst3180/Arc-theme), [TokyoNight](https://github.com/folke/tokyonight.nvim)
- 🌸 Icons:
    - [Volantes Cursors](https://www.gnome-look.org/p/1356095)
    - [Tela circle icon](https://www.gnome-look.org/p/1359276)
- Firefox: [BeautyFox](https://github.com/TTlaugh/BeautyFox)

## 📖 References
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

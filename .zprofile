#!/bin/sh

# Profile file, runs on login. Environmental variables are set here.

### Path
if [ -d "$HOME/.bin" ]; then
    export PATH="${HOME}/.bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:$PATH"
fi
if [ -d "$HOME/.scripts" ]; then
    export PATH="$PATH:$(find ~/.scripts -type d | paste -sd ':' -)"
fi

### Default programs:
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="chromium"

### ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export HISTFILE="$XDG_DATA_HOME/history"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
### Go
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
### Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
### Java
java_home="$(find /usr/lib/jvm/ -name 'java-1.11.0-openjdk*')"
if [ -z "$java_home" ]; then
    java_home="$(find /usr/lib/jvm/ -name 'java-1.*.0-openjdk*'|tail -n 1)"
fi
export JAVA_HOME="$java_home"
export PATH="$JAVA_HOME/bin:$PATH"
### "bat" as manpager
if [ -n "$(command -v bat)" ]; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
### Other settings:
export QT_QPA_PLATFORMTHEME="gtk2"        # Have QT use gtk2 theme.
export MOZ_USE_XINPUT2=1                  # Mozilla smooth scrolling/touchpads.
export AWT_TOOLKIT="MToolkit wmname LG3D" # May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1      # Fix for Java applications in dwm

### Remap: Caps -> Esc; L+R_Shift -> Caps; Alt <-> Super
setxkbmap -option caps:escape,shift:both_capslock,altwin:swap_alt_win

# Start graphical server on user's current tty if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

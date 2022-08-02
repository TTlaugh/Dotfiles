### Path
if [ -d "$HOME/.bin" ]; then
    export PATH="${HOME}/.bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:$PATH"
fi
if [ -d "$HOME/.scripts" ]; then
    export PATH="${HOME}/.scripts:$PATH"
fi

### Export
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="chromium"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
#export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
#export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
#export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
#export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mbsync/config"

### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

### Remap: Caps -> Esc; L+R_Shift -> Caps; Alt <-> Super
setxkbmap -option caps:escape,shift:both_capslock,altwin:swap_alt_win

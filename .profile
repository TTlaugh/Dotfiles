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
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Remap Caps to Esc
setxkbmap -option caps:escape,shift:both_capslock

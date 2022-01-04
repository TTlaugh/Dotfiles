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

### Default apps
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="chromium"

# Remap Caps to Esc
setxkbmap -option caps:escape,shift:both_capslock

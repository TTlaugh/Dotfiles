if [ -d "$HOME/.bin" ]; then
    export PATH="${HOME}/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:$PATH"
fi

if [ -d "$HOME/.scripts" ]; then
    export PATH="${HOME}/.scripts:$PATH"
fi

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"

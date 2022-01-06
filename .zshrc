### Enable colors and change prompt
autoload -U colors && colors    # Load colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd       # Automatically cd into typed directory.
stty stop undef     # Disable ctrl-s to freeze terminal.
setopt interactive_comments

### History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

### Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.

### Ignore upper and lowercase when TAB completion
zstyle ':completion:*' matcher-list \
    'm:{[:lower:]}={[:upper:]}' \
    '+r:|[._-]=* r:|=*' \
    '+l:|=*'

### source aliases, vimode, fzf, plugins
[ -f "$HOME"/.config/zsh/zsh-aliases ] && source "$HOME"/.config/zsh/zsh-aliases
[ -f "$HOME"/.config/zsh/zsh-vimode ] && source "$HOME"/.config/zsh/zsh-vimode
[ -f "$HOME"/.config/zsh/zsh-fzf ] && source "$HOME"/.config/zsh/zsh-fzf
[ -d "$HOME"/.config/zsh/plugins/zsh-autosuggestions ] && source "$HOME"/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -d "$HOME"/.config/zsh/plugins/zsh-syntax-highlighting ] && source "$HOME"/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

colorscript random

### starship prompt
eval "$(starship init zsh)"

PS1='\[\033[1m\]\[\033[31m\][\[\033[33m\]\u\[\033[32m\]@\[\033[36m\]\h \[\033[35m\]\w\[\033[31m\]]\[\033[33m\]$?\[\033[37m\]\$\[\033[m\] '

set -o vi
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias la='ls $LS_OPTIONS -lA'

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -color=auto"

alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

alias mkdir="mkdir -pv"
alias rmdir="rmdir -v"

up() {
    local d=""
    local limit="$1"

    # Default to limit of 1
    if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
        limit=1
    fi

    for ((i=1;i<=limit;i++)); do
        d="../$d"
    done

    # perform cd. Show error if cd fails
    if ! cd "$d"; then
        echo "Couldn't go up $limit dirs.";
    fi
}

alias vi="nvim"
alias suvi="sudoedit"

alias gst="git status"
alias gaa="git add ."
alias gco="git commit -m"
alias push="git push"
alias pull="git pull"
alias clone="git clone"

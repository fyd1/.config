# coloring of syntax
autoload -U colors && colors

# color python error output
py() {
    python $@ 2>&1 | sed \
        -e "s/File \".*\.py\".*$/${$(printf '\033[0;1;33m')}&${$(printf '\033[0m')}/g" \
        -re "s/\, line [0-9]\+/${$(printf '\033[0;1;31m')}&${$(printf '\033[0m')}/g" \
        -e "s/.*Error:.*$/${$(printf '\033[0;1;31m')}&${$(printf '\033[0m')}/g" \
}

# silent startx boot
launch() {
    exec startx $HOME/.config/xinitrc -- -keeptty >$XDG_DATA_HOME/X/xorg.log 2>&1
}

showXkey() {
    xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

bluelight() {
    redshift -l 49:25 &
    disown
}

# convenience
alias pacman="sudo pacman"
alias attach="tmux attach"
alias rmt="gio trash"
alias a="ls"
alias A="ls -A"
alias vi="nvim"
alias pic="eom"
alias vid="mpv"
alias pdf="atril"
alias config='/usr/bin/git --git-dir=$HOME/.config/configuration --work-tree=$HOME'

# Default coloring of utils
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias less="less -R"
alias ls="ls --color=auto"

# general settings 
setopt extendedglob # extended wild cards matching
setopt nomatch # error when no pattern is found 
setopt correctall # corrects all mistakes 
setopt globdots # include hidden files in wild patters 

# prompt
PROMPT="%B%{$fg[yellow]%}%~
%{$fg[magenta]%}λ: "

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include hidden files
_comp_options+=(globdots)
# color completion output
zstyle ':completion:*:default' list-colors \
  "di=1;36" "ln=35" "so=32" "pi=33" "ex=31" "bd=34;46" "cd=34;43" \
  "su=30;41" "sg=30;46" "tw=30;42" "ow=30;43"

# check .zcompdump only once a day for performance
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# ctrl-s(stops stopping input on ctrl-s)
stty -ixon
# disable zle (execute prompt)
bindkey -a -r ':'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char

# ls colors
eval $(dircolors $HOME/.config/dircolors)

# change cursor to block in normal mode and line in insert
zle-keymap-select () {
if [ $KEYMAP = vicmd ]; then
    printf "\033[2 q"
else
    printf "\033[6 q"
fi
}
zle -N zle-keymap-select
zle-line-init () {
zle -K viins
printf "\033[6 q"
}
zle -N zle-line-init
bindkey -v

# fzf 
source /usr/share/fzf/key-bindings.zsh

# zsh syntax highlighting with dracula theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/include/dracula-syntax.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
# without this cursor dissappears in normal mode
ZSH_HIGHLIGHT_STYLES[cursor]=block

if [ -d "$HOME/.pki" ]; then 
    rm -rf "$HOME/.pki"
fi

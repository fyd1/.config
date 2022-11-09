# xdg specifications #
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_STATE_HOME="$HOME/.local/state"

# "unlimited" history
export HISTFILE="$XDG_CONFIG_HOME/zsh/.histfile"
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE

# PATH 
typeset -U path PATH
path=("$HOME/.local/bin" $path)
export PATH

# make various core utils sort with capital letters first
export LC_COLLATE=C

# keys storage
export AUTH="$HOME/.local/auth"

# default programs #
export OPENER="xdg-open"
export VISUAL="nvim"
export EDITOR="$VISUAL"
export BROWSER="firefox"

# go
export GOPATH="$HOME/.local/lang/go"
# nvidia
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
# xauthority
export XAUTHORITY="$AUTH/Xauthority"
# cleaning ZDOTDIR
export ZSH_COMPDUMP="$ZDOTDIR/cache/.zcompdump-$HOST"
# haskell
export GHCUP_USE_XDG_DIRS=true
# sage math
export DOT_SAGE="$XDG_CONFIG_HOME/sage"
# python
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
# tmux 
export TMUX_TMPDIR="$XDG_DATA_HOME/tmux"
# rust
export CARGO_HOME="$HOME/.local/lang/rust/cargo"
export RUSTUP_HOME="$HOME/.local/lang/rust/rustup"
# gnupg
export GNUPGHOME="$AUTH/gnupg"
# set gtk2 config files
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
# set gtk theme (user installed)
export GTK_THEME="Dracula"
# qt will pick gtk's assigned color scheme
# install qt5-styleplugins
export QT_QPA_PLATFORMTHEME=gtk2
# install qt6gtk2
export QT_STYLE_OVERRIDE=gtk2
# no .lesshist
export LESSHISTFILE="-"
# tex
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TEXMFCONFIG="$XDG_CONFIG_HOME/tex"
export TEXMFHOME="$XDG_CONFIG_HOME/tex"

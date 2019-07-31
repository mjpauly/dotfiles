alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ------- instructions for migrating setup ------- #

# use keyboard system prefs to rebind caps-lock to ctrl

# install solarized for terminal:
# https://github.com/tomislav/osx-terminal.app-colors-solarized

# install pathogen for vim:
# https://github.com/tpope/vim-pathogen

# add to .bash_profile:
# [[ -s ~/.bashrc ]] && source ~/.bashrc

export PS1="\[\033[38;5;6m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]\u\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"

shopt -s histappend
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history'
HISTTIMEFORMAT='%F %T '
shopt -s cmdhist
PROMPT_COMMAND='history -a'

# run a command in a new vertical split pane while leaving the cursor be
# from https://sanctum.geek.nz/arabesque/watching-with-tmux/
function tmw {
    tmux split-window -dh "$*"
}

function vimrc {
    vim ~/.vimrc
}

function bashrc {
    vim ~/.bashrc
}

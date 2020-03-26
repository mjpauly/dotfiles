alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ------- instructions for migrating setup ------- #

# use keyboard system prefs to rebind caps-lock to ctrl

# install solarized for terminal:
# https://github.com/tomislav/osx-terminal.app-colors-solarized

# install vundle

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

function vimrc {
    vim ~/.vimrc
}

function bashrc {
    vim ~/.bashrc
}

function tmuxconf {
    vim ~/.tmux.conf
}

function myth {
    # echo "Current credentials:"
    # klist
    ssh myth.stanford.edu
}

function rice {
    ssh rice.stanford.edu
}

function kinit2 {
    kinit mjpauly@stanford.edu
}

function ppath {
    echo $PATH | tr ':' '\n'
}

alias md="perl ~/Markdown.pl --html4tags"

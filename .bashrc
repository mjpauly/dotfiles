alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ------- instructions for migrating setup ------- #

# use keyboard system prefs to rebind caps-lock to ctrl

# install solarized for terminal:
# https://github.com/tomislav/osx-terminal.app-colors-solarized

# install vundle

# add to .bash_profile:
# [[ -s ~/.bashrc ]] && source ~/.bashrc

export PS1="\[\033[38;5;6m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]\u\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"

# export PS1="\[\033[38;5;196m\]   __
   # \ \_____
# \[\033[38;5;214m\]###\[\033[38;5;196m\][==_____>
   # /_/ \[$(tput sgr0)\]"

shopt -s histappend
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history'
HISTTIMEFORMAT='%F %T '
shopt -s cmdhist
PROMPT_COMMAND='history -a'

alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc"
alias tmuxconf="vim ~/.tmux.conf"

alias myth="ssh -K myth.stanford.edu"
alias mythy="ssh -K -Y myth.stanford.edu"
alias rice="ssh rice.stanford.edu"
alias kinit2="kinit mjpauly@stanford.edu"

alias ppath='echo $PATH | tr ":" "\n"'

alias mfl="ssh mayfieldlinux.local"

alias py="ipython"
alias nb="jupyter notebook"

alias md="perl ~/Markdown.pl --html4tags"
# alias md="echo 'use this: https://github.com/readthedocs/commonmark.py'"
alias grc="/Applications/GNURadio.app/Contents/MacOS/usr/bin/run-grc"

# from https://vi.stackexchange.com/a/17963
vimcd() {
  local tempfile="$HOME/tmp/vimtmpfiles/chdir/chdir"
  vim .
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
      rm $tempfile
    fi
}

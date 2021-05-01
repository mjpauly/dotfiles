alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ------- instructions for migrating setup ------- #

# use keyboard system prefs to rebind caps-lock to ctrl

# migrate over dotfiles
# https://www.atlassian.com/git/tutorials/dotfiles

# install vundle
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install tpm:
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Press prefix + I (capital i, as in Install) to fetch the plugin.

alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc"
alias zshrc="vim ~/.zshrc"
alias tmuxconf="vim ~/.tmux.conf"

alias myth="ssh -K myth.stanford.edu"
alias mythy="ssh -K -Y myth.stanford.edu"
alias rice="ssh rice.stanford.edu"
alias kinit2="kinit mjpauly@stanford.edu"

alias ppath='echo $PATH | tr ":" "\n"'

alias mfl="ssh mayfieldlinux.local"

alias py="ipython"
alias nb="jupyter notebook"

# alias md="perl ~/Markdown.pl --html4tags"
alias md="echo 'use commonmark (pip install commonmark), cmark [in] -o [out]'"
alias grc="/Applications/GNURadio.app/Contents/MacOS/usr/bin/run-grc"

alias sva="source /home/mjpauly/repos/wakey_wakey/venv/bin/activate"

# from https://vi.stackexchange.com/a/17963
vd() {
  local tempfile="$HOME/tmp/vimtmpfiles/chdir/chdir"
  vim .
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
      rm $tempfile
    fi
}

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

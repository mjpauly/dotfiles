# ==================== Personal additions ====================

source ~/.zpath  # contains machine-specific path and environment setup commands
# Must be put here since .zshenv gets sourced before some system environment
# setup commands which prevents prepending to the front of the path.

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ------- Instructions for migrating setup ------- #

# use keyboard system prefs to rebind caps-lock to ctrl

# install zsh:                  $ sudo apt install zsh
# set to default:               $ chsh -s $(which zsh)
# create zpath:                 $ touch ~/.zpath
# install nvim:                 $ sudo apt install neovim

# migrate over dotfiles: (https://www.atlassian.com/git/tutorials/dotfiles)
# echo ".cfg" >> .gitignore             (not needed?)
# git clone --bare https://github.com/mjpauly/dotfiles.git $HOME/.cfg
# alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# config config --local status.showUntrackedFiles no
# config checkout

# install vundle:
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# install plugins with:         $ vim +PluginInstall +qall

# install tmux:                 $ sudo apt install tmux
# install tpm:
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Press prefix + I (capital i, as in Install) to fetch the plugin.

# install ctags:                $ sudo apt install universal-ctags

# install miniforge (mac)

export EDITOR=nvim

autoload -Uz colors && colors
setopt PROMPT_SUBST
PROMPT='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%} '

# file relative to repo root
# usage:
#       nvim $(rr README.md)                    # open README.md in repo root
#       nvim @                                  # open repo root
#       @                                       # cd to repo root
# '@' cannot be joined with a file path since alias expansion happens on words
rr() {
    echo "$(git rev-parse --show-toplevel)/$1"
}
alias -g @="\$(rr)"

mcd () {
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

# Directory shortcuts (like oh-my-zsh)
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias ~='cd ~'

setopt auto_cd auto_pushd pushd_ignore_dups pushd_minus
alias d='dirs -v | head -10'
for i in {1..9}; do alias $i="cd -$i"; done

# alias vimrc="nvim ~/.vimrc"
alias vimrc="nvim ~/.config/nvim/init.vim"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias bashrc="nvim ~/.bashrc"
alias zshrc="nvim ~/.zshrc"
alias zpath="nvim ~/.zpath"
alias zsh_history="nvim ~/.zsh_history"
alias tmuxconf="nvim ~/.tmux.conf"
alias sva="source venv/bin/activate"
alias ipyconf="nvim ~/.ipython/profile_default/ipython_config.py"
alias tsb="tmux show-buffer | pbcopy"
alias gdt="git difftool"

repopath() {
    # Return the full paths to the files produced by the specified repository rule
    # Usage: `repopath "@requirements//:requirements_lock.txt"`
    echo "$(bazel info output_base 2>/dev/null)/$(bazel cquery $1 --output=files 2>/dev/null)"
}

# global zsh function to push branch to remote with 'mjpauly/' prefix.
# commented out in favor of using direnv with `PATH_add ~/.local/gpsu` in .envrc files
# git push --set-upstream origin "$(git branch --show-current):mjpauly/$(git branch --show-current)"

alias watchpdf="open -a Skim"

alias pdl="watch -n 0.5 pio device list"
alias pru="pio run -t upload"
alias pdm="pio device monitor"

alias ppath='echo $PATH | tr ":" "\n"'  # pretty-print the path

alias py="ipython"

alias gitbranches="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"

# alias md="perl ~/Markdown.pl --html4tags"
alias md="echo 'use commonmark (pip install commonmark), cmark [in] -o [out]'"

export TERM=xterm-256color

# This used to work, but haven't figured out how to fix it.
# # Ctrl-w - delete a full WORD (including colon, dot, comma, quotes...)
# my-backward-kill-word () {
    # # Add colon, comma, single/double quotes to word chars
    # local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>:,"'"'"
    # zle -f kill # Append to the kill ring on subsequent kills.
    # zle backward-kill-word
# }
# zle -N my-backward-kill-word
# bindkey '^w' my-backward-kill-word

# from https://vi.stackexchange.com/a/17963
# Change directory using vim's built-in netrw directory explorer.
vd() {
  local tempfile="$HOME/tmp/vimtmpfiles/chdir/chdir"
  nvim .
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
      rm $tempfile
    fi
}

scanify() {
    convert -density 300 "$1" -alpha remove -rotate .3 -attenuate 0.15 \
        +noise Multiplicative +repage -monochrome -compress group4 "$2"
}

# from https://jdhao.github.io/2018/10/19/tmux_nvim_true_color/
colortest() {
    echo "A smooth gradient between colors indicates true color"
    awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
}


# ==================== Ubuntu zshrc default contents ====================

# incappendhistory: add history during sessions but don't share between sessions
# hist_ignore_dups: don't add a command if it matches the immediately preceding one
# extended_history: record a timestamp and duration with the command
setopt incappendhistory hist_ignore_dups extended_history

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# History substring search with up/down arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # Up arrow
bindkey "^[[B" down-line-or-beginning-search  # Down arrow

# Keep many lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000000
SAVEHIST=100000000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit -u # ignore insecure directory warnings, because they just won't go away

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
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

# ==================== After ====================

# Some of these should go in .zpath instead

. "$HOME/.local/bin/env"

[ -f "/Users/matthewpauly/.ghcup/env" ] && . "/Users/matthewpauly/.ghcup/env" # ghcup-envexport DOCKER_HOST=unix:///Users/matthewpauly/.colima/default/docker.sock

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

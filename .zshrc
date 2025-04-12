# ==================== Personal additions ====================

source ~/.zpath  # contains machine-specific path and environment setup commands
# Must be put here since .zshenv gets sourced before some system environment
# setup commands which prevents prepending to the front of the path.

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ------- Instructions for migrating setup ------- #

# use keyboard system prefs to rebind caps-lock to ctrl

# install zsh:                  $ sudo apt install zsh
# set to default:               $ chsh -s $(which zsh)
# install omz:
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

function gpsu { git push --set-upstream origin $(git_current_branch):mjpauly/$(git_current_branch) }

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

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e

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


# ==================== Oh My Zsh ====================

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ==================== After Oh My Zsh ====================

alias gdt="git difftool"

. "$HOME/.local/bin/env"

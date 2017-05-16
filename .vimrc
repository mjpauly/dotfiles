" Load plugins
execute pathogen#infect()

syntax enable

set hlsearch
set number ruler relativenumber
set wrap linebreak

" Remap j and k to move to the line directly below/above even with linewrap on
nmap j gj
nmap k gk

" Tab behavior settings (tab = 4 spaces)
set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab smartindent autoindent

" Press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Bind jj to escape while in insert mode
inoremap jj <Esc>

" Bind <C-k> to comment visually selected blocks with '#' and <C-u> to uncomment
vnoremap <silent> <C-k> :s/^/#/<cr>:noh<cr>
vnoremap <silent> <C-u> :s/^#//<cr>:noh<cr>

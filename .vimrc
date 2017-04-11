syntax on

set hlsearch
set number ruler relativenumber
set wrap linebreak

" remap j and k so that they go to the line directly below even with linewrap on
nmap j gj
nmap k gk

set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab smartindent autoindent

" Press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

:inoremap jj <Esc>

" Load plugins
" execute pathogen#infect()

filetype indent plugin on
syntax enable

set hlsearch
set number ruler
set wrap linebreak

" Remap j and k to move to the line directly below/above even with linewrap on
nnoremap j gj
nnoremap k gk

" Tab behavior settings (tab = 4 spaces)
set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab
" Cause indenting issues for special filetypes:
" smartindent autoindent

" Press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set incsearch

" Bind jj to escape while in insert mode
inoremap jk <Esc>

" Bind <C-k> to comment visually selected blocks with '#' and <C-u> to uncomment
vnoremap <silent> <C-k> :s/^/#/<cr>:noh<cr>
vnoremap <silent> <C-u> :s/^#//<cr>:noh<cr>

" Highlight the end of the max line length
set cc=81
colorscheme darkblue
highlight constant ctermfg=blue
highlight comment ctermfg=green
highlight LineNr ctermfg=brown
highlight ColorColumn ctermfg=brown

" ctags support  $ ctags -R *
set autochdir
set tags=tags;

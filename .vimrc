" Load plugins
execute pathogen#infect()

filetype indent plugin on
syntax enable

set hlsearch
set number ruler
set wrap linebreak

" Remap j and k to move to the line directly below/above even with linewrap on
nnoremap j gj
nnoremap k gk

" Tab behavior settings (tab = 4 spaces)
set expandtab shiftwidth=4 smarttab
" set tabstop=4 softtabstop=4 " testing with this off - <Tabs> will count as 8 spaces
" Cause indenting issues for special filetypes:
" smartindent autoindent

" Press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set incsearch

" Bind jk to escape while in insert mode
inoremap jk <Esc>

" Bind <C-k> to comment visually selected blocks with '#' and <C-u> to uncomment
" Replaced by the more advanced ToggleComment function below
" vnoremap <silent> <C-k> :s/^/#/<cr>:noh<cr>
" vnoremap <silent> <C-u> :s/^#//<cr>:noh<cr>

" Highlight the end of the max line length
" set cc=81
colorscheme peachpuff
" highlight constant ctermfg=blue
" highlight comment ctermfg=green
" highlight LineNr ctermfg=brown
" highlight ColorColumn ctermfg=brown

" ctags support  $ ctags -R *
set autochdir
set tags=tags;

set mouse=a

" Remove some indent keys
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

" Underline the current line for easier cursor visibility
set cursorline

" More involved scripts borrowed from Stack Overflow below =============

" bind C-c and C-v to copy to and paste from the system buffer
" in visual and insert mode respectively
vnoremap <silent> <C-c> :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>
imap <C-v> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

" Comment toggling! Credit to user427390 at https://stackoverflow.com/a/24046914.
let s:comment_map = { 
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \   "matlab": '%',
    \ }
function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " " 
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else 
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction
nnoremap <C-k> :call ToggleComment()<cr>
vnoremap <C-k> :call ToggleComment()<cr>

set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ludovicchabant/vim-gutentags'
" Plugin 'ycm-core/YouCompleteMe'

call vundle#end()

filetype indent plugin on
syntax enable

set hlsearch incsearch
set number ruler "relativenumber
set wrap linebreak

" Tab behavior settings
set expandtab shiftwidth=2 smarttab
" set tabstop=4 softtabstop=4 " testing with this off - <Tabs> will count as 8 spaces
" Cause indenting issues for certain filetypes:
" smartindent autoindent

" BINDINGS ============================================================

let mapleader = "\<Space>"

" Remap j and k to move to the line directly below/above even with linewrap on
nnoremap j gj
nnoremap k gk

" Press <leader>space to turn off highlighting and clear any message already displayed
nnoremap <silent> <leader><Space> :nohlsearch<Bar>:echo<CR>

" Bind jk to escape while in insert mode
inoremap jk <Esc>
inoremap jj _

" Saving and exiting files
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" Q to apply macro stored in q
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Consistent Y
nnoremap Y y$

" Replace word under cursor and continue replacing with '.' or skip with 'n'
nnoremap <Leader>c /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <Leader>C ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

" Same for delete
nnoremap d* /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
nnoremap d# ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN

" Pressing the open brace character in visual mode encloses the highlighted text in the brace
vnoremap ( <Esc>`>a)<Esc>`<i(<Esc>
vnoremap [ <Esc>`>a]<Esc>`<i[<Esc>
vnoremap { <Esc>`>a}<Esc>`<i{<Esc>
vnoremap " <Esc>`>a"<Esc>`<i"<Esc>
vnoremap ' <Esc>`>a'<Esc>`<i'<Esc>
vnoremap ` <Esc>`>a`<Esc>`<i`<Esc>

" For putting a closing brace lower, like with C, Java, etc (Add a <TAB>?)
inoremap {<CR> {<CR>}<Esc>ko

" <leader-direction> for tab movement
nnoremap <leader>l gt
nnoremap <leader>h gT

" Open definition in new tab and open in a vertical split (C-W C-] for horizontal)
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" END BINDINGS ==================================================================

set splitbelow
set splitright

" Highlight the end of the max line length
" set cc=101
colorscheme peachpuff

" ctags support $ctags -R *
" set autochdir
" set tags=tags;
set tags=./tags;

set mouse=a

" Remove some indent keys
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

" Underline the current line for easier cursor visibility
set cursorline

" More involved scripts borrowed from Stack Overflow below ==========================

" bind leader-c and leader-v to copy to and paste from the system buffer
" in visual and insert mode respectively
vnoremap <silent> <leader>c :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>
" inoremap <leader>v <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nnoremap <leader>v :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

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
nnoremap <leader>f :call ToggleComment()<cr>
vnoremap <leader>f :call ToggleComment()<cr>

" more custom bindings =================================================

" copy and paste a line while leaving the first commented out
nnoremap <C-f> yypk:call ToggleComment()<cr>j

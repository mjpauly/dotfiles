set nocompatible
filetype off

" VUNDLE ============================================================

" Vundle  (for help do :h vundle)
" Install with :PluginInstall and update with :PluginUpdate
" Remove with :PluginList and shift-D on the plugin, and also remove from vimrc
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Plugins
" Plugin 'tpope/vim-sensible'  " causes reloading of colorscheme after vimrc :(
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'tpope/vim-speeddating'
Plugin 'glts/vim-magnum'  " dependency of radical
Plugin 'glts/vim-radical'
Plugin 'tpope/vim-fugitive'
Plugin 'https://github.com/APZelos/blamer.nvim.git'
Plugin 'morhetz/gruvbox'
" Plugin 'JuliaEditorSupport/julia-vim'
" Plugin 'szymonmaszke/vimpyter'

call vundle#end()

" END VUNDLE ============================================================

filetype indent plugin on
syntax enable

set hlsearch incsearch
set number ruler
set wrap linebreak

set ignorecase  " case-insensitive search by default; add \C for case-sentitive
                " searching anywhere in pattern

" Tab behavior settings
set expandtab shiftwidth=4 smarttab
" set tabstop=4 softtabstop=4 " testing with this off - <Tabs> will count as 8 spaces
" Cause indenting issues for certain filetypes:
" smartindent autoindent

set laststatus=2
set showcmd

set backspace=indent,eol,start

" NETRW ===============================================================

let g:netrw_liststyle=3

" VIMDIFF =============================================================

" https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" BLAMER ==============================================================

let g:blamer_enabled = 1
" let g:blamer_delay = 500
let g:blamer_relative_time = 1
let g:blamer_show_in_insert_modes = 0

" BINDINGS ============================================================

let mapleader = "\<Space>"

nnoremap <leader>r :Rex<CR>

" Remap j and k to move to the line directly below/above even with linewrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Press <leader>space to turn off highlighting and clear any message already displayed
nnoremap <silent> <leader><Space> :nohlsearch<Bar>:echo<CR>

" Bind jk to escape while in insert mode
inoremap jk <Esc>
inoremap jj _
inoremap JJ _

" Saving and exiting files
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa<CR>

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
" vnoremap " <Esc>`>a"<Esc>`<i"<Esc>
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

" wraps line in parentheses and leaves user in insert mode
" for use in ipython press <F2>
nnoremap <leader>p T=wi(<Esc>A)

" END BINDINGS ==================================================================

set splitbelow
set splitright

" COLOR ============================================================

set termguicolors
" these are needed for vim but not nvim:
if !has('nvim')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set bg=dark
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox  " remember to put highlight commands after this
" colorscheme peachpuff  " remember to put highlight commands after this

" gruvbox colors: https://github.com/morhetz/gruvbox
hi ColorColumn ctermbg=236
hi CursorLine ctermbg=236
hi Folded ctermbg=237
hi FoldColumn ctermbg=237

" Vim diff highlighting
" 256 colors cheat sheet: https://robotmoon.com/256-colors/
" hi DiffAdd ctermfg=black ctermbg=DarkGreen
" hi DiffChange ctermfg=none ctermbg=none
" hi DiffDelete ctermfg=black ctermbg=DarkRed
" hi DiffText ctermfg=black ctermbg=DarkYellow

" Highlight the end of the max line length
set cc=81

autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

" END COLOR ============================================================

" Vimpyter
" let g:vimpyter_view_directory = '$HOME/.vimpyter_views'
" autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
" autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>

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

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

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
    \   "gdb": '#',
    \   "verilog": '\/\/',
    \   "tcl": '#',
    \   "zsh": '#',
    \   "tmux": '#',
    \   "julia": '#',
    \   "scheme": ';',
    \   "bzl": '#',
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

" from https://vi.stackexchange.com/a/17963
" Write directory to temp file
let s:temporary_directory = $HOME . "/tmp/vimtmpfiles/"
let s:chdirectory_directory = s:temporary_directory . "chdir"
let s:chdirectory_file = s:chdirectory_directory . "/chdir"
if !isdirectory(s:chdirectory_directory)
  call mkdir(s:chdirectory_directory, 'p')
endif
function! s:isdir(dir)
  return !empty(a:dir) && (isdirectory(a:dir) ||
        \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfunction
augroup write_chdir
  autocmd!
  autocmd VimLeavePre *
        \ if <SID>isdir(expand('%'))
        \ | call writefile([expand('%:p')], s:chdirectory_file)
        \ | endif
augroup END

" more custom bindings =================================================

" copy and paste a line while leaving the first commented out
nnoremap <C-f> yypk:call ToggleComment()<cr>j

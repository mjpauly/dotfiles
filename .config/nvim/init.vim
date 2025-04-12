" Helpful vim tips:
"
" save a session with :mks sess.vim (filename optional)
" load it back with :source sess.vim or $ nvim -S sess.vim
"
" determine where a setting was set with :verbose set expandtab?

" use packer.vim for plugin management: https://github.com/wbthomason/packer.nvim
" add plugins to ~/.config/nvim/lua/plugins.lua
" install with :PackerInstall
lua require('plugins')
lua require('start')

" Plugin reference:
" Vim radical: gA show representation of number, crd, crx, cro, crb to change

" filetype indent plugin on

set hlsearch incsearch
set number ruler
set wrap linebreak

set ignorecase  " case-insensitive search by default; add \C for case-sentitive
                " searching anywhere in pattern

" Tab behavior settings
set expandtab shiftwidth=4 tabstop=4 smarttab
" set tabstop=4 softtabstop=4 " testing with this off - <Tabs> will count as 8 spaces
" Cause indenting issues for certain filetypes:
" smartindent autoindent

set laststatus=2
set showcmd

set backspace=indent,eol,start

set splitbelow
set splitright

autocmd FileType rust setlocal textwidth=80
let g:rust_recommended_style=0 " overrides textwidth to 99 unless this is set
let g:python_recommended_style = 0 " ftplugin sets expandtab unexpectedly, despite .editorconfig

" Finding files with :fin :sf :tabf
set path+=~/repos/epsilon/
set path+=~/repos/epsilon/src/**
set path+=vbpl/**
set path+=tests/**
set path+=scripts/**


" NETRW ===============================================================

let g:netrw_liststyle=3

" VIMDIFF =============================================================

" https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
" autocmd FilterWritePre * if &diff | setlocal wrap< | endif  " doesn't work?
" au VimEnter * if &diff | execute 'windo set wrap' | endif  " also doesn't?
" lead pipe, but having wrap on all the time by default isn't too bad
autocmd OptionSet * set wrap

" BLAMER ==============================================================

let g:blamer_enabled = 0
let g:blamer_relative_time = 1
let g:blamer_show_in_insert_modes = 0

" BINDINGS ============================================================

" For ideas on what to bind to: https://vim.fandom.com/wiki/Unused_keys

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

" split the line at the current word and join the line with the next
nnoremap <leader>j i<backspace><CR><Esc>J

" Open definition in new tab and open in a vertical split (C-W C-] for horizontal)
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" wraps line in parentheses and leaves user in insert mode
" for use in ipython press <F2>
nnoremap <leader>p T=wi(<Esc>A)

" END BINDINGS ==================================================================

" COLOR ============================================================

set termguicolors

set bg=dark
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox  " remember to put highlight commands after this
" colorscheme peachpuff  " remember to put highlight commands after this

" gruvbox colors: https://github.com/morhetz/gruvbox
hi ColorColumn ctermbg=236
" hi CursorLine ctermbg=236
hi clear CursorLine
hi CursorLine gui=underline cterm=underline
hi Folded ctermbg=237
hi FoldColumn ctermbg=237

" Highlight the column after the textwidth
set cc=+1
" Underline the current line for easier cursor visibility
set cursorline

autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

" END COLOR ============================================================

" ctags support $ctags -R *
" set autochdir
" set tags=tags;
" set tags=./tags;

" Remove some indent keys
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" More involved scripts borrowed from Stack Overflow below ==========================

" bind leader-c and leader-v to copy to and paste from the system buffer
" in visual and normal mode respectively
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
    \   "swift": '\/\/',
    \   "typescript": '\/\/',
    \   "typescriptreact": '\/\/',
    \   "kotlin": '\/\/',
    \   "toml": '#',
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

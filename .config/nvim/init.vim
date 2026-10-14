" Helpful vim tips:
"
" save a session with :mks sess.vim (filename optional)
" load it back with :source sess.vim or $ nvim -S sess.vim
"
" determine where a setting was set with :verbose set expandtab?

" use packer.vim for plugin management: https://github.com/wbthomason/packer.nvim
" add plugins to ~/.config/nvim/lua/plugins.lua
" install with :PackerInstall
lua require("config.lazy")
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
set path+=src/**
set path+=vbpl/**
set path+=tests/**
set path+=scripts/**

" fzf-lua =============================================================

nnoremap <leader>j :FzfLua files<CR>
nnoremap <leader>J :FzfLua files resume=true<CR>
nnoremap <leader>k :FzfLua live_grep<CR>
nnoremap <leader>K :FzfLua live_grep resume=true<CR>

" NETRW ===============================================================

let g:netrw_liststyle=3

" VIMDIFF =============================================================

" https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
" autocmd FilterWritePre * if &diff | setlocal wrap< | endif  " doesn't work?
" au VimEnter * if &diff | execute 'windo set wrap' | endif  " also doesn't?
" lead pipe, but having wrap on all the time by default isn't too bad
" autocmd OptionSet * set wrap
autocmd OptionSet diff if &diff | setlocal wrap | endif

" BLAMER ==============================================================

let g:blamer_enabled = 0
let g:blamer_relative_time = 1
let g:blamer_show_in_insert_modes = 0

" BINDINGS ============================================================

" For ideas on what to bind to: https://vim.fandom.com/wiki/Unused_keys

let mapleader = "\<Space>"

nnoremap <leader>e :e<CR>
nnoremap <leader>t :tabe<CR>

nnoremap <leader>g :Git<CR>

nnoremap <leader>r :Rex<CR>

" Copy into the system clipboard
vnoremap <leader>y "+y

" Remap j and k to move to the line directly below/above even with linewrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Press <leader>space to turn off highlighting and clear any message already displayed
nnoremap <silent> <leader><Space> :nohlsearch<Bar>:echo<CR>

" Bind jk to escape while in insert and terminal mode
inoremap jk <Esc>
tnoremap jk <C-\><C-n>
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
" nnoremap <leader>j i<backspace><CR><Esc>J

" Open definition in new tab and open in a vertical split (C-W C-] for horizontal)
" nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" nnoremap <leader>] :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <leader>] :tab tag <C-r><C-w><CR>
" nnoremap <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" wraps line in parentheses and leaves user in insert mode
" for use in ipython press <F2>
nnoremap <leader>pl T=wi(<Esc>A)

" END BINDINGS ==================================================================

" COLOR ============================================================

set termguicolors

set bg=dark
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox  " remember to put highlight commands after this
" colorscheme peachpuff  " remember to put highlight commands after this

" gruvbox colors: https://github.com/morhetz/gruvbox
hi ColorColumn ctermbg=236
hi clear CursorLine
hi CursorLine gui=NONE cterm=NONE guibg=#3c3836 guisp=NONE
" hi CursorLine gui=underline cterm=underline

hi @operator guibg=NONE

" Highlight the column after the textwidth
set cc=+1
" Underline the current line for easier cursor visibility
set cursorline
set cursorlineopt=number

" If saving multiple times, these stack up and cause longer and longer delays
" autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

" Dark, non-intrusive diff backgrounds (keep syntax fg intact)
" highlight DiffAdd    gui=NONE guifg=NONE guibg=#1e3323 cterm=NONE ctermfg=NONE ctermbg=22
" highlight DiffChange gui=NONE guifg=NONE guibg=#1c2636 cterm=NONE ctermfg=NONE ctermbg=17
" highlight DiffDelete gui=NONE guifg=NONE guibg=#3a1f24 cterm=NONE ctermfg=NONE ctermbg=52
" highlight DiffText   gui=NONE guifg=NONE guibg=#243a54 cterm=NONE ctermfg=NONE ctermbg=24

highlight DiffAdd    gui=NONE guifg=NONE guibg=#2b5235 cterm=NONE ctermfg=NONE ctermbg=22
highlight DiffChange gui=NONE guifg=NONE guibg=#174f63 cterm=NONE ctermfg=NONE ctermbg=17
highlight DiffDelete gui=NONE guifg=NONE guibg=#673936 cterm=NONE ctermfg=NONE ctermbg=52
highlight DiffText   gui=NONE guifg=NONE guibg=#6b5c2f cterm=NONE ctermfg=NONE ctermbg=24

set diffopt+=algorithm:patience
set diffopt+=iwhiteall
set diffopt+=foldcolumn:0  " Don't waste width on fold columns

nnoremap <leader>pr :Git difftool -y main...HEAD<CR>
nnoremap <leader>ps :Git diff --name-status main...HEAD<CR>

" END COLOR ============================================================

" use treesitter for folding
set foldmethod=expr
set foldexpr=v:lua.vim.treesitter.foldexpr()
" don't fold by default
set foldlevel=99

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
    \   "sql": '--',
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


" grab a Github permalink to the selected line range for easy sharing ==

function! s:GithubLink(first, last) abort
  " 1. Get absolute & repo-relative path
  let filepath = expand('%:p')
  let relpath = trim(system("git ls-files --full-name " . shellescape(filepath)))

  if empty(relpath)
    echoerr "File is not tracked by git"
    return
  endif

  " 2. Remote URL → canonical https://github.com/user/repo
  let remote = trim(system("git remote get-url origin"))
  if v:shell_error
    echoerr "Failed to get git remote URL"
    return
  endif

  if remote =~ '^git@'
    " git@github.com:user/repo.git → https://github.com/user/repo
    let remote = substitute(remote, '^git@\([^:]\+\):', 'https://\1/', '')
  endif
  let remote = substitute(remote, '\.git$', '', '')

  " 3. Commit-ish (HEAD for permalink; branch name if you prefer)
  let rev = trim(system("git rev-parse HEAD"))

  " 4. Line range: use range from command invocation
  let start = a:first
  let end   = a:last

  if start == end
    let anchor = '#L' . start
  else
    let anchor = '#L' . start . '-L' . end
  endif

  " 5. Build final URL
  let url = remote . '/blob/' . rev . '/' . relpath . anchor

  " 6. Put in clipboard and show
  let @+ = url
  echo url
endfunction

" Use the command range as arguments to the function
command! -range GhLink call s:GithubLink(<line1>, <line2>)

" Branch review (use <leader>ps to open summary first)

" In the name-status buffer:
" :Git diff --name-status main...HEAD
" then hit dv on a line

" Prior <leader>dv binding:
" nnoremap <leader>dv :call <SID>PrDiffReuseWin('main')<CR>

" In filetype=git and b:fugitive_type=temp buffers, enable the new dv bind
augroup PRDiffMappings
  autocmd!
  autocmd FileType git if get(b:, 'fugitive_type', '') ==# 'temp' |
        \ nnoremap <buffer> dv :call <SID>PrDiffReuseWin('main')<CR> |
        \ endif
augroup END


function! s:PrDiffReuseWin(base) abort
  let l:line = getline('.')

  " Parse path (handle renames: 'R100 old new' -> use new)
  if l:line =~# '^R'
    let l:file = matchstr(l:line, '\v^R\d*\s+\S+\s+\zs.+$')
  else
    let l:file = matchstr(l:line, '\v^\S+\s+\zs.+$')
  endif

  if empty(l:file)
    echo "No file detected on this line"
    return
  endif

  let l:topwin = win_getid()

  " Find an existing window below this one; otherwise create it.
  let l:top = win_screenpos(0)[0]
  let l:review = 0

  for l:w in range(1, winnr('$'))
    call win_gotoid(win_getid(l:w))
    if win_screenpos(0)[0] > l:top
      let l:review = win_getid()
      break
    endif
  endfor

  if l:review == 0
    call win_gotoid(l:topwin)
    belowright split
    let l:review = win_getid()
  endif

  " --- KEY BIT: close all other windows in this tab to avoid split growth ---
  let l:keep = {l:topwin: 1, l:review: 1}
  let l:winids = map(range(1, winnr('$')), 'win_getid(v:val)')
  " close from the end to reduce renumbering surprises
  for l:id in reverse(l:winids)
    if !has_key(l:keep, l:id)
      call win_gotoid(l:id)
      silent! close
    endif
  endfor
  " -------------------------------------------------------------------------

  " Go to review window and reset any old diff state
  call win_gotoid(l:review)
  if &diff
    silent! diffoff!
  endif

  " Save splitright setting and set it off temporarily, so new split is on
  " left
  let l:save_sr = &splitright
  set nosplitright

  " Edit file at HEAD and open fresh vimdiff against base
  execute 'edit' fnameescape(l:file)
  execute 'Gvdiffsplit ' . a:base

  let &splitright = l:save_sr

  " Return to working copy on the right
  wincmd l
endfunction

" Make fugitive diffs follow jumps: when a tag/LSP/quickfix jump lands
" either window of a fugitive diff in a different file, rebuild the diff for
" that file against the same base. Both windows of a live diff pair are
" stamped with w:difffollow = [own winid, partner winid, work-tree path,
" base]. A stamped window later showing a different real file, with its
" partner still open (fugitive auto-diffoffs the partner on jump, but leaves
" it open), means a jump just landed there. The winid in the stamp guards
" against splits, which inherit w: vars.

augroup DiffFollowJump
  autocmd!
  autocmd BufEnter,WinEnter * call s:DiffFollow()
augroup END

function! s:DFStamp(w) abort
  let l:s = getwinvar(a:w, 'difffollow', [])
  return len(l:s) == 4 && l:s[0] == win_getid(a:w) ? l:s : []
endfunction

" Stamp both windows of every live fugitive diff pair in this tab
function! s:DiffFollowScan(...) abort
  for l:w in range(1, winnr('$'))
    let l:bname = bufname(winbufnr(l:w))
    if l:bname !~# '^fugitive://' || !getwinvar(l:w, '&diff')
      continue
    endif
    let l:tree = FugitiveReal(l:bname)
    " Work-tree side candidates: diffed windows showing that very file
    let l:cand = []
    for l:t in range(1, winnr('$'))
      if l:t != l:w && getwinvar(l:t, '&diff')
            \ && getbufvar(winbufnr(l:t), '&buftype') ==# ''
            \ && bufname(winbufnr(l:t)) !~# '^fugitive://'
            \ && fnamemodify(bufname(winbufnr(l:t)), ':p') ==# l:tree
        call add(l:cand, l:t)
      endif
    endfor
    if empty(l:cand)
      continue
    endif
    " Prefer a window that already validly claims this diff over fresh
    " splits of it
    let l:pick = l:cand[0]
    for l:t in l:cand
      let l:s = s:DFStamp(l:t)
      if !empty(l:s) && l:s[2] ==# l:tree
        let l:pick = l:t
        break
      endif
    endfor
    " Object is ':0:path' (index) or 'sha:path'; base is up to last colon
    let l:base = matchstr(FugitiveParse(l:bname)[0], '^.*\ze:')
    call setwinvar(l:w, 'difffollow', [win_getid(l:w), win_getid(l:pick), l:tree, l:base])
    call setwinvar(l:pick, 'difffollow', [win_getid(l:pick), win_getid(l:w), l:tree, l:base])
  endfor
endfunction

function! s:DiffFollow() abort
  if bufname('%') =~# '^fugitive://'
    " Diff setup may be mid-flight; stamp the pair once it settles
    call timer_start(0, function('s:DiffFollowScan'))
    return
  endif
  if &buftype !=# ''
    return
  endif
  let l:stamp = s:DFStamp(winnr())
  if !empty(l:stamp) && expand('%:p') !=# l:stamp[2]
    if win_id2win(l:stamp[1]) > 0
      " A jump landed in this diff window; follow it. Schedule only one
      " rebuild at a time: rapid jumps (C-o/C-i) can fire several BufEnters
      " before the first timer runs, and each extra ReDiff would open a
      " duplicate blob split. ReDiff acts on the window's buffer at fire
      " time, so the single rebuild lands on the newest file anyway.
      let l:pend = get(w:, 'difffollow_pending', [])
      if len(l:pend) != 2 || l:pend[0] != win_getid() || empty(timer_info(l:pend[1]))
        let w:difffollow_pending = [win_getid(),
              \ timer_start(50, function('s:ReDiff', [win_getid(), l:stamp[1], l:stamp[3]]))]
      endif
      return
    endif
    unlet! w:difffollow
  endif
  call s:DiffFollowScan()
endfunction

function! s:ReDiff(filewin, otherwin, base, timer) abort
  if win_gotoid(a:otherwin)
    silent! close
  endif
  if !win_gotoid(a:filewin)
    return
  endif
  " diffoff! (all windows): re-entering a previously-diffed buffer restores
  " its saved diff option, leaving stale participants in the tab
  silent! diffoff!
  " Stage numbers (:0-:3) mean an index diff; bare Gvdiffsplit handles that.
  " Explicit leftabove: with an argument fugitive has no direction default
  " and 'splitright' would put the base on the right.
  execute 'leftabove Gvdiffsplit' (a:base =~# '^:\=\d$' ? '' : fnameescape(a:base))
  call win_gotoid(a:filewin)
  diffupdate
  call s:DiffFollowScan()
endfunction


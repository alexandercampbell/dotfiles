
" remove all autocommands to prevent them from being loaded twice
au!

" required for Vundle setup
se nocompatible
filetype off

" plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-vinegar'			" Better file browser
Plugin 'bling/vim-airline'			" Better status line
Plugin 'fatih/vim-go'				" Go language support
Plugin 'altercation/vim-colors-solarized'	" Solarized colorscheme
call vundle#end()

" reenable filetype, syntax
filetype plugin indent on
syntax enable

" better indentation
se autoindent
se backspace=indent,eol,start
se complete-=i
se smarttab

" better status line (probably overriden by airline, but nice to have if
" plugins aren't working for some reason)
set laststatus=2
set ruler
set showcmd

" highlight/incremental search
se hlsearch incsearch

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" intuitive window splits
se splitbelow
se splitright

" wildmenu completion
set wildmenu
set wildmode=list:longest

" keep context around the edge of the screen when the cursor is moving
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" faster custom keybindings. The important ones here are `q` and `w`. I
" save/quit a LOT. The vim default of needing four keys to save the file
" (shift-colon-w-return) is ridiculous and defeats the whole point of having a
" modal editor. In normal mode, w should save.
nmap ` :E<CR>
nmap <Tab> <C-w>w
nmap <S-Tab> <C-w><S-w>
nmap q :q<CR>
nmap w :w<CR>
nmap <space> zz
map <C-c> <Esc>

" enable mouse
se mouse=a

" no introductory message when starting vim
se shm=I

" jump to last edited position in file instead of always starting at the
" top line, leftmost column
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif

" Line numbering, format options, color column, etc.
se nu
se fo+=c
se fo-=t
se wm=0
se cc=+1 " colorcolumn
hi ColorColumn ctermbg=7 "non-pink colorcolumn

" always be in directory of currently edited file
autocmd BufEnter * silent! lcd %:p:h

" Colorscheme. Solarized is the best I've found.
let g:solarized_contrast = "high"
colo solarized
se bg=light
syn on

" highlight searches with light blue instead of the default annoyingly-bright
" yellow
hi Search cterm=none ctermbg=lightblue

" hide autocompletion window on movement
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" random bindings for Go programming
au FileType go nmap <F5> :!clear && go test<CR>
au FileType go nmap <F3> :!clear && go test -short<CR>
au FileType go nmap <F4> :!clear && go test -short<CR>
au FileType go nmap <F6> :!clear && go test -v<CR>
au FileType go nmap <F7> :!clear && go test -v -bench .<CR>
au FileType go nmap <F8> :!clear && go build<CR>
au FileType go nmap <F9> :!clear && go build -o vimtestmain.out && ./vimtestmain.out && rm vimtestmain.out<CR>
au FileType go se tw=92
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"

" random autocommand/bindings for miscellaneous programming languages
au FileType c map <F5> <C-C>:!clear && clang --analyze *.c<CR>
au FileType haskell map <F9> <C-C>:!clear && ghc % -o vimtestmain.out && ./vimtestmain.out && rm vimtestmain.out<CR>
au FileType yaml se ts=4 sw=4 et
au FileType javascript se ts=4 sw=4 et
au FileType python se ts=4 sw=4 et
au FileType python map <F9> <C-C>:!clear && python %<CR>
au FileType lua map <F9> <C-c>:!clear && ~/apps/love .<CR>
au BufRead,BufNewFile *.md set ft=markdown tw=80
au BufRead,BufNewFile *.yaml se ft=yaml


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Everything below this line was copied from vim-sensible. I don't need all of
" it, but it can't hurt.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

se nrformats-=octal
se ttimeout
se ttimeoutlen=100

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif

if &shell =~# 'fish$'
  set shell=/bin/bash
endif

set autoread
set fileformats+=mac

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

" vim:set ft=vim et sw=2:


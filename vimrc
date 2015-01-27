
" Set this to 1 to use only options that can be set without plugins.
let portable_mode=0

" remove all autocommands to prevent them from being loaded twice
au!

" required for Vundle setup
se nocompatible
filetype off

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  plugins
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if portable_mode == 0
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  " Basic plugins
  Plugin 'gmarik/Vundle.vim'
  Plugin 'tpope/vim-vinegar'               " Better file browser
  Plugin 'fatih/vim-go'                    " Go language support
  Plugin 'wting/rust.vim'                  " Rust language support
  Plugin 'tpope/vim-fugitive'              " git plugin
  Plugin 'kien/ctrlp.vim'                  " Fuzzy file matching
  "Plugin 'scrooloose/syntastic'            " Syntax checking (10/10 would check)
  Plugin 'tpope/vim-unimpaired'            " Jump through error list with ]l
  Plugin 'rest.vim'                        " Support for REStructured Text
  Plugin 'bronson/vim-trailing-whitespace' " Highlight trailing whitespace
  Plugin 'haya14busa/incsearch.vim'        " Consistent n/N direction
  Plugin 'AutoComplPop'                    " Autocompletion as I type
  Plugin 'jeroenbourgois/vim-actionscript' " Actionscript support
  Plugin 'dart-lang/dart-vim-plugin'       " Dart plugin

  " Colorschemes
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'tpope/vim-vividchalk'
  Plugin 'wombat256.vim'
  Plugin 'Lokaltog/vim-distinguished'
  Plugin 'morhetz/gruvbox'
  Plugin 'noahfrederick/vim-hemisu'
  Plugin 'reedes/vim-colors-pencil'
  Plugin 'jnurmine/Zenburn'
  Plugin 'zenorocha/dracula-theme'
  Plugin 'chriskempson/base16-vim'
  Plugin 'sjl/badwolf'

  call vundle#end()

  " Plugin configurations
  let g:syntastic_always_populate_loc_list = 1
  let g:go_fmt_fail_silently = 1
  let g:go_fmt_command = "goimports"

  " CTRL-P: ignore things that aren't tracked by git
  " Thanks to https://github.com/kien/ctrlp.vim/issues/174#issuecomment-49747252
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

  " Better incsearch plugin configuration
  let g:incsearch#consistent_n_direction = 1
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" reenable filetype, syntax
filetype plugin indent on
syntax enable

" better indentation
se autoindent
se backspace=indent,eol,start
se complete-=i
se smarttab

se virtualedit=block

" status line improvements (probably overriden by my status line plugin, but
" nice to have if plugins aren't working for some reason)
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

" clear background in terminal so that colorschemes work without glitching
se t_ut=

" wildmenu completion
set wildmenu
set wildmode=longest,list,full

" keep context around the edge of the screen when the cursor is moving
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Leader stuff
let mapleader = "\\"
nmap <leader>l :CtrlP<CR>

" faster custom keybindings. The important ones here are `q` and `w`. I
" save/quit a LOT. The vim default of needing four keys to save the file
" (shift-colon-w-return) is ridiculous and defeats the whole point of having a
" modal editor. In normal mode, a single key should save.
noremap q :q<CR>
noremap w :w<CR>
noremap D S<Esc>
noremap <Tab> <C-w>w
noremap <S-Tab> <C-w><S-w>
noremap <space> zz
noremap <C-g> 1<C-g>
noremap B ^
noremap E $
map <C-c> <Esc>

" In portable mode, open the file explorer with `-`. The reason this is
" conditionally specified is because `-` is bound to the vim-vinegar plugin in
" non-portable mode.
if portable_mode
  nmap - :E<CR>
end

" Hide introductory message when starting vim.
se shm=aI

" jump to last edited position in file instead of always starting at the
" top line, leftmost column
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif

" Always cd to the directory of the current buffer. Better for running
" commandline stuff and editing adjacent files.
autocmd BufEnter * silent! lcd %:p:h

" Color-related settings
if portable_mode == 0
  se t_Co=256
  colo zenburn
else
  se t_Co=8
  colo slate
endif

" Line numbering, format options, color column, etc.
se number
se formatoptions+=c
se formatoptions-=t
se wrapmargin=0
se linebreak
se textwidth=80
" highlight line containing the cursor
se cursorline
" Highlight selection as black on white instead of whatever the colorscheme
" does by default.
hi Visual ctermbg=white ctermfg=black
" colorcolumn
se colorcolumn=+1
hi ColorColumn ctermbg=black

" Highlight searches with lightblue instead of annoyingly-bright yellow
hi Search cterm=none ctermbg=lightblue

" Don't join together lines with two spaces after each period.
se nojoinspaces

" hide autocompletion window on cursor movement
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" rust programming bindings
" The `cargo clean` is on here so that the source is recompiled each time, to
" make sure we get compiler warnings.
au FileType rust nmap <buffer> <F4> :!clear && cargo test<CR>
au FileType rust nmap <buffer> <F5> :!clear && cargo test<CR>
au FileType rust nmap <buffer> <F6> :!clear && cargo test --verbose<CR>
au FileType rust nmap <buffer> <F9> :!clear && cargo run<CR>

" Random bindings for Go programming. Some of these are duplicates. This is
" intentional.
au FileType go nmap <buffer> <F5> :!clear && go test<CR>
au FileType go nmap <buffer> <F3> :!clear && go test -short<CR>
au FileType go nmap <buffer> <F4> :!clear && go test -short<CR>
au FileType go nmap <buffer> <F6> :!clear && go test -v<CR>
au FileType go nmap <buffer> <F7> :!clear && go test -v -bench .<CR>
au FileType go nmap <buffer> <F8> :!clear && go build<CR>
au FileType go nmap <buffer> <F9> :!clear; go build -o vimmain.out; ./vimmain.out; rm vimmain.out<CR>

" recognize file extensions as the correct filetypes
au BufRead,BufNewFile *.md set ft=markdown
au BufRead,BufNewFile *.yaml se ft=yaml
" restructured text
au BufRead,BufNewFile *.rst se ft=rest
" header files are marked as C++ by default
au BufRead,BufNewFile *.h se ft=c

" Use the canonically accepted tab sizes for yaml, js, and python
au FileType yaml setl ts=4 sw=4 et
au FileType javascript setl ts=4 sw=4 et
au FileType html setl ts=4 sw=4 et
au FileType python setl ts=4 sw=4 et
au FileType rest setl tw=92

" random autocommand bindings for miscellaneous programming languages
au FileType c nmap <buffer> <F5> :!clear && clang --analyze *.c *.h<CR>
au FileType c nmap <buffer> <F9> :make<CR>
au FileType python nmap <buffer> <F5> :!clear && python3 %<CR>
au FileType python nmap <buffer> <F9> :!clear && python3 %<CR>
au FileType lua nmap <buffer> <F5> :!clear && love . --test<CR>
au FileType lua nmap <buffer> <F9> :!clear && love .<CR>
au FileType markdown nmap <buffer> <F9> :!pandoc -o %.html % && xdg-open %.html<CR>
au FileType html nmap <buffer> <F9> :!clear && xdg-open %<CR>

" gui options
se guifont=Consolas\ 11
se guioptions-=m
se guioptions-=T
se guioptions-=r
se guioptions-=L

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Everything below this line was copied from vim-sensible. I don't need all of
" it, but it can't hurt. This is not all of vim-sensible, just the stuff I
" haven't already covered above.
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

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

" vim:set ft=vim et sw=2:


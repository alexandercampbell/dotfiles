
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
  Plugin 'tpope/vim-vinegar'              " Better file browser
  Plugin 'fatih/vim-go'                   " Go language support
  Plugin 'wting/rust.vim'                 " Rust language support
  Plugin 'tpope/vim-fugitive'             " git plugin
  Plugin 'itchyny/lightline.vim'          " Best status line
  Plugin 'kien/ctrlp.vim'                 " Fuzzy file matching
  Plugin 'kien/rainbow_parentheses.vim'   " Rainbow parens
  Plugin 'scrooloose/syntastic'

  " Colorschemes
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'tpope/vim-vividchalk'
  Plugin 'wombat256.vim'
  Plugin 'Lokaltog/vim-distinguished'
  Plugin 'morhetz/gruvbox'
  Plugin 'noahfrederick/vim-hemisu'
  Plugin 'reedes/vim-colors-pencil'
  Plugin 'jnurmine/Zenburn'

  call vundle#end()

  " Plugin configurations
  let g:solarized_contrast = "high"
  let g:lightline = {'colorscheme': 'wombat'}

  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
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
" modal editor. In normal mode, a single key should save.
nmap q :q<CR>
nmap w :w<CR>
nmap <Tab> <C-w>w
nmap <S-Tab> <C-w><S-w>
nmap <space> zz
nmap ` :Explore<CR>
map <C-c> <Esc>

" In portable mode, open the file explorer with `-`. The reason this is
" conditionally specified is because `-` is bound to the vim-vinegar plugin in
" non-portable mode.
if portable_mode
  nmap - :E<CR>
end

" Hide introductory message when starting vim.
se shm=I

" jump to last edited position in file instead of always starting at the
" top line, leftmost column
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif

" Always cd to the directory of the current buffer. Better for running
" commandline stuff and editing adjacent files.
autocmd BufEnter * silent! lcd %:p:h

" Line numbering, format options, color column, etc.
se nu
se fo+=c
se fo-=t
se wm=0
se cc=+1 " colorcolumn
se cul " highlight line containing the cursor
hi ColorColumn ctermbg=7 "non-pink colorcolumn

" Color-related settings
if portable_mode == 0
  se t_Co=256
  se bg=dark
  colo zenburn
else
  se t_Co=8
  colo slate
endif

" Highlight searches with lightblue instead of annoyingly-bright yellow
hi Search cterm=none ctermbg=lightblue

" Don't join together lines with two spaces after each period.
se nojoinspaces

" hide autocompletion window on cursor movement
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Automatically save on buffer change
se autowriteall

" rust programming bindings
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
au FileType go nmap <buffer> <F9> :!clear; go build -o vimtestmain.out; ./vimtestmain.out; rm vimtestmain.out<CR>

au FileType go se tw=80
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"

" recognize file extensions as the correct filetypes
au BufRead,BufNewFile *.md set ft=markdown tw=80
au BufRead,BufNewFile *.yaml se ft=yaml

" Use the canonically accepted tab sizes for yaml, js, and python
au FileType yaml se ts=4 sw=4 et
au FileType javascript se ts=4 sw=4 et
au FileType python se ts=4 sw=4 et

" random autocommand bindings for miscellaneous programming languages
au FileType c nmap <buffer> <F5> :!clear && clang --analyze *.c<CR>
au FileType haskell nmap <buffer> <F9> :!clear && ghc % -o vimtestmain.out && ./vimtestmain.out && rm vimtestmain.out<CR>
au FileType python nmap <buffer> <F5> :!clear && python %<CR>
au FileType python nmap <buffer> <F9> :!clear && python %<CR>
au FileType lua nmap <buffer> <F9> :!clear && ~/apps/love .<CR>
au FileType markdown nmap <buffer> <F9> :!pandoc -o %.html % && xdg-open %.html<CR>

" spellchecking in markdown files
au FileType markdown setl spell spelllang=en_us


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


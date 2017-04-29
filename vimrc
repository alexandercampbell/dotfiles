
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
  Plugin 'rust-lang/rust.vim'              " Rust language support
  Plugin 'racer-rust/vim-racer'            " Rust code completion
  Plugin 'tpope/vim-fugitive'              " git plugin
  Plugin 'ctrlpvim/ctrlp.vim'              " Fuzzy file matching
  "Plugin 'scrooloose/syntastic'            " Syntax checking (10/10 would check)
  Plugin 'tpope/vim-unimpaired'            " Jump through error list with ]l
  Plugin 'bronson/vim-trailing-whitespace' " Highlight trailing whitespace
  Plugin 'AutoComplPop'                    " Autocompletion as I type
  Plugin 'dart-lang/dart-vim-plugin'       " Dart plugin
  Plugin 'cespare/vim-toml'                " TOML syntax highlighting
  Plugin 'sickill/vim-pasta'               " Better pasting
  Plugin 'guns/vim-clojure-static'         " Clojure support
  Plugin 'solarnz/thrift.vim'              " Thrift synatx highlight
  Plugin 'leafo/moonscript-vim'            " Moonscript support
  Plugin 'vim-airline/vim-airline'         " Cool status bar
  Plugin 'vim-airline/vim-airline-themes'  " Plugins for airline
  Plugin 'ElmCast/elm-vim'                 " Elm support

  " Colorschemes
  Plugin 'jnurmine/Zenburn'
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'wombat256.vim'
  Plugin 'xoria256.vim'
  Plugin 'apprentice.vim'
  Plugin 'alexandercampbell/base16-vim'
  Plugin 'scwood/vim-hybrid'
  Plugin 'AlessandroYorba/Sierra'
  Plugin 'marcopaganini/termschool-vim-theme'
  Plugin 'vim-scripts/blackdust.vim'
  Plugin 'romainl/Disciple'
  Plugin 'morhetz/gruvbox'
  Plugin 'alessandroyorba/despacio'

  call vundle#end()

  " Plugin configurations
  let g:rustfmt_autosave = 1
  let g:rustfmt_fail_silently = 1
  let g:syntastic_always_populate_loc_list = 1
  let g:go_fmt_fail_silently = 1
  let g:syntastic_auto_jump = 1
  let g:syntastic_auto_loc_list = 3
  let g:go_fmt_command = "goimports"
  let g:netrw_liststyle = 1
  let g:zenburn_force_dark_Background = 0
  let g:ctrlp_custom_ignore = {
        \ 'dir': '\v[\/](target)|(dist)|(node_modules)|(Godeps)|(vendor)|(build)|(elm-stuff)$',
        \ 'file': '\v\.*(.class)|\.*(.pyc)|\.*(.d|o)$',
        \ }
  let g:ctrlp_working_path_mode = 'a'
  let g:racer_cmd = $HOME . "/.cargo/bin/racer"
  let $RUST_SRC_PATH = $HOME . "/workspace/src/github.com/rust-lang/rust/src"
  let g:airline_powerline_fonts = 1
  let g:elm_format_autosave = 1
  let g:elm_format_fail_silently = 1
  let g:elm_setup_keybindings = 0

  au FileType rust nmap gd <Plug>(rust-def)
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" reenable filetype, syntax
filetype plugin indent on
syntax enable

" disable backups
se nobackup nowritebackup

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
set shortmess=t

" highlight/incremental search
se hlsearch incsearch
" Ignore case by default when searching.
set ignorecase

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" intuitive window splits
se splitbelow
se splitright

" clear background in terminal so that colorschemes work without glitching
se t_ut=

" enable mouse so accidental scrolling doesn't fuck up the terminal
se mouse=a

" wildmenu completion
set wildmenu
set wildmode=longest,list,full
if has("wildignorecase")
  " wildignorecase is a new option, so we feature check for it
  set wildignorecase
end

" keep context around the edge of the screen when the cursor is moving
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Leader stuff
let mapleader = " "

" faster custom keybindings. The important ones here are `q` and `w`. I
" save/quit a LOT. The vim default of needing four keys to save the file
" (shift-colon-w-return) is ridiculous and defeats the whole point of having a
" modal editor. In normal mode, a single key should save.
nnoremap q :q<CR>
nnoremap w :w<CR>
nnoremap D S<Esc>
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w><S-w>
nnoremap = <C-w>=
nnoremap <C-g> 1<C-g>
nnoremap B ^
nnoremap E $
inoremap <C-c> <Esc>

" NetRW registers some keybinds that interfere with my usage of `q` for `quit`.
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call CustomNetrwSetup()
augroup END

function! CustomNetrwSetup()
  unmap <buffer> qF
  unmap <buffer> qL
  unmap <buffer> qf
  unmap <buffer> qb
endfunction

" Consistency with my tmux bindings.
"
" My tmux leader is <C-space>, and my vim leader is <space>. '<space>v' creates
" a new vertical split in vim, while '<C-space>v' creates a new vertical split
" in tmux.
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>s :sp<CR>
nnoremap <leader>v :vs<CR>
nnoremap <leader>d <C-z>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <Leader>o <C-i>
nnoremap <leader><S-h> <C-w><S-h>
nnoremap <leader><S-j> <C-w><S-j>
nnoremap <leader><S-k> <C-w><S-k>
nnoremap <leader><S-l> <C-w><S-l>
nnoremap <leader><bar> <C-w><bar>
nnoremap <leader>_ <C-w>_
nnoremap <leader>= <C-w>=
nnoremap <leader>c :tabnew<CR>
nnoremap <leader>n :tabnext<CR>
nnoremap <leader>p :tabprevious<CR>
nnoremap <leader>N :NERDTreeToggle<CR>

nnoremap <C-w>h <space>
nnoremap <C-w>j <space>
nnoremap <C-w>k <space>
nnoremap <C-w>l <space>
nnoremap <C-w><S-h> <space>
nnoremap <C-w><S-j> <space>
nnoremap <C-w><S-k> <space>
nnoremap <C-w><S-l> <space>
nnoremap <C-w><bar> <space>
nnoremap <C-w>_ <space>
nnoremap <C-w>= <space>

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

" Color-related settings
if portable_mode == 0
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  se termguicolors
  se bg=dark
  "call g:airline#switch_theme("term")
  call g:airline#switch_theme("distinguished")
  colo gruvbox
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
"se cursorline
" Highlight selection as black on white instead of whatever the colorscheme
" does by default.
hi Visual ctermbg=white ctermfg=black
" colorcolumn
se colorcolumn=+1
"hi ColorColumn ctermbg=236

" Highlight searches with lightblue instead of annoyingly-bright yellow
hi Search cterm=none ctermbg=lightblue

" Don't join together lines with two spaces after each period.
se nojoinspaces

" hide autocompletion window on cursor movement
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" rust programming bindings
au FileType rust nmap <buffer> <F4> :!cargo test<CR>
au FileType rust nmap <buffer> <leader><CR> :!cargo test<CR>
au FileType rust nmap <buffer> <F6> :!cargo test --verbose<CR>
au FileType rust nmap <buffer> <F9> :!cargo run<CR>
au FileType rust setl tw=92

" elixir programming bindings
au FileType elixir nmap <buffer> <F4> :!mix test<CR>
au FileType elixir nmap <buffer> <F5> :!mix test<CR>

" Random bindings for Go programming. Some of these are duplicates. This is
" intentional.
au FileType go nmap <buffer> <F3> :!go test -short<CR>
au FileType go nmap <buffer> <leader><CR> :GoTest<CR>
au FileType go nmap <buffer> <leader><CR> :GoTest<CR>
au FileType go nmap <buffer> <F6> :!go test -v<CR>
au FileType go nmap <buffer> <F7> :!go test -v -bench .<CR>
au FileType go nmap <buffer> <F8> :GoBuild<CR>
au FileType go nmap <buffer> <F9> :GoRun<CR>

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
au FileType elm setl ts=4 sw=4 et
au FileType elixir setl ts=4 sw=4 et
au FileType lua setl ts=4 sw=4 et
au FileType moon setl ts=4 sw=4 et
au FileType rest setl tw=92
au FileType dart setl ts=2 sw=2 et

" random autocommand bindings for miscellaneous programming languages
au FileType c nmap <buffer> <F4> :make<CR>
au FileType c nmap <buffer> <F5> :make<CR>
au FileType c nmap <buffer> <F9> :make run<CR>
au FileType python nmap <buffer> <F5> :!python %<CR>
au FileType python nmap <buffer> <F9> :!python %<CR>
au FileType python nmap gd <Plug>(go-def)
au FileType lua nmap <buffer> <F5> :!love . --test<CR>
au FileType lua nmap <buffer> <F9> :!love .<CR>
au FileType markdown nmap <buffer> <F9> :!open %<CR>
au FileType markdown setl spell
au FileType html nmap <buffer> <F9> :!open %<CR>

" paste ~/.pr-message into `hub pull-request`
au BufRead,BufNewFile PULLREQ_EDITMSG :1 | read ~/.pr-message | 4

" gui options
if has("gui_running")
  se bg=dark
  colo base16-ocean
  se guioptions-=m
  se guioptions-=T
  se guioptions-=r
  se guioptions-=L
  se guifont=ProggyCleanTT:h13
  se guifont=Monaco:h10
  se noantialias
endif

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


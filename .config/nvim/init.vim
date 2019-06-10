
" remove all autocommands to prevent them from being loaded twice
autocmd!

se nocompatible
filetype off

call plug#begin('~/.config/nvim/plugged')
  " Basic plugins
  Plug 'tpope/vim-vinegar'               " Better file browser
  Plug 'tpope/vim-fugitive'              " git plugin
  Plug 'tpope/vim-unimpaired'            " Jump through error list with ]l
  Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy file matching
  Plug 'ntpeters/vim-better-whitespace'  " Highlight trailing whitespace
  Plug 'w0rp/ale'                        " In-editor linting
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete

  " Specific language support
  Plug 'ElmCast/elm-vim'                   " Elm support
  Plug 'cespare/vim-toml'                  " TOML syntax highlighting
  Plug 'fatih/vim-go'                      " Go language support
  Plug 'racer-rust/vim-racer'              " Rust code completion / jump-to-def
  Plug 'rust-lang/rust.vim'                " Rust language support
  Plug 'tbastos/vim-lua'                   " Better Lua colors than builtin

  " Colorschemes
  Plug 'jnurmine/Zenburn'
  Plug 'morhetz/gruvbox'
  Plug 'nightsense/snow'
  Plug 'letorbi/vim-colors-modern-borland'
call plug#end()

" Plugin configurations
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 1
let g:syntastic_always_populate_loc_list = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:zenburn_force_dark_Background = 0
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](target)|(dist)|(node_modules)|(Godeps)|(vendor)|(build)|(elm-stuff)$',
      \ 'file': '\v\.*(.class)|\.*(.pyc)$',
      \ }
let g:ctrlp_working_path_mode = 'a'
let g:racer_cmd = $HOME . "/.cargo/bin/racer"
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 1
let g:elm_setup_keybindings = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_sign_column_always = 1
let g:go_template_autocreate = 1
let g:BorlandStyle = "classic"
let g:deoplete#enable_at_startup = 1

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

" jump-to-definition should work even without saving the current file.
se hidden

" go past the ends of lines in visual block mode (^v)
se virtualedit=block

" status line improvements
set laststatus=2
set ruler!
set shortmess=at

" highlight/incremental search
se hlsearch incsearch
" Ignore case by default when searching.
set ignorecase smartcase

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Intuitive window split directions
se splitbelow splitright

" enable mouse so accidental scrolling doesn't fuck up the terminal
se mouse=a

" wildmenu completion
set wildmenu
set wildmode=longest,list,full
if has("wildignorecase")
  " wildignorecase is a new option, so we feature check for it
  set wildignorecase
end

" Disable swapfile
se noswapfile

" keep context around the edge of the screen when the cursor is moving
set scrolloff=3

" display unprintable characters as <xx>
set display=truncate,uhex

" faster custom keybindings. The important ones here are `q` and `w`. I
" save/quit a LOT. The vim default of needing four keys to save the file
" (shift-colon-w-return) is ridiculous and defeats the whole point of having a
" modal editor. In normal mode, a single key should save.
nnoremap q :q<CR>
nnoremap w :w<CR>
nnoremap = <C-w>=
nnoremap <C-g> 1<C-g>

" Consistency with my tmux bindings.
"
" My tmux leader is <C-space>, and my vim leader is <space>. '<space>v' creates
" a new vertical split in vim, while '<C-space>v' creates a new vertical split
" in tmux.
let mapleader = " "
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>s :sp<CR>
nnoremap <leader>v :vs<CR>
nnoremap <leader>d :r !date '+\%Y\%m\%d'<CR>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader><S-h> <C-w><S-h>
nnoremap <leader><S-j> <C-w><S-j>
nnoremap <leader><S-k> <C-w><S-k>
nnoremap <leader><S-l> <C-w><S-l>
nnoremap <leader><bar> <C-w><bar>
nnoremap <leader>_ <C-w>_
nnoremap <leader>= <C-w>=

" Allow q to be used with leader-q
nnoremap <leader>q q

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

" Hide introductory message when starting vim.
se shm=aI

" jump to last edited position in file instead of always starting at the
" top line, leftmost column
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif

" Color-related settings
se termguicolors
se bg=light
colo gruvbox

" Line numbering, format options, color column, etc.
se number
se formatoptions+=c
se formatoptions+=t
se formatoptions+=n
se wrapmargin=0
se linebreak
se textwidth=80
se showmatch
se colorcolumn=+1
se cursorline

" Highlight searches with lightblue instead of annoyingly-bright yellow
hi Search cterm=none ctermbg=lightblue

" Don't join together lines with two spaces after each period.
se nojoinspaces

" Treat identifiers separated with `-` as words.
se iskeyword=@,48-57,_,192-255,-

" Recognize fold markers in the text
se foldmethod=marker

" rust programming bindings
au FileType rust nmap <buffer> <CR> :!cargo test<CR>
au FileType rust setl tw=92
au FileType rust setl ts=4 sw=4 et
au FileType rust nmap gd <Plug>(rust-def)

" recognize file extensions as the correct filetypes
au BufRead,BufNewFile *.md set ft=markdown
au BufRead,BufNewFile *.yaml se ft=yaml
au BufRead,BufNewFile *.py3 se ft=python
au BufRead,BufNewFile README se spell
au FileType markdown setl spell
au FileType gitcommit setl spell

" Use the canonically accepted indentation in certain filetypes.
au FileType yaml                setl ts=4 sw=4 et
au FileType tex                 setl ts=4 sw=4 et
au FileType javascript          setl ts=4 sw=4 et
au FileType java                setl ts=4 sw=4 et
au FileType json                setl ts=4 sw=4 et
au FileType python              setl ts=4 sw=4 et
au FileType elm                 setl ts=4 sw=4 et
au FileType elixir              setl ts=4 sw=4 et
au FileType lua                 setl ts=4 sw=4 et
au FileType dart                setl ts=2 sw=2 et
au FileType html                setl ts=2 sw=2 et
au FileType haskell             setl ts=4 sw=4 et
au FileType tex                 setl ts=4 sw=4 et
au FileType pug                 setl ts=4 sw=4 et

" Random autocommand bindings for miscellaneous programming languages.
" I have a convention: pressing enter means 'give me feedback now'. Normally
" this means running the unit tests.
au FileType rust nmap gd <Plug>(rust-def)
au FileType c,cpp nmap <buffer> gd <C-]>
au FileType go nmap <buffer> <CR> :GoTest<CR>
au FileType moon nmap <buffer> <CR> :!make run<CR>
au FileType lua nmap <buffer> <CR> :!love .<CR><CR>
au FileType elm nmap <buffer> <CR> :!make<CR>
au FileType python nmap <buffer> <CR> :!python3 %<CR>
au FileType haskell nmap <buffer> <CR> :!runghc %<CR>
au FileType tex nmap <buffer> <CR> :!pdflatex %<CR>

" gui options
if has("gui_running")
  se guioptions-=m
  se guioptions-=T
  se guioptions-=r
  se guioptions-=L
  se guifont=Monaco\ 9
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


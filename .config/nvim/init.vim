
call plug#begin('~/.local/share/nvim/plug')
Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'ycm-core/YouCompleteMe'
Plug 'sbdchd/neoformat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'ElmCast/elm-vim'
call plug#end()

autocmd BufWritePre * | silent Neoformat

let g:neoformat_enabled_markdown = []
let g:polyglot_disabled = ['elm']
let g:elm_setup_keybindings = 0
let g:ycm_semantic_triggers = {'elm' : ['.']}
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

set background=dark
colorscheme gruvbox

let g:netrw_banner=0
set number list
set hlsearch incsearch ignorecase smartcase
set splitbelow splitright
set colorcolumn=+1
set textwidth=80
set modeline
set mouse=a
set smartindent
set shortmess+=I

inoremap jk <Esc>
nnoremap w :w<CR>
nnoremap q :q<CR>
let mapleader = " "
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>H <C-w>H
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>L <C-w>L
nnoremap <Leader>\| <C-w>\|
nnoremap <Leader>= <C-w>=
nnoremap <Leader>_ <C-w>_
nmap <Leader>f <C-p>
nnoremap - :Explore<CR>
nnoremap <C-l> :noh<CR>
nnoremap gd :YcmCompleter GoTo<CR>


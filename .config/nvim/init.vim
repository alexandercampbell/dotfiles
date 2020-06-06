
call plug#begin('~/.local/share/nvim/plug')
Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'ycm-core/YouCompleteMe'
Plug 'sbdchd/neoformat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

let g:neoformat_enabled_markdown = []

set background=dark
colorscheme gruvbox

let g:netrw_banner=0
set number list
set hlsearch incsearch
set splitbelow splitright
set colorcolumn=+1
set textwidth=80
set modeline
set mouse=a

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
nnoremap <Leader>\| <C-w>\|
nnoremap <Leader>= <C-w>=
nnoremap <Leader>_ <C-w>_
nmap <Leader>f <C-p>
nnoremap - :Explore<CR>
nnoremap <C-l> :noh<CR>

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


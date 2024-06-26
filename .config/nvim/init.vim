call plug#begin('~/.local/share/nvim/plug')
" functionality
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'farmergreg/vim-lastplace'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'

" color themes
Plug 'haystackandroid/snow'
Plug 'gruvbox-community/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'
call plug#end()

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_match_current_file = 1
let g:ctrlp_switch_buffer = 0
let g:ctrlp_map = '<Leader>f'
let g:lightline = { 'colorscheme': 'PaperColor' }

let g:netrw_banner = 0
set number
set hlsearch incsearch ignorecase smartcase
set splitbelow splitright
set colorcolumn=+1
set textwidth=80
set modeline
set mouse=a
set smartindent
set shortmess+=Ic
set nobackup nowritebackup hidden cmdheight=1
set termguicolors
set formatoptions+=l " Prevent autowrapping while editing long lines.
set nojoinspaces     " I only use one space after punctuation marks.
set virtualedit=block

au FileType javascript setl ts=2 sw=2 et

inoremap jk <Esc>
nnoremap w :w<cr>
nnoremap q :q<cr>
let mapleader = " "
nnoremap <leader>g :Goyo<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>s :split<cr>
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l
nnoremap <leader>H <c-w>H
nnoremap <leader>J <c-w>J
nnoremap <leader>K <c-w>K
nnoremap <leader>L <c-w>L
nnoremap <leader>\| <c-w>\|
nnoremap <leader>= <c-w>=
nnoremap <leader>_ <c-w>_
nnoremap - :Explore<cr>
nnoremap <c-/> :noh<cr>

au FileType rust    nnoremap <cr> :!cargo run<cr>
au FileType lua     nnoremap <cr> :!love .<cr>
au FileType clojure nnoremap <cr> :!bb %<cr>

" Theme at the bottom of the file because some themes don't initialize properly
" otherwise.
if $DARK_MODE
	set background=dark
else
	set background=light
endif
colorscheme snow

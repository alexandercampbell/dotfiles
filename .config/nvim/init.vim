
call plug#begin('~/.local/share/nvim/plug')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'farmergreg/vim-lastplace'
call plug#end()

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-vimlsp', 'coc-prettier', 'coc-eslint']

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
set shortmess+=Ic
set nobackup nowritebackup hidden cmdheight=2

au FileType javascript setl ts=2 sw=2 et

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

" COC bindings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> K :call <SID>show_documentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')


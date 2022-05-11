call plug#begin('~/.local/share/nvim/plug')
" functionality
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'farmergreg/vim-lastplace'
Plug 'itchyny/lightline.vim'

" color themes
Plug 'haystackandroid/snow'
Plug 'gruvbox-community/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'arcticicestudio/nord-vim'
call plug#end()

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_match_current_file = 1
let g:ctrlp_switch_buffer = 0
let g:ctrlp_map = '<Leader>f'

let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-vimlsp', 'coc-prettier', 'coc-eslint']
let g:lightline = { 'colorscheme': 'PaperColor' }

if $DARK_MODE
	set background=dark
else
	set background=light
endif
colorscheme snow

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

au FileType javascript setl ts=2 sw=2 et

inoremap jk <Esc>
nnoremap w :w<cr>
nnoremap q :q<cr>
let mapleader = " "
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
nnoremap <c-l> :noh<cr>

au FileType rust nnoremap <cr> :!cargo run<cr>
au FileType lua  nnoremap <cr> :!love .<cr>

" COC bindings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
autocmd CursorHold * silent call CocActionAsync('highlight')

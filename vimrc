
" remove all autocommands to prevent them from being loaded twice
au!

" Options that can't be used without more configuration
execute pathogen#infect()
colo solarized
runtime! plugin/sensible.vim

filetype plugin on

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

se timeoutlen=50

set hlsearch

set splitbelow
set splitright

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

au FileType c map <F5> <C-C>:!clear && clang --analyze *.c<CR>
au FileType haskell map <F9> <C-C>:!clear && ghc % -o vimtestmain.out && ./vimtestmain.out && rm vimtestmain.out<CR>
au FileType yaml se ts=4 sw=4 et
au FileType javascript se ts=4 sw=4 et
au FileType python se ts=4 sw=4 et
au FileType lua map <F9> <C-c>:!clear && ~/apps/love .<CR>

au BufRead,BufNewFile *.md set ft=markdown tw=80
au BufRead,BufNewFile *.yaml se ft=yaml

" faster keybindings
nmap ` :E<CR>
nmap <Tab> <C-w>w
nmap <S-Tab> <C-w><S-w>
nmap q :q<CR>
nmap w :w<CR>

" enable mouse
se mouse=a

se shm=I

" jump to last edited position in file instead of always starting at the
" top line, leftmost column
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif

au FileType python map <F9> <C-C>:!clear && python %<CR>

se nu " Line numbering
se fo+=c
se fo-=t
se wm=0
se cc=+1 " colorcolumn
hi ColorColumn ctermbg=7 "non-pink colorcolumn

map <C-c> <Esc>
nmap <space> zz

" always be in directory of currently edited file
autocmd BufEnter * silent! lcd %:p:h

let g:solarized_contrast = "high"
se bg=light
syn on

" highlight searches with light blue instead of the default bright yellow
hi Search cterm=none ctermbg=lightblue

" hide autocompletion window on movement
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set wildmenu
set wildmode=list:longest

se t_Co=16


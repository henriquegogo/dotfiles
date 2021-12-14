" Made by @henriquegogo

set number
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set cursorline
set incsearch
set wildmenu
set mouse=a
set nobackup
set nofixeol
set noswapfile
set path=**

syntax enable
filetype plugin indent on

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
vnoremap <Leader>y "+y
nnoremap <Leader>yy "+yy
map <Leader>p "+p
map <Leader>P "+P

let g:netrw_banner=0
let g:netrw_winsize=-25

set background=dark
hi Normal     ctermfg=15  ctermbg=234
hi Visual                 ctermbg=236
hi CursorLine             ctermbg=236
hi LineNr     ctermfg=8   ctermbg=0
hi SignColumn             ctermbg=234
hi Pmenu      ctermfg=250 ctermbg=236
hi PmenuSel   ctermfg=15
hi Boolean    ctermfg=148
hi Comment    ctermfg=8
hi Constant   ctermfg=208
hi Function   ctermfg=229
hi Identifier ctermfg=103
hi Keyword    ctermfg=103
hi Number     ctermfg=208
hi PreProc    ctermfg=110
hi Type       ctermfg=110
hi Special    ctermfg=229
hi String     ctermfg=148
hi Statement  ctermfg=103
hi Structure  ctermfg=103

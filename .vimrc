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

let g:netrw_banner = 0
let g:netrw_winsize = -25

set background=dark
hi clear
hi Normal      ctermbg=233 ctermfg=253
hi Visual      ctermbg=238
hi CursorLine  ctermbg=237
hi LineNr      ctermbg=232 ctermfg=244
hi SignColumn  ctermbg=233
hi Pmenu       ctermbg=238 ctermfg=15 
hi Boolean     ctermfg=148
hi Comment     ctermfg=244
hi Function    ctermfg=229
hi Identifier  ctermfg=148
hi Number      ctermfg=208
hi Preproc     ctermfg=110
hi Type        ctermfg=103
hi Special     ctermfg=208
hi Statement   ctermfg=103
hi String      ctermfg=148

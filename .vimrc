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
hi clear
hi Normal      ctermbg=233 ctermfg=15
hi Visual      ctermbg=236
hi CursorLine  ctermbg=236
hi LineNr      ctermbg=0   ctermfg=8
hi SignColumn  ctermbg=233
hi Pmenu       ctermbg=236 ctermfg=15
hi Boolean     ctermfg=2
hi Comment     ctermfg=8
hi Constant    ctermfg=9
hi Function    ctermfg=11
hi Identifier  ctermfg=9
hi Keyword     ctermfg=6
hi Number      ctermfg=3
hi PreProc     ctermfg=13
hi Type        ctermfg=14
hi Special     ctermfg=3
hi Statement   ctermfg=6
hi String      ctermfg=10
hi Structure   ctermfg=13

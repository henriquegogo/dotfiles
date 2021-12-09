" Made by @henriquegogo

set number
set cursorline
set expandtab
set tabstop=2
set shiftwidth=2
set incsearch
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
hi CursorLine  ctermbg=237
hi MatchParen  ctermbg=242 ctermfg=255
hi Pmenu       ctermbg=238 ctermfg=15 
hi PmenuSel    ctermbg=107 ctermfg=0
hi Normal      ctermbg=233 ctermfg=253
hi LineNr      ctermbg=232 ctermfg=244
hi SignColumn  ctermbg=233
hi ColorColumn ctermbg=232
hi Visual      ctermbg=238
hi Comment     ctermfg=244
hi Boolean     ctermfg=148
hi String      ctermfg=148
hi Identifier  ctermfg=148
hi Function    ctermfg=229
hi Type        ctermfg=103
hi Statement   ctermfg=103
hi Keyword     ctermfg=208
hi Constant    ctermfg=208
hi Number      ctermfg=208
hi Special     ctermfg=208
hi Preproc     ctermfg=110
hi Folded      ctermfg=15 
hi Title       ctermfg=15  cterm=bold

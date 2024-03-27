" Settings
set autoindent
set breakindent
set cursorline
set expandtab
set hidden
set ignorecase
set incsearch
set linebreak
set mouse=a
set nofixeol
set nohlsearch
set noswapfile
set number
set path+=**
set shiftwidth=2
set signcolumn=yes
set smartcase
set splitbelow
set splitright
set tabstop=2
set timeoutlen=300
set updatetime=300

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = -25

filetype plugin indent on
syntax enable

" Colorscheme
set background=dark
hi Boolean      ctermfg=173              " Dark Yellow
hi ColorColumn              ctermbg=237  " Dark Gray
hi Comment      ctermfg=059              " Gray
hi Constant     ctermfg=075              " Light Blue
hi CursorColumn             ctermbg=237  " Dark Gray
hi CursorLine   cterm=NONE  ctermbg=236  " Darker Gray
hi CursorLineNr ctermfg=145 cterm=NONE   " Light Gray
hi DiffAdd      ctermfg=107 ctermbg=233  " Green | Black
hi DiffChange   ctermfg=179 ctermbg=233  " Yellow | Black
hi DiffDelete   ctermfg=167 ctermbg=233  " Red | Black
hi DiffText     ctermfg=179 ctermbg=233  " Yellow | Black
hi FoldColumn               ctermbg=233  " Black
hi Folded       ctermfg=145 ctermbg=237  " Light Gray | Dark Gray
hi Function     ctermfg=075              " Blue
hi Identifier   ctermfg=167 cterm=NONE   " Red
hi Keyword      ctermfg=134              " Purple
hi LineNr       ctermfg=238              " Gray
hi MatchParen               ctermbg=059  " Gray
hi Normal       ctermfg=145 ctermbg=233  " Light Gray | Black
hi Number       ctermfg=173              " Dark Yellow
hi Pmenu        ctermfg=145 ctermbg=237  " Light Gray | Dark Gray
hi PmenuSel     ctermfg=236 ctermbg=075  " Darker Gray | Purple
hi PreProc      ctermfg=179              " Yellow
hi Search       ctermfg=233 ctermbg=179  " Black | Yellow
hi SignColumn               ctermbg=233  " Light Gray
hi Special      ctermfg=075              " Blue
hi Statement    ctermfg=134              " Purple
hi String       ctermfg=107              " Green
hi Structure    ctermfg=179              " Yellow
hi TabLine      cterm=NONE               " Remove underline
hi Type         ctermfg=179              " Yellow
hi Visual                   ctermbg=237  " Dark Gray

" Statusline
hi StatusA      ctermfg=251 ctermbg=060
hi StatusB      ctermfg=247 ctermbg=232
hi StatusC      ctermfg=060 ctermbg=232
set laststatus=2
set statusline=%#StatusA#\ %{fnamemodify(getcwd(),':t')}\ 
set statusline+=%#StatusC#┃%#StatusB#\ %f\ %M\ %R\ %=
set statusline+=%{expand(&filetype)}\ │\ %l:%c\ │\ %p%%\ 
set statusline+=%#StatusC#┃%#StatusA#\ %{toupper(mode())}\ 

" Autocompletion
set completeopt=menu,noinsert,noselect
set omnifunc=syntaxcomplete#Complete
imap <C-Space> <C-x><C-o>
imap <C-@> <C-x><C-o>

" Popup menu
imap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
imap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Buffers and tabs navigation
nnoremap <Leader>q :q<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>l :tabnext<CR>
nnoremap <Leader>h :tabprevious<CR>
nnoremap <Leader>j :bnext<CR>
nnoremap <Leader>k :bprevious<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>

" Add / Remove words and comments in front of line
nnoremap <Space>0 0i
vnoremap <Space>0 0<C-q>I
nnoremap <Space>00 0de
vnoremap <Space>00 :norm 0de<CR>

" Surround blocks and quotes
nnoremap <Space>' bvec''<Esc>P
nnoremap <Space>" bvec""<Esc>P
nnoremap <Space>( bvec()<Esc>P
nnoremap <Space>{ bvec{}<Esc>P
nnoremap <Space>[ bvec[]<Esc>P
vnoremap <Space>' c''<Esc>P
vnoremap <Space>" c""<Esc>P
vnoremap <Space>( c()<Esc>P
vnoremap <Space>{ c{}<Esc>P
vnoremap <Space>[ c[]<Esc>P
nnoremap <Space>'' va'<Esc>x`<x
nnoremap <Space>"" va"<Esc>x`<x
nnoremap <Space>(( va()<Esc>x`<x
nnoremap <Space>{{ va{<Esc>x`<x
nnoremap <Space>[[ va[<Esc>x`<x
vnoremap <Space>'' <Esc>`>x`<x
vnoremap <Space>"" <Esc>`>x`<x
vnoremap <Space>(( <Esc>`>x`<x
vnoremap <Space>{{ <Esc>`>x`<x
vnoremap <Space>[[ <Esc>`>x`<x

" Find files by name
if executable('find') == 1
  command! -nargs=1 Find cgetexpr system('find . -type f '
        \. '! -path "*/.*" ! -path "**/node_modules/*" ! -path "**/venv/*" ! -path "**/vendor/*" '
        \. '! -path "**/build/*" ! -path "**/dist/*" ! -path "**/tmp/*" ! -path "**/out/*" ! -path "**/bin/*" '
        \. '-name "*' . <q-args> . '*" -printf "%p:0:0:%CF %Cr \\n"') | copen | setlocal modifiable | sort | setlocal nomodifiable
  nnoremap <Leader>e :Find<Space>
endif

" Search files containing text
if executable('rg') == 1
  command! -nargs=1 Search cgetexpr system('rg --vimgrep --no-heading --smart-case '
        \. '-g "!{**/node_modules/*,**/venv/*,**/vendor/*,**/build/*,**/dist/*,**/tmp/*,**/out/*,**/bin/*}" '
        \. '"' . <q-args> . '"') | copen | setlocal modifiable | sort | setlocal nomodifiable
  nnoremap <Leader>/ :Search<Space>
endif

" Git blame / diff
if executable('git') == 1
  nnoremap <Leader>g :echo system('git -C ' . expand("%:p:h") . ' blame ' . expand("%:p") . ' -L' . line(".") . ',' . line("."))<CR>
  vnoremap <Leader>g :<C-u>echo system('git -C ' . expand("%:p:h") . ' blame ' . expand("%:p") . ' -L' . getpos("'<")[1] . ',' . getpos("'>")[1])<CR>

  function! Diff()
    call sign_define('DiffSign', {'text': '~', 'texthl': 'DiffChange'})
    if &buftype == '' && system("git -C " . expand("%:p:h") . " rev-parse --is-inside-work-tree") == "true\n"
      let bufnr = bufnr('%')
      let lines = systemlist('git -C ' . expand('%:p:h') . ' blame -sf --abbrev=1 ' . expand("%:p")
            \. ' | grep -n "^00000 "')
      call sign_unplace('DiffSign', {'buffer': bufnr})
      for item in lines
        let lnum = split(item, ':')[0]
        call sign_place(lnum, 'DiffSign', 'DiffSign', bufnr, {'lnum': lnum})
      endfor
    endif
  endfunction
  autocmd BufReadPost,BufWritePost * call Diff()
endif


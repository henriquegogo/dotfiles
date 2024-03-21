set number
set mouse=a
set clipboard=unnamedplus
set breakindent
set ignorecase
set smartcase
set signcolumn=yes
set updatetime=250
set timeoutlen=300
set splitright
set splitbelow
set cursorline
set hlsearch
set nohlsearch
set expandtab
set tabstop=2
set shiftwidth=2
set path+=**
let g:netrw_banner = 0
let g:netrw_winsize = -25
let g:netrw_liststyle = 3
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
hi DiffAdd      ctermfg=107 ctermbg=235  " Green | Black
hi DiffChange   ctermfg=179 ctermbg=235  " Yellow | Black
hi DiffDelete   ctermfg=167 ctermbg=235  " Red | Black
hi DiffText     ctermfg=179 ctermbg=235  " Yellow | Black
hi Folded       ctermfg=145 ctermbg=237  " Light Gray | Dark Gray
hi FoldColumn               ctermbg=235  " Black
hi Function     ctermfg=075              " Blue
hi Identifier   ctermfg=167 cterm=NONE   " Red
hi Keyword      ctermfg=134              " Purple
hi LineNr       ctermfg=238              " Gray
hi MatchParen               ctermbg=059  " Gray
hi Normal       ctermfg=145 ctermbg=235  " Light Gray | Black
hi Number       ctermfg=173              " Dark Yellow
hi Pmenu        ctermfg=145 ctermbg=237  " Light Gray | Dark Gray
hi PmenuSel     ctermfg=236 ctermbg=075  " Darker Gray | Purple
hi PreProc      ctermfg=179              " Yellow
hi Search       ctermfg=235 ctermbg=179  " Black | Yellow
hi SignColumn               ctermbg=235  " Light Gray
hi Special      ctermfg=075              " Blue
hi Statement    ctermfg=134              " Purple
hi String       ctermfg=107              " Green
hi Structure    ctermfg=179              " Yellow
hi TabLine      cterm=NONE               " Remove underline
hi Type         ctermfg=179              " Yellow
hi Visual                   ctermbg=237  " Dark Gray

" Statusline
hi StatusBlue   ctermfg=251 ctermbg=025 cterm=bold
hi StatusBlack  ctermfg=145 ctermbg=237
hi StatusGray   ctermfg=145 ctermbg=239
set laststatus=2                                 " Always show statusbar
set statusline=%#StatusBlue#\ %Y\ 	             " Filetype
set statusline+=%#StatusGray#\ %{fnamemodify(getcwd(),':t')}\  " Current folder
set statusline+=%#StatusBlack#\ %f\ %M\ %R\ %=\  " Filename / Modified / Readonly / Right Aligned
set statusline+=%#StatusGray#\ %p%%\             " Percentage
set statusline+=%#StatusBlue#\ %l:%c\            " Line: Column

" Buffers and tabs navigation
nnoremap <leader>q :q<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>l :tabnext<CR>
nnoremap <leader>h :tabprevious<CR>
nnoremap <leader>j :bnext<CR>
nnoremap <leader>k :bprevious<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>

" Add / Remove words and comments in front of line
nnoremap <space>0 0i
vnoremap <space>0 0<C-Q>I
nnoremap <space>00 0de
vnoremap <space>00 :norm 0de<CR>

" Surround blocks and quotes
nnoremap <space>' bvec''<ESC>P
nnoremap <space>" bvec""<ESC>P
nnoremap <space>( bvec()<ESC>P
nnoremap <space>{ bvec{}<ESC>P
nnoremap <space>[ bvec[]<ESC>P
vnoremap <space>' c''<ESC>P
vnoremap <space>" c""<ESC>P
vnoremap <space>( c()<ESC>P
vnoremap <space>{ c{}<ESC>P
vnoremap <space>[ c[]<ESC>P
nnoremap <space>'' va'<ESC>x`<x
nnoremap <space>"" va"<ESC>x`<x
nnoremap <space>(( va()<ESC>x`<x
nnoremap <space>{{ va{<ESC>x`<x
nnoremap <space>[[ va[<ESC>x`<x
vnoremap <space>'' <ESC>`>x`<x
vnoremap <space>"" <ESC>`>x`<x
vnoremap <space>(( <ESC>`>x`<x
vnoremap <space>{{ <ESC>`>x`<x
vnoremap <space>[[ <ESC>`>x`<x

" Find files by name
if executable('find') == 1
  command! -nargs=1 Find cgetexpr system('find . -type f '
        \. '! -path "*/.*" ! -path "**/node_modules/*" ! -path "**/venv/*" ! -path "**/vendor/*" '
        \. '! -path "**/build/*" ! -path "**/dist/*" ! -path "**/tmp/*" ! -path "**/out/*" ! -path "**/bin/*" '
        \. '-name "*' . <q-args> . '*" -printf "%p:0:0:%CF %Cr \\n"') | copen | set modifiable | sort | set nomodifiable
  nnoremap <leader>e :Find<space>
endif

" Search files containing text
if executable('rg') == 1
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\
        \ -g\ '!{**/node_modules/*,**/venv/*,**/vendor/*,**/build/*,**/dist/*,**/tmp/*,**/out/*,**/bin/*}'
  command! -nargs=1 Search silent grep! <args> | cw | setlocal modifiable | sort
  nnoremap <leader>/ :Search<space>
endif

" Git blame / diff
if executable('git') == 1
  nnoremap <leader>g :echo system('git -C ' . expand("%:p:h") . ' blame ' . expand("%:p") . ' -L' . line(".") . ',' . line("."))<CR>
  vnoremap <leader>g :<C-U>echo system('git -C ' . expand("%:p:h") . ' blame ' . expand("%:p") . ' -L' . getpos("'<")[1] . ',' . getpos("'>")[1])<CR>

  sign define DiffSign text=~ texthl=DiffChange
  function! DiffShow()
    if &buftype == '' && system("git -C " . expand("%:p:h") . " rev-parse --is-inside-work-tree") == "true\n"
      let bufnr = bufnr('%')
      let lines = systemlist('git -C ' . expand('%:p:h') . ' blame -sf --abbrev=1 ' . expand("%:p")
            \. ' | grep ^00000 | sed "s/^00000 //; s/  */:/; s/)/:/"')
      call sign_unplace('*', {'buffer': bufnr})
      for item in lines
        let lnum = split(item, ':')[1]
        execute 'sign place ' . lnum . ' line=' . lnum . ' name=DiffSign buffer=' . bufnr
      endfor
    endif
  endfunction
  autocmd BufReadPost,BufWritePost * call DiffShow()
endif

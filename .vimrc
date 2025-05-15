" Settings
set autoindent
set breakindent
set cursorline
set expandtab
set fillchars+=vert:\ 
set foldmethod=indent
set hidden
set ignorecase
set incsearch
set linebreak
set mouse=a
set nofixeol
set nofoldenable
set nohlsearch
set noswapfile
set notermguicolors
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
set wildcharm=<C-z>
set wildmenu

filetype plugin indent on
syntax enable
let mapleader = ' '

" Colorscheme
set background=dark
hi Boolean      ctermfg=173              " Dark Yellow
hi ColorColumn  cterm=NONE  ctermbg=232  " Dark Black
hi Comment      ctermfg=059              " Gray
hi Constant     ctermfg=075              " Blue
hi CursorColumn             ctermbg=237  " Dark Gray
hi CursorLine   cterm=NONE  ctermbg=236  " Darker Gray
hi CursorLineNr ctermfg=145 cterm=NONE   " Light Gray
hi DiffAdd      ctermfg=107 ctermbg=233  " Green - Black
hi DiffChange   ctermfg=179 ctermbg=233  " Yellow - Black
hi DiffDelete   ctermfg=167 ctermbg=233  " Red - Black
hi DiffText     ctermfg=179 ctermbg=233  " Yellow - Black
hi EndOfBuffer  ctermfg=233              " Black
hi ErrorMsg     ctermfg=167 ctermbg=233  " Red - Black
hi FoldColumn               ctermbg=233  " Black
hi Folded       ctermfg=145 ctermbg=237  " Light Gray - Dark Gray
hi Function     ctermfg=075              " Blue
hi Identifier   ctermfg=167 cterm=NONE   " Red
hi Keyword      ctermfg=134              " Purple
hi LineNr       ctermfg=238              " Gray
hi MatchParen               ctermbg=059  " Gray
hi Normal       ctermfg=145 ctermbg=233  " Light Gray - Black
hi Number       ctermfg=173              " Dark Yellow
hi Pmenu        ctermfg=145 ctermbg=236 cterm=NONE  " Light Gray - Dark Gray
hi PmenuSel     ctermfg=236 ctermbg=075 cterm=NONE  " Darker Gray - Purple
hi PreProc      ctermfg=179              " Yellow
hi Search       ctermfg=233 ctermbg=179  " Black - Yellow
hi SignColumn               ctermbg=233  " Light Gray
hi Special      ctermfg=075              " Blue
hi Statement    ctermfg=134              " Purple
hi StatusLine   cterm=NONE  ctermbg=232  " Dark Black
hi String       ctermfg=107              " Green
hi Structure    ctermfg=179              " Yellow
hi TabLine      ctermfg=145 ctermbg=232 cterm=NONE  " Light Gray - Dark Black 
hi TabLineFill  ctermfg=232              " Dark Black
hi TabLineSel   ctermfg=232 ctermbg=145  " Dark Black -  Light Gray
hi Type         ctermfg=179              " Yellow
hi VertSplit    cterm=NONE  ctermbg=232  " Dark Black
hi Visual       ctermfg=145 ctermbg=237  " Light Gray - Dark Gray
hi WildMenu     ctermfg=236 ctermbg=075  " Black - Blue
hi WinSeparator cterm=NONE  ctermbg=232  " Dark Black

" Statusline
hi StatusA      ctermfg=248 ctermbg=235
hi StatusB      ctermfg=248 ctermbg=232
hi StatusC      ctermfg=239 ctermbg=232
if $USER == 'root'
  hi StatusA      ctermfg=254 ctermbg=167
endif
set laststatus=2
set statusline=%#StatusA#\ %{fnamemodify(getcwd(),':t')}\ 
set statusline+=%#StatusC#\ %n\ %#StatusB#%f\ %#StatusC#%M\ %R\ %=
set statusline+=%#StatusC#\ %{&filetype}\ 
set statusline+=%#StatusB#\ %l:%c\ %#StatusC#\|%#StatusB#\ %p%%\ 
let g:statusline = &statusline

" File explorer
hi netrwTreeBar ctermfg=233
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = -25
nnoremap <Leader><CR> <Cmd>Lexplore<CR>
autocmd FileType netrw setlocal statusline=%#StatusB# 
      \ | nmap <buffer> . gncd:cd .<CR>

" Quickfix list
autocmd FileType qf setlocal nonumber
      \ | setlocal statusline=%#StatusB#\ %=%l/%L\ 
      \ | nnoremap <buffer> <CR> <CR>:cclose<CR>

" Autocompletion
set completeopt=menu,noinsert,noselect
set omnifunc=syntaxcomplete#Complete
imap <C-Space> <C-x><C-o>
imap <C-@> <C-x><C-o>

" Popup menu
imap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
imap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Esc alternative
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" Clipboard register
noremap <Leader><Leader> "+

" Buffers navigation
nnoremap <Leader>% <Cmd>vsplit<CR>
nnoremap <Leader>" <Cmd>split<CR>
nnoremap <Leader>b :buffer <C-z>
nnoremap <Leader><Tab> <Cmd>bnext<CR>
nnoremap <Leader><S-Tab> <Cmd>bprevious<CR>
for i in range(1, 9)
  execute 'nnoremap <Leader>' . i . ' :buffer ' . i . '<CR>'
endfor

" Find files by name
command! -nargs=1 -complete=file Find cgetexpr system('find . -type f '
      \. '! -path "*/.*" ! -path "**/node_modules/*" ! -path "**/venv/*" ! -path "**/vendor/*" '
      \. '! -path "**/build/*" ! -path "**/dist/*" ! -path "**/tmp/*" ! -path "**/out/*" ! -path "**/bin/*" '
      \. '-path "*' . <q-args> . '*" -exec stat -c "%n:0:0: " {} \; | sort') | copen
nnoremap <Leader>. :Find<Space>

" Search files containing text
if executable('rg')
  command! -nargs=1 -complete=tag Search cgetexpr system('rg --vimgrep --no-heading --smart-case '
        \. '-g "!{**/node_modules/*,**/venv/*,**/vendor/*,**/build/*,**/dist/*,**/tmp/*,**/out/*,**/bin/*}" '
        \. '"' . <q-args> . '" | sort') | copen
else
  command! -nargs=1 Search silent execute 'grep! -R -i '
        \. '--exclude-dir={node_modules,venv,vendor,build,dist,tmp,out,bin,".?*"} '
        \. '"' . <q-args> . '" . | sort' | copen | redraw!
endif
nnoremap <Leader>/ :Search<Space>

" Git blame / diff / branch
if executable('git')
  nnoremap <Leader>g :echo system('git -C ' . expand("%:p:h") . ' blame ' . expand("%:p") . ' -L' . line(".") . ',' . line("."))<CR>
  vnoremap <Leader>g :<C-u>echo system('git -C ' . expand("%:p:h") . ' blame ' . expand("%:p") . ' -L' . getpos("'<")[1] . ',' . getpos("'>")[1])<CR>

  function! Diff()
    if system('git rev-parse --is-inside-work-tree') == "true\n"
      let &statusline = g:statusline . '%#StatusA# ' . trim(system('git branch --show-current 2>/dev/null')) . ' '
    else
      let &statusline = g:statusline
    endif
    call sign_define('DiffSign', {'text': '~', 'texthl': 'DiffChange'})
    if &buftype == ''
          \&& system('git -C ' . expand("%:p:h") . ' rev-parse --is-inside-work-tree') == "true\n"
          \&& strlen(system('git -C ' . expand("%:p:h") . ' ls-files -- ' . expand("%:p")))
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
  autocmd BufReadPost,BufWritePost,BufEnter,DirChanged * if &filetype != '' | call Diff() | endif
endif

" Ctags
if executable('ctags')
  command! Ctags silent! execute '!nohup ctags --tag-relative=yes -R -f /tmp/tags-' 
        \. fnamemodify(getcwd(), ':t') . ' ' . getcwd() . ' >/dev/null 2>&1 &' | redraw!
  command! CtagsDelete silent! execute '!rm /tmp/tags-' . fnamemodify(getcwd(), ':t') | redraw!
  let &tags = '/tmp/tags-' . fnamemodify(getcwd(), ':t')
  autocmd BufWritePost * if filereadable('/tmp/tags-' 
        \. fnamemodify(getcwd(), ':t')) && getcwd() !=# '/' && getcwd() !=# expand('$HOME') | execute 'Ctags' | endif
endif

" Plugins manager
if exists('*stdpath')
  let g:pluginspath = stdpath('data') . '/site/pack/plugins/start/'
else
  let g:pluginspath = split(&runtimepath, ',')[0] . '/pack/plugins/start/'
endif

function! PluginInstall(repo)
  let l:pluginfolder = split(split(a:repo, ' ')[0], '/')[-1]
  if !isdirectory(g:pluginspath)
    call mkdir(g:pluginspath, 'p')
  endif
  if !isdirectory(g:pluginspath . l:pluginfolder) && executable('git')
    echo 'Installing ' . l:pluginfolder . '... '
    echo system('git clone --depth=1 https://github.com/'. a:repo . ' ' . g:pluginspath . l:pluginfolder)
  endif
endfunction

function! s:PluginRemove(plugin)
  let l:pluginfolder = split(split(a:plugin, ' ')[0], '/')[-1]
  if isdirectory(g:pluginspath . l:pluginfolder)
    echo 'Removing ' . l:pluginfolder . '... '
    echo system('rm -rf ' . g:pluginspath . l:pluginfolder)
  endif
endfunction

function! s:PluginUpdate()
  if isdirectory(g:pluginspath) && executable('git')
    echo 'Updating...'
    echo system('for repo in ' . g:pluginspath . '*; do echo "$repo... "; git -C $repo pull; done')
  endif
endfunction

function! s:PluginList(A, L, P)
  if isdirectory(g:pluginspath)
    return system('ls ' . g:pluginspath)
  endif
endfunction

command! -nargs=1 PluginInstall call PluginInstall(<q-args>)
command! -nargs=1 -complete=custom,s:PluginList PluginRemove call s:PluginRemove(<q-args>)
command! -nargs=0 PluginUpdate call s:PluginUpdate()
command! -nargs=0 PluginList echo s:PluginList(0, 0, 0)

" Plugins configuration
" call PluginInstall('sheerun/vim-polyglot')

" call PluginInstall('neoclide/coc.nvim --branch release')
if isdirectory(g:pluginspath . 'coc.nvim')
  execute 'source ' . g:pluginspath . 'coc.nvim/doc/coc-example-config.vim'
  let &statusline = g:statusline
  let g:coc_disable_startup_warning = 1
  hi CocFloating  ctermfg=145 ctermbg=236  " Light Gray - Dark Gray
  hi CocMenuSel   ctermfg=236 ctermbg=075  cterm=NONE  " Darker Gray - Purple
endif

" call PluginInstall('Exafunction/codeium.vim')
if isdirectory(g:pluginspath . 'codeium.vim') && isdirectory(g:pluginspath . 'coc.nvim')
  let g:codeium_disable_bindings = 1
  imap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : codeium#Accept()
  imap <M-k> <Cmd>call codeium#CycleCompletions(-1)<CR>
  imap <M-j> <Cmd>call codeium#CycleCompletions(1)<CR>
  imap <expr> <M-h> codeium#Clear()
  imap <expr> <M-l> codeium#Accept()
endif

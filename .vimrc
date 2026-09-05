" Settings
set autoindent
set breakindent
set cursorline
set expandtab
set fillchars+=vert:\ 
set foldlevel=9999
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
set wildoptions=pum
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
hi DiffAdd      ctermfg=7   ctermbg=22   " White - Green
hi DiffChange   cterm=NONE  ctermbg=236  " Darker Gray
hi DiffDelete   ctermfg=52  ctermbg=52   " Red - Red
hi DiffText     ctermfg=7   ctermbg=236 cterm=underline  " White - Darker Gray
hi diffAdded    ctermfg=10  ctermbg=NONE " Green
hi diffRemoved  ctermfg=9   ctermbg=NONE " Red
hi EndOfBuffer  ctermfg=233              " Black
hi ErrorMsg     ctermfg=167 ctermbg=233  " Red - Black
hi FoldColumn               ctermbg=233  " Black
hi Folded       ctermfg=145 ctermbg=237  " Light Gray - Dark Gray
hi Function     ctermfg=075              " Blue
hi Identifier   ctermfg=167 cterm=NONE   " Red
hi Keyword      ctermfg=134              " Purple
hi LineNr       ctermfg=238              " Gray
hi MatchParen               ctermbg=059  " Gray
hi Normal       ctermfg=145 ctermbg=234  " Light Gray - Light Black
hi Number       ctermfg=173              " Dark Yellow
hi Pmenu        ctermfg=145 ctermbg=236 cterm=NONE  " Light Gray - Dark Gray
hi PmenuSel     ctermfg=236 ctermbg=075 cterm=NONE  " Darker Gray - Purple
hi PreProc      ctermfg=179              " Yellow
hi Search       ctermfg=233 ctermbg=179  " Black - Yellow
hi SignColumn               ctermbg=233  " Light Gray
hi Special      ctermfg=075              " Blue
hi Statement    ctermfg=134              " Purple
hi StatusLine   cterm=NONE  ctermbg=232  " Dark Black
hi StatusLineNC cterm=NONE  ctermbg=232  " Dark Black
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

" Markdown
hi htmlH1           ctermfg=63  ctermbg=NONE cterm=bold
hi htmlH2           ctermfg=185 ctermbg=NONE cterm=bold
hi htmlH3           ctermfg=128 ctermbg=NONE cterm=bold
hi htmlH4           ctermfg=119 ctermbg=NONE cterm=bold
hi htmlH5           ctermfg=244 ctermbg=NONE cterm=bold
hi htmlH6           ctermfg=241 ctermbg=NONE cterm=bold
hi mkdHeading       ctermfg=234 ctermbg=NONE
hi mkdCodeDelimiter ctermfg=238
hi mkdCodeStart     ctermfg=238
hi mkdCodeEnd       ctermfg=238
hi mkdBold          ctermfg=234
hi htmlItalic       ctermfg=15  ctermbg=234  cterm=NONE
hi mkdItalic        ctermfg=234 ctermbg=NONE
hi htmlBoldItalic   ctermfg=15  ctermbg=NONE cterm=bold
hi mkdBoldItalic    ctermfg=234
hi mkdLink          ctermfg=4   cterm=underline
hi mkdDelimiter     ctermfg=238
hi link markdownH1Delimiter         mkdHeading 
hi link markdownH2Delimiter         mkdHeading 
hi link markdownH3Delimiter         mkdHeading 
hi link markdownH4Delimiter         mkdHeading 
hi link markdownH5Delimiter         mkdHeading 
hi link markdownH6Delimiter         mkdHeading 
hi link markdownBoldDelimiter       mkdBold 
hi link markdownItalicDelimiter     mkdItalic 
hi link markdownBoldItalicDelimiter mkdBoldItalic 
hi link markdownLinkText            mkdLink 
hi link markdownLinkTextDelimiter   mkdDelimiter 
hi link markdownCodeDelimiter       mkdCodeDelimiter 
if has('nvim')
  autocmd FileType markdown lua vim.treesitter.stop()
endif
autocmd FileType markdown setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^#\\+\\s'?'>1':'='

" Statusline
hi StatusA      ctermfg=248 ctermbg=235
hi StatusB      ctermfg=248 ctermbg=232
hi StatusC      ctermfg=239 ctermbg=232
if $USER == 'root'
  hi StatusA      ctermfg=254 ctermbg=167
endif
function! ScrollIndicator()
  let index = float2nr((line('.') - 1) * 10 / line('$'))
  return repeat('#', index).'#'.repeat('-', 10 - index - 1)
endfunction
set laststatus=2
set statusline=%#StatusA#\ %{fnamemodify(getcwd(),':t')}\ 
set statusline+=%#StatusC#\ %n\ %#StatusB#%f\ %#StatusC#%M\ %R\ %=
set statusline+=%{&filetype}\ %#StatusB#\ %l:%c\ %#StatusC#\ %{ScrollIndicator()}\ \ 
let g:statusline = &statusline

" File explorer
hi netrwTreeBar ctermfg=233
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = -25
nnoremap <Leader><CR> <Cmd>Lexplore<CR>
autocmd FileType netrw nmap <buffer> <2-LeftMouse> <CR>
autocmd FileType netrw setlocal statusline=%#StatusB# 
      \ | nmap <buffer> . gncd:cd .<CR>

" Quickfix list
autocmd FileType qf setlocal nonumber
      \ | setlocal statusline=%#StatusB#\ %=%l/%L\ 
      \ | nnoremap <buffer> <CR> <CR>:cclose<CR> :lclose<CR>

" Terminal
if exists('*termopen')
  autocmd BufEnter,WinEnter term://* startinsert
  autocmd TermOpen * setlocal nonumber | startinsert
endif

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

" Suppress default behavior
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

" Clipboard register
noremap <Leader> "+

" Buffers navigation
nnoremap <Leader>q <Cmd>execute confirm('Quit?', "&Yes\n&No") == 1 ? 'cq' : ''<CR>
nnoremap <Leader>b :buffer <C-z><S-Tab>
nnoremap <Leader><Tab> <Cmd>bnext<CR>
nnoremap <Leader><S-Tab> <Cmd>bprevious<CR>
nnoremap <Leader>gf :edit <cfile><CR>

" Find files by name
command! -nargs=1 -complete=file Find cgetexpr system('find . -type f '
      \. '! -path "*/.*" ! -path "**/node_modules/*" ! -path "**/venv/*" ! -path "**/vendor/*" '
      \. '! -path "**/build/*" ! -path "**/dist/*" ! -path "**/tmp/*" ! -path "**/out/*" ! -path "**/bin/*" '
      \. '-path "*'.<q-args>.'*" -exec stat -c "%n:0:0: " {} \; | sort') | copen
nnoremap <Leader>. :Find<Space>

" Search / Replace text
if executable('rg')
  command! -nargs=1 -complete=tag Search cgetexpr system('rg --vimgrep --no-heading --smart-case '
        \. '-g "!{**/node_modules/*,**/venv/*,**/vendor/*,**/build/*,**/dist/*,**/tmp/*,**/out/*,**/bin/*}" '
        \. '"'.<q-args>.'" | sort') | copen
else
  command! -nargs=1 Search silent execute 'grep! -R -i '
        \. '--exclude-dir={node_modules,venv,vendor,build,dist,tmp,out,bin,".?*"} '
        \. '"'.<q-args>.'" . | sort' | copen | redraw!
endif
command! -nargs=+ Replace execute 'Search '.split(<q-args>)[0] | cclose
      \| execute 'cfdo %s/\V\C'.split(<q-args>)[0].'/'.split(<q-args>)[1].'/gc'
nnoremap <Leader>/ :Search<Space>
nnoremap <Leader>F :Search<Space>
nnoremap <Leader>h :%s/<C-R><C-W>//gc<Left><Left><Left>
nnoremap <Leader>H :Replace <C-R><C-W><Space>

" Git blame / diff / branch
if executable('git')
  vnoremap <Leader>gb :<C-u>execute '!git -C '.expand("%:p:h").' blame '.expand("%:p").' -L'.getpos("'<")[1].','.getpos("'>")[1]<CR>
  nnoremap <Leader>gb :execute '!git -C '.expand("%:p:h").' blame '.expand("%:p").' -L'.line(".").','.line(".")<CR>
  vnoremap <Leader>gd :<C-u>execute '!git diff -U999999 % \| grep -v "^+" \| tail -n +5 \| sed -n '.getpos("'<")[1].','.getpos("'>")[1].'p'<CR>
  if executable('tmux') | nnoremap <Leader>gd :!tmux neww "git difftool %"<CR> | endif

  function! Diff()
    if system('git rev-parse --is-inside-work-tree') == "true\n"
      let &statusline = g:statusline.'%#StatusA# '.trim(system('git branch --show-current 2>/dev/null')).' '
    else
      let &statusline = g:statusline
    endif
    call sign_define('DiffSign', {'text': '~'})
    if &buftype == ''
          \&& system('git -C '.expand("%:p:h").' rev-parse --is-inside-work-tree') == "true\n"
          \&& strlen(system('git -C '.expand("%:p:h").' ls-files -- '.expand("%:p")))
      let bufnr = bufnr('%')
      let lines = systemlist('git -C '.expand('%:p:h').' blame -sf --abbrev=1 '.expand("%:p")
            \. ' | grep -n "^00000 "')
      call sign_unplace('DiffSign', {'buffer': bufnr})
      let loclist = []
      for item in lines
        let lnum = split(item, ':')[0]
        let text = join(split(item, ') ')[1:], ') ')
        call sign_place(lnum, 'DiffSign', 'DiffSign', bufnr, {'lnum': lnum})
        call add(loclist, {'bufnr': bufnr, 'lnum': lnum, 'col': 1, 'text': text})
      endfor
      call setloclist(0, [], 'r', {'title': 'Diff', 'items': loclist})
    endif
  endfunction
  autocmd BufReadPost,BufWritePost,BufWinEnter,DirChanged * if &filetype != '' | call Diff() | endif
endif

" Ctags
if executable('ctags')
  let s:tagfilename = '/tmp/tags-'.fnamemodify(getcwd(), ':h:t').'-'.fnamemodify(getcwd(), ':t')
  command! CtagsCreate silent! execute '!nohup ctags --tag-relative=yes -R -f ' 
        \. shellescape(s:tagfilename).' '.shellescape(getcwd()).' >/dev/null 2>&1 &' | redraw!
  command! CtagsDelete silent! execute '!rm '.shellescape(s:tagfilename) | redraw!
  let &tags = s:tagfilename
  autocmd BufWritePost * if filereadable(s:tagfilename) && getcwd() !=# expand('$HOME') | execute 'CtagsCreate' | endif
  nnoremap <Leader>t :tjump *<C-z><S-Tab>
endif

" Plugins manager
if exists('*stdpath')
  let g:pluginspath = stdpath('data').'/site/pack/plugins/start/'
else
  let g:pluginspath = split(&runtimepath, ',')[0].'/pack/plugins/start/'
endif

function! PluginInstall(repo)
  let l:pluginfolder = split(split(a:repo, ' ')[0], '/')[-1]
  if !isdirectory(g:pluginspath)
    call mkdir(g:pluginspath, 'p')
  endif
  if !isdirectory(g:pluginspath.l:pluginfolder) && executable('git')
    echo 'Installing '.l:pluginfolder.'... '
    echo system('git clone --depth=1 https://github.com/'.a:repo.' '.g:pluginspath.l:pluginfolder)
  endif
endfunction

function! s:PluginRemove(plugin)
  let l:pluginfolder = split(split(a:plugin, ' ')[0], '/')[-1]
  if isdirectory(g:pluginspath.l:pluginfolder)
    echo 'Removing '.l:pluginfolder.'... '
    echo system('rm -rf '.g:pluginspath.l:pluginfolder)
  endif
endfunction

function! s:PluginUpdate()
  if isdirectory(g:pluginspath) && executable('git')
    echo 'Updating...'
    echo system('for repo in '.g:pluginspath.'*; do echo "$repo... "; git -C $repo pull; done')
  endif
endfunction

function! s:PluginList(A, L, P)
  if isdirectory(g:pluginspath)
    return system('ls '.g:pluginspath)
  endif
endfunction

command! -nargs=1 PluginInstall call PluginInstall(<q-args>)
command! -nargs=1 -complete=custom,s:PluginList PluginRemove call s:PluginRemove(<q-args>)
command! -nargs=0 PluginUpdate call s:PluginUpdate()
command! -nargs=0 PluginList echo s:PluginList(0, 0, 0)

" LSP
if has('nvim-0.8')
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact lua if vim.fn.executable('typescript-language-server') == 1 then vim.lsp.start({ name = 'tsserver', cmd = { 'typescript-language-server', '--stdio' } }) end
  autocmd FileType c,cpp,objc,objcpp lua if vim.fn.executable('clangd') == 1 then vim.lsp.start({ name = 'clangd', cmd = { 'clangd' } }) end
  autocmd FileType go,gomod lua if vim.fn.executable('gopls') == 1 then vim.lsp.start({ name = 'gopls', cmd = { 'gopls' } }) end
  autocmd FileType python lua if vim.fn.executable('pyright-langserver') == 1 then vim.lsp.start({ name = 'pyright', cmd = { 'pyright-langserver', '--stdio' } }) end
  autocmd FileType ruby lua if vim.fn.executable('solargraph') == 1 then vim.lsp.start({ name = 'solargraph', cmd = { 'solargraph', 'stdio' } }) end
  autocmd FileType sh,bash,zsh lua if vim.fn.executable('bash-language-server') == 1 then vim.lsp.start({ name = 'bashls', cmd = { 'bash-language-server', 'start' } }) end
  autocmd FileType html lua if vim.fn.executable('vscode-html-language-server') == 1 then vim.lsp.start({ name = 'html', cmd = { 'vscode-html-language-server', '--stdio' } }) end
  autocmd FileType css,scss,less lua if vim.fn.executable('vscode-css-language-server') == 1 then vim.lsp.start({ name = 'css', cmd = { 'vscode-css-language-server', '--stdio' } }) end
  autocmd FileType rust lua if vim.fn.executable('rust-analyzer') == 1 then vim.lsp.start({ name = 'rust_analyzer', cmd = { 'rust-analyzer' } }) end
  autocmd FileType lua lua if vim.fn.executable('lua-language-server') == 1 then vim.lsp.start({ name = 'lua_ls', cmd = { 'lua-language-server' } }) end

  autocmd LspAttach * lua local opts = { buffer = true, silent = true }
        \ vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        \ vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        \ vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        \ vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
        \ vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
        \ vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
        \ vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        \ vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
endif

" AI function
function! AI(msg) range
  let l:ft = &filetype !=# '' ? &filetype : ''
  let l:f = a:msg =~# '\v(^|\s)\+f($|\s)'
  let l:c = a:msg =~# '\v(^|\s)\+c($|\s)'
  let l:d = a:msg =~# '\v(^|\s)\+d($|\s)'
  let l:paths = [expand('%')]
  let l:lines = [
      \ '# System', 'You are an AI coding assistant.',
      \ 'Do not make code changes that are not directly and logically related to the prompt. ', '',
  \ ]

  if l:d | let l:paths += systemlist("grep -o -E '\\b\\w+\\.\\w+\\b' " . shellescape(expand('%'))
        \. " | sort -u | xargs -I{} sh -c 'test -f \"{}\" && echo \"{}\"' 2>/dev/null") | endif
  if l:c | let l:lines += ['# Symbols (ctags)']
        \ + systemlist('ctags -x ' . join(mapnew(l:paths, 'shellescape(v:val)'))) + [''] | endif
  if l:f | let l:lines += ['# File contents', '```' . l:ft]
        \ + systemlist('tail -n +1 ' . join(mapnew(l:paths, 'shellescape(v:val)'))) + ['```', ''] | endif

  let l:lines += [
      \ '# Focused block', '> File: ' . expand('%:t') . ' (Lines ' . a:firstline . '-' . a:lastline . ')',
      \ '```' . l:ft, ] + map(getline(a:firstline, a:lastline), 'v:val') + [ '```', '',
      \ '# User instruction', trim(substitute(a:msg, '\v\+[fcd]>', '', 'g'))
  \ ]

  let l:win = bufwinnr('^\[AI\]$')
  if l:win != -1 | execute l:win . 'wincmd w'
  else
    execute 'vsplit [AI]'
    setlocal buftype=nofile bufhidden=hide noswapfile filetype=markdown
  endif
  silent %delete _
  call setline(1, l:lines) | silent call setreg('+', getline(1, '$'), 'l')
  silent %!ai
  if search('^```', 'wn') | execute "normal! G$?```\<CR>kV?```\<CR>jygg" | endif
  wincmd p | normal! gv
endfunction
command! -range=% -nargs=* AI <line1>,<line2>call AI(<q-args>)

" Plugins configuration
" call PluginInstall('sheerun/vim-polyglot')
if isdirectory(g:pluginspath.'vim-polyglot')
  let g:vim_jsx_pretty_template_tags = ['html', 'jsx', '']
endif

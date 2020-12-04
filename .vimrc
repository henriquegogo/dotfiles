" Made by @henriquegogo

set t_Co=256                       " Set to 256 colors scheme
set number                         " Line numbers
set linebreak                      " Break line without break word
set nobackup                       " Dont save backup~ files
set ignorecase                     " Ignore case sensitive on searchs
set smartcase                      " If have any uppercase, active case sensitive
set smartindent                    " Auto-indent
set cursorline                     " Active line with other color
set incsearch                      " Find when you typing
set tags=tags;                     " Use ctags from current or parents folders
set notagrelative                  " Navigate into tags that are saved in other folder 
set backspace=2                    " Default backspace behaviour
set wildmode=full                  " Completion mode that is used for the command-line
set wildchar=<Tab> wildmenu        " Character you have to type to start wildcard expansion
set mouse=a                        " Mouse will use vim behavior
set hidden                         " To edit multiple buffers without save
set nofixeol                       " Prevent to add EOL in files
set expandtab                      " Indent with white spaces
set tabstop=2                      " Indent spaces
set shiftwidth=2                   " Auto-indent spaces
set splitright                     " New vertical split open to right
set splitbelow                     " New horizontal split open to bottom
set sessionoptions-=options        " Prevent :mksession override some default options
set display+=lastline              " Show last line much as possible
set guioptions-=T                  " GUI without toolbar
set suffixesadd+=.js               " Able to navigate into js imports without extensions
set directory=~/tmp,/tmp,/var/tmp  " Save .swp file in temporary directory
set path+=**                       " Find recursive when use command :find or :tabfind
set wildignore+=**/node_modules/** " Excluding folder for :find and :tabfind commands

syntax enable
filetype plugin indent on

au FileType c setlocal tabstop=4|setlocal shiftwidth=4
au FileType html setlocal tabstop=4|setlocal shiftwidth=4

" Keys map
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
vnoremap <Leader>y "+y
nnoremap <Leader>yy "+yy
map <Leader>p "+p
map <Leader>P "+P

" Filesystem - netrw
let g:netrw_banner = 0                " Hide netrw instructions
let g:netrw_liststyle = 3             " Tree view
let g:netrw_winsize = -25             " Window width
let g:netrw_mousemaps = 0             " Disable mouse maps
" Prevent double click parent up action
au FileType netrw noremap <buffer> <2-leftmouse> :echo "Press ENTER to open"<cr>
au FileType netrw noremap <buffer> <3-leftmouse> <nop>
au FileType netrw noremap <buffer> <4-leftmouse> <nop>

" Commands
command! UpdateVimrc !wget https://raw.githubusercontent.com/henriquegogo/dotfiles/master/.vimrc -O ~/.vimrc
command! Ctags silent exe &filetype == "javascript" ? ':!ctags -f ~/tags -Ru --languages=javascript --exclude=node_modules *' :
      \ &filetype == "ruby" ? ':!ctags -f ~/tags -Ru --languages=ruby * `bundle show --paths`' :
      \ ':!ctags -f ~/tags -Ru *' | redraw!
command! InstallVimPlugins !mkdir -p ~/.vim/pack/default/start && cd ~/.vim/pack/default/start &&
      \ wget 'https://api.github.com/repos/sheerun/vim-polyglot/tarball' -O plugin.tar.gz && tar xzfv plugin.tar.gz &&
      \ wget 'https://github.com/neoclide/coc.nvim/archive/release.tar.gz' -O plugin.tar.gz && tar xzfv plugin.tar.gz &&
      \ rm plugin.tar.gz

" Statusbar style
set laststatus=2                          " Always show statusbar
set statusline=
set statusline+=%1*\ %n\                  " Buffer number
set statusline+=%2*\ %<%{fnamemodify(getcwd(),':~')}\     " Path
set statusline+=%3*\ %<%{fnamemodify(expand('%'),':~:.')} " Filename
set statusline+=%=                        " Align to right
set statusline+=%2*\ %p%%\ \|\ %l\:%c\    " Percent Row:Col
set statusline+=%1*\ %y\                  " File type

hi User1 ctermfg=231 ctermbg=25  guifg=#ffffff guibg=#005faf
hi User2 ctermfg=231 ctermbg=237 guifg=#ffffff guibg=#3a3a3a
hi User3 ctermfg=231 ctermbg=235 guifg=#ffffff guibg=#262626

" Colour scheme
set background=dark
 
hi CursorLine             ctermbg=237               guibg=#3a3a3a
hi MatchParen ctermfg=255 ctermbg=242 guifg=#eeeeee guibg=#6c6c6c
hi Pmenu      ctermfg=15  ctermbg=238 guifg=#ffffff guibg=#444444
hi PmenuSel   ctermfg=0   ctermbg=107 guifg=#000000 guibg=#87af5f

hi Normal     ctermfg=253 ctermbg=233 guifg=#dadada guibg=#121212
hi LineNr     ctermfg=244 ctermbg=232 guifg=#808080 guibg=#080808
hi SignColumn             ctermbg=233               guibg=#121212
hi ColorColumn            ctermbg=232               guibg=#080808
hi Visual                 ctermbg=238               guibg=#444444

hi Comment    ctermfg=244 guifg=#808080
hi Boolean    ctermfg=148 guifg=#afd700
hi String     ctermfg=148 guifg=#afd700
hi Identifier ctermfg=148 guifg=#afd700
hi Function   ctermfg=229 guifg=#ffffaf
hi Type       ctermfg=103 guifg=#8787af
hi Statement  ctermfg=103 guifg=#8787af
hi Keyword    ctermfg=208 guifg=#ff8700
hi Constant   ctermfg=208 guifg=#ff8700
hi Number     ctermfg=208 guifg=#ff8700
hi Special    ctermfg=208 guifg=#ff8700
hi Preproc    ctermfg=110 guifg=#87afd7
hi Folded     ctermfg=15  guifg=#ffffff
hi Title      ctermfg=15  guifg=#ffffff cterm=bold gui=bold

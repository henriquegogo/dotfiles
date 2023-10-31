" Plugin specific configuration settings
" - onedark (theme)
" - lightline (bottom bar)
" - fzf + fzf.vim (finder)
" - vim-polyglot (syntax highlighting)
" - vim-surround (handle blocks and quotes)
" - CoC (autocompletion)
"   * coc-tabnine, coc-prettier, coc-git, coc-html,
"   * coc-eslint, coc-tsserver, coc-pyright, coc-clangd

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

let g:clipboard = {
      \   'name': 'WslClipboard',
      \   'copy': {
      \      '+': 'clip.exe',
      \      '*': 'clip.exe',
      \    },
      \   'paste': {
      \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      \   },
      \   'cache_enabled': 0,
      \ }

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

let g:onedark_color_overrides = {
      \ "background": {"gui": "#2F343F", "cterm": "233", "cterm16": "0" },
      \ }

colorscheme onedark

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.path:append '**'
vim.g.netrw_banner = 0
vim.g.netrw_winsize = -25
vim.g.netrw_liststyle = 3

local map = vim.keymap.set

-- Colorscheme
vim.opt.background = 'dark'
vim.cmd([[
  hi Boolean      ctermfg=173             " Dark Yellow
  hi ColorColumn              ctermbg=237 " Dark Gray
  hi Comment      ctermfg=059             " Gray
  hi Constant     ctermfg=075             " Light Blue
  hi CursorColumn             ctermbg=237 " Dark Gray
  hi CursorLine   cterm=NONE  ctermbg=236 " Darker Gray
  hi CursorLineNr ctermfg=145 cterm=NONE  " Light Gray
  hi DiffAdd      ctermfg=107 ctermbg=235 " Green | Black
  hi DiffChange   ctermfg=179 ctermbg=235 " Yellow | Black
  hi DiffDelete   ctermfg=167 ctermbg=235 " Red | Black
  hi DiffText     ctermfg=179 ctermbg=235 " Yellow | Black
  hi Folded       ctermfg=145 ctermbg=237 " Light Gray | Dark Gray
  hi FoldColumn               ctermbg=235 " Black
  hi Function     ctermfg=075             " Blue
  hi Identifier   ctermfg=167 cterm=NONE  " Red
  hi Keyword      ctermfg=134             " Purple
  hi LineNr       ctermfg=238             " Gray
  hi MatchParen               ctermbg=059 " Gray
  hi Normal       ctermfg=145 ctermbg=235 " Light Gray | Black
  hi Number       ctermfg=173             " Dark Yellow
  hi Pmenu        ctermfg=145 ctermbg=237 " Light Gray | Dark Gray
  hi PmenuSel     ctermfg=236 ctermbg=075 " Darker Gray | Purple
  hi PreProc      ctermfg=179             " Yellow
  hi Search       ctermfg=235 ctermbg=179 " Black | Yellow
  hi SignColumn               ctermbg=235 " Light Gray
  hi Special      ctermfg=075             " Blue
  hi Statement    ctermfg=134             " Purple
  hi String       ctermfg=107             " Green
  hi Structure    ctermfg=179             " Yellow
  hi TabLine      cterm=NONE              " Remove underline
  hi Type         ctermfg=179             " Yellow
  hi Visual                   ctermbg=237 " Dark Gray
]])

-- Statusline
vim.cmd([[
  hi StatusBlue  ctermfg=251 ctermbg=025 cterm=bold
  hi StatusBlack ctermfg=145 ctermbg=237
  hi StatusGray  ctermfg=145 ctermbg=239
]])
vim.opt.laststatus = 2            -- Always show statusbar
vim.o.statusline = ""
.. "%#StatusBlue# %Y "          -- Filetype
.. "%#StatusGray# %{fnamemodify(getcwd(), ':t')} " -- Current folder
.. "%#StatusBlack# %f %M %R %=" -- Filename / Modified / Readonly / Right Aligned
.. "%#StatusGray# %p%% "        -- Percentage
.. "%#StatusBlue# %l:%c "       -- Line: Column

-- Buffers and tabs navigation
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>t', ':tabnew<CR>')
map('n', '<leader>l', ':tabnext<CR>')
map('n', '<leader>h', ':tabprevious<CR>')
map('n', '<leader>j', ':bnext<CR>')
map('n', '<leader>k', ':bprevious<CR>')
map('n', '<leader>v', ':vsplit<CR>')
map('n', '<leader>s', ':split<CR>')

-- Add / Remove words and comments in front of line
map('n', '<space>0', '0i')
map('v', '<space>0', '0<C-Q>I')
map('n', '<space>00', '0de')
map('v', '<space>00', ':norm 0de<CR>')

-- Surround blocks and quotes
map('n', '<space>\'', 'bvec\'\'<ESC>P')
map('n', '<space>"', 'bvec""<ESC>P')
map('n', '<space>(', 'bvec()<ESC>P')
map('n', '<space>{', 'bvec{}<ESC>P')
map('n', '<space>[', 'bvec[]<ESC>P')
map('v', '<space>\'', 'c\'\'<ESC>P')
map('v', '<space>"', 'c""<ESC>P')
map('v', '<space>(', 'c()<ESC>P')
map('v', '<space>{', 'c{}<ESC>P')
map('v', '<space>[', 'c[]<ESC>P')
map('n', '<space>\'\'', 'va\'<ESC>x`<x')
map('n', '<space>""', 'va"<ESC>x`<x')
map('n', '<space>((', 'va(<ESC>x`<x')
map('n', '<space>{{', 'va{<ESC>x`<x')
map('n', '<space>[[', 'va[<ESC>x`<x')
map('v', '<space>\'\'', '<ESC>`>x`<x')
map('v', '<space>""', '<ESC>`>x`<x')
map('v', '<space>((', '<ESC>`>x`<x')
map('v', '<space>{{', '<ESC>`>x`<x')
map('v', '<space>[[', '<ESC>`>x`<x')

-- Find files by name
if vim.fn.executable('find') == 1 then
  vim.api.nvim_create_user_command('Find', function(opts)
    vim.cmd(':cgetexpr system(\'find . -type f '
    .. '! -path "*/.*" ! -path "**/node_modules/*" ! -path "**/venv/*" ! -path "**/vendor/*" ! -path "**/build/* '
    .. '! -path "**/dist/*"" ! -path "**/tmp/*" ! -path "**/out/*" ! -path "**/bin/*" -name "*'
    .. opts.fargs[1]
    .. '*" -printf "%p:0:0:%CF %Cr \\n" \') | cw | setlocal modifiable | sort | setlocal nomodifiable')
  end, {nargs = 1})
  map('n', '<leader>e', ':Find ')
end

-- Search files containing text
if vim.fn.executable('rg') == 1 then
  vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case '
  .. '-g \'!{**/node_modules/*,**/venv/*,**/vendor/*,**/build/*,**/dist/*,**/tmp/*,**/out/*,**/bin/*}\''
  vim.api.nvim_create_user_command('Search', function(opts)
    vim.cmd('silent grep! "' .. opts.fargs[1]
    .. '" | cw | setlocal modifiable | sort | setlocal nomodifiable')
  end, {nargs = 1})
  map('n', '<leader>/', ':Search ')
end

-- Git blame / diff
if vim.fn.executable('git') == 1 then
  map('n', '<leader>g', ':echo system("git -C " .. expand("%:p:h") .. " blame " .. expand("%:p") .. '
  .. '" -L" .. line(".") .. "," .. line("."))<CR>')
  map('v', '<leader>g', ':<C-U>echo system("git -C " .. expand("%:p:h") .. " blame " .. expand("%:p") .. '
  .. '" -L" .. getpos("\'<")[1] .. "," .. getpos("\'>")[1])<CR>')

  vim.fn.sign_define('DiffSign', {text = '~', texthl = 'DiffChange', group = 'DiffGroup'})
  vim.api.nvim_create_user_command('DiffShow', function()
    local bufnr = vim.fn.bufnr('%')
    if vim.api.nvim_buf_get_option(bufnr, 'buftype') == '' and
      vim.fn.system("git -C " .. vim.fn.expand('%:p:h') .. " rev-parse --is-inside-work-tree") == "true\n" then
      vim.fn.sign_unplace('*', {buffer = bufnr, group = 'DiffGroup'})
      local lines = vim.fn.systemlist('git -C ' .. vim.fn.expand('%:p:h') .. ' blame -sf --abbrev=1 '
      .. vim.fn.expand("%:p") .. ' | grep ^00000 | sed "s/^00000 //; s/  */:/; s/)/:/"')
      for _, item in ipairs(lines) do
        vim.fn.sign_place(bufnr, '', 'DiffSign', bufnr, {lnum = vim.split(item, ':')[2]})
      end
    end
  end, {nargs = 0})
  vim.cmd('autocmd BufReadPost,BufWritePost * DiffShow')
end

-- Plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
      map("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      map("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
      map("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
      map("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
      map("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
      map("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
      map("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
      map("n", "gd", "<Plug>(coc-definition)", {silent = true})
      map("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
      map("n", "gi", "<Plug>(coc-implementation)", {silent = true})
      map("n", "gr", "<Plug>(coc-references)", {silent = true})

      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end
      map("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
      })

      map("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
      map("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
      map("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

      vim.api.nvim_create_autocmd("FileType", {
        group = "CocGroup",
        pattern = "typescript,json",
        command = "setl formatexpr=CocAction('formatSelected')",
        desc = "Setup formatexpr specified filetype(s)."
      })

      vim.api.nvim_create_autocmd("User", {
        group = "CocGroup",
        pattern = "CocJumpPlaceholder",
        command = "call CocActionAsync('showSignatureHelp')",
        desc = "Update signature help on jump placeholder"
      })

      local opts = {silent = true, nowait = true}
      map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
      map("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
      map("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
      map("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
      map("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)
      map("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
      map("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
      map("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
      map("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)
      map("x", "if", "<Plug>(coc-funcobj-i)", opts)
      map("o", "if", "<Plug>(coc-funcobj-i)", opts)
      map("x", "af", "<Plug>(coc-funcobj-a)", opts)
      map("o", "af", "<Plug>(coc-funcobj-a)", opts)
      map("x", "ic", "<Plug>(coc-classobj-i)", opts)
      map("o", "ic", "<Plug>(coc-classobj-i)", opts)
      map("x", "ac", "<Plug>(coc-classobj-a)", opts)
      map("o", "ac", "<Plug>(coc-classobj-a)", opts)

      local opts = {silent = true, nowait = true, expr = true}
      map("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      map("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
      map("i", "<C-f>",
      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
      map("i", "<C-b>",
      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
      map("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      map("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
      map("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
      map("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

      vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
      vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})
      vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

      local opts = {silent = true, nowait = true}
      map("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
      map("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
      map("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
      map("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
      map("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
      map("n", "<space>j", ":<C-u>CocNext<cr>", opts)
      map("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
      map("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
    end,
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      vim.g.codeium_disable_bindings = 1
      local opts = {expr = true, silent = true}
      -- Tab compatibility with CoC
      map("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : codeium#Accept()', opts)
      map('i', '<c-x>', 'codeium#Clear()', opts)
    end
  },
}, {
  ui = {
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  }
})

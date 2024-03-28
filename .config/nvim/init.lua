-- Settings
vim.cmd.source('$HOME/.vimrc')
vim.opt.clipboard = 'unnamedplus'
vim.opt.inccommand = 'split'

-- LSP
--[[
function LspAutoCmd(filetypes, cmd, settings)
  if vim.fn.executable(cmd[1]) == 1 then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function(ev)
        vim.lsp.buf_attach_client(ev.buf, vim.lsp.start_client({
          name = cmd[1],
          cmd = cmd,
          root_dir = vim.fn.getcwd(),
          settings = settings or {},
        }))
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.bo[ev.buf].tagfunc='v:lua.vim.lsp.tagfunc'
        local opts = {buffer = ev.buf}
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end
    })
end
end
LspAutoCmd({'javascript', 'typescript'}, {'typescript-language-server', '--stdio'})
LspAutoCmd({'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto'}, {'clangd'})
LspAutoCmd({'python'}, {'pyright-langserver', '--stdio'}, {python = {}})
LspAutoCmd({'go'}, {'gopls'})
--]]

-- Plugins
local map = vim.keymap.set  
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

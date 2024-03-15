vim.g.netrw_banner = 0
vim.g.netrw_winsize = -25
vim.g.netrw_liststyle = 3

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.hlsearch = true

local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'junegunn/fzf',
  'junegunn/fzf.vim',
  'tpope/vim-sleuth',
  'tpope/vim-commentary',
  'tpope/vim-fugitive',
  'airblade/vim-gitgutter',
  'itchyny/lightline.vim',
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup({
        style = 'darker'
      })
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'clangd',
          'pyright',
          'typescript-language-server',
        },
        run_on_start = true,
        start_delay = 3000,
      })
      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end
        }
      })
      local buf = vim.lsp.buf
      map('n', '<leader>e', vim.diagnostic.open_float)
      map('n', '[d', vim.diagnostic.goto_prev)
      map('n', ']d', vim.diagnostic.goto_next)
      map('n', '<leader>q', vim.diagnostic.setloclist)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          local opts = { buffer = ev.buf }
          map('n', 'gD', buf.declaration, opts)
          map('n', 'gd', buf.definition, opts)
          map('n', 'K', buf.hover, opts)
          map('n', 'gi', buf.implementation, opts)
          map('n', '<C-k>', buf.signature_help, opts)
          map('n', '<leader>D', buf.type_definition, opts)
          map('n', '<leader>rn', buf.rename, opts)
          map({ 'n', 'v' }, '<leader>ca', buf.code_action, opts)
          map('n', 'gr', buf.references, opts)
          map('n', '<leader>f', function()
            buf.format { async = true }
          end, opts)
        end,
      })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        mapping = {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<Up>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    end
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
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

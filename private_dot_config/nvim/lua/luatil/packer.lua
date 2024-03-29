vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- use { "catppuccin/nvim", as = "catppuccin" }

  -- use({
  --   'rose-pine/neovim',
  --   as = 'rose-pine',
  --   config = function()
  --     vim.cmd('colorscheme rose-pine')
  --   end
  -- })
  --
  --
  -- use ({
  --   "Mofiqul/vscode.nvim",
  --   as = "vscode",
  --   config = function()
  --       vim.cmd('colorscheme vscode')
  --   end
  -- })

  use ({
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
          vim.cmd('colorscheme catppuccin-mocha')
      end

  })

  use 'github/copilot.vim'

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  use { 'paretje/nvim-man' }

  use { 'tpope/vim-fugitive' }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },       -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },       -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },           -- Required
      { 'hrsh7th/cmp-nvim-lsp' },       -- Required
      { 'L3MON4D3/LuaSnip' },           -- Required
    }
  }
end)

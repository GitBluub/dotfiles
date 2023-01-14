local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end
local packer = require("packer")

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use 'lewis6991/impatient.nvim'
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- tpope dings
  use "tpope/vim-surround"
  use "tpope/vim-speeddating"
  use "tpope/vim-repeat"
  use "tpope/vim-sleuth"
  use "nishigori/increment-activator"

  use "theprimeagen/harpoon"

  use { "AckslD/nvim-gfold.lua" }
  use { "airblade/vim-rooter" }
  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  })
  -- Colorschemes
  use "folke/tokyonight.nvim"
  use {"catppuccin/nvim", config = function()
    vim.cmd('colorscheme catppuccin')
  end}
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {"hrsh7th/cmp-cmdline"},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
  use {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"
  use "numToStr/Comment.nvim"

  use "tpope/vim-fugitive"
  use { "lewis6991/gitsigns.nvim", requires = { 'nvim-lua/plenary.nvim' } }
  -- Utilities
  use "folke/which-key.nvim"

  use {
    { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    'stevearc/dressing.nvim',
  }
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use "petertriho/nvim-scrollbar"
  use { "j-hui/fidget.nvim", config = function() require("fidget").setup {} end }
  use "folke/zen-mode.nvim"
end)

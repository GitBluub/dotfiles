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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

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


  use { "AckslD/nvim-gfold.lua" }
  use { "airblade/vim-rooter", config = function() vim.g.rooter_manual_only = 1 end }
  -- use { "yyk/simply-auto-save.nvim", branch = "check-valid-buf", config = function() require "auto-save".setup({ write_all_buffers = true }) end }
  -- Colorschemes
  use "folke/tokyonight.nvim"
  use "catppuccin/nvim"

  -- LSP
 use { "williamboman/mason.nvim" }
 use {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    -- 'williamboman/nvim-lsp-installer',
  }

  -- Autocomplete
  use "L3MON4D3/LuaSnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"

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
end)

vim.cmd "colorscheme catppuccin"

local options = {
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  fileencoding = "utf-8",                  -- the encoding written to a file
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  mouse = "a",                             -- allow the mouse to be used in neovim
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  wrap = false,                            -- display lines as one long line
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  updatetime = 50,                        -- faster completion (4000ms default)
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  ignorecase = true,                       -- ignore case in search patterns
  cursorline = true,                       -- highlight the current line
  swapfile = false,
  backup = false,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,
  hlsearch = false,
  incsearch = true,
}


vim.g.mapleader = " "

for k, v in pairs(options) do
  vim.opt[k] = v
end




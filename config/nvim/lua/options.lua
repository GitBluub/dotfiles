local options = {
  number = true,                           -- set numbered lines
  relativenumber = true,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  expandtab = true,                        -- convert tabs to spaces
  fileencoding = "utf-8",                  -- the encoding written to a file
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  mouse = "a",                             -- allow the mouse to be used in neovim
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  wrap = false,                            -- display lines as one long line
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  updatetime = 300,                        -- faster completion (4000ms default)
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  fileencoding = "utf-8",                  -- the encoding written to a file
  ignorecase = true,                       -- ignore case in search patterns
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  cursorline = true,                       -- highlight the current line
}


for k, v in pairs(options) do
  vim.opt[k] = v
end


local util = require("lspconfig.util")

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      omnisharp = {
        filetypes = { "cs", "vb", "cake" },
        root_dir = util.root_pattern("*.sln", "*.csproj", "omnisharp.json", "function.json", ".git"),
      },
    },
  },
}

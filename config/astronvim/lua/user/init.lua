local notify = vim.notify
vim.notify = function(msg, ...)
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end

	notify(msg, ...)
end

return {
	colorscheme = "catppuccin",
	options = {
		opt = {
			showtabline = 0,
		},
	},
	lsp = {
		formatting = {
			format_on_save = true,
		},
	},
	plugins = {
		"AstroNvim/astrocommunity",
		{ import = "astrocommunity.colorscheme.catppuccin" },
		{ import = "astrocommunity.diagnostics.trouble-nvim" },
		{ import = "astrocommunity.terminal-integration.flatten-nvim" },
		{ import = "astrocommunity.pack.rust" },
		{ import = "astrocommunity.pack.python" },
		{ import = "astrocommunity.pack.json" },
		{ import = "astrocommunity.pack.markdown" },
		{ import = "astrocommunity.markdown-and-latex.glow-nvim" },
		{ import = "astrocommunity.pack.prisma" },
		{ import = "astrocommunity.pack.typescript" },
		{ import = "astrocommunity.pack.lua" },
		{ import = "astrocommunity.completion.copilot-lua" },
		{ import = "astrocommunity.completion.copilot-lua-cmp" },
		{ import = "astrocommunity.comment.mini-comment" },
		{
			"nvim-neo-tree/neo-tree.nvim",
			config = function()
				require("neo-tree").setup({
					window = {
						position = "right",
					},
					filesystem = {
						filtered_items = {
							hide_dotfiles = false,
						},
					},
				})
			end,
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("null-ls").setup({
					on_init = function(new_client, _)
						new_client.offset_encoding = "utf-16"
					end,
				})
			end,
		},
		-- ... import any community contributed plugins here
	},
}

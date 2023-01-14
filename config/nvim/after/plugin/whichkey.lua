wk = require("which-key")
vim.opt["timeoutlen"] = 500

wk.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	window = {
		border = "rounded",
	},
	operators = {
		gc = "Comments",
		ys = "Add Surroundings",
		yS = "Add Surroundings",
	}
})

wk.register({
	gc = {
		name = "Comment",
	},
	ys = { name = "Add Surroundings" },
	ds = { name = "Delete Surroundings" },
	cs = { name = "Change Surroundings" },
	yS = { name = "Add Surroundings" },
	dS = { name = "Delete Surroundings" },
	cS = { name = "Change Surroundings" },
}, {
	noremap = false,
})

wk.register({
	as = { "Toggle auto save" },
	a = { "Automatic settings" }
}, {
	prefix = "<leader>"
})

wk.register({
	y = { "Yank to system clipboard" },
	Y = { "Yank line to system clipboard" },
	p = { "Past from system clipboard" },
	P = { "Past line from system clipboard" },
}, {
	prefix = "<leader>"
})
--lsp
wk.register({
	["<leader>"] = {
		["v"] = {
			["ws"] = "workspace symbols",
			["d"] = "diagnostic"
		}
	},
	g = {
		--"go",
		D = "Go to declaration",
		d = "Go to definition",
		I = "Go to implementation",
		r = "Go to references"
	}
})

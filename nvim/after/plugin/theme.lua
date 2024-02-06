vim.cmd.colorscheme("catppuccin")

require("catppuccin").setup({
	integrations = {
		gitsigns = true,
		leap = true,
		indent_blankline = {
			enabled = true,
			scope_color = "lavender",
			colored_indent_levels = true,
		},
		neotree = true,
		treesitter = true,
		rainbow_delimiters = true,
		telescope = {
			enabled = true,
		},
		lsp_trouble = true,
		which_key = true,
	},
})

vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
vim.api.nvim_set_hl(0, "LeapMatch", {
	fg = "black",
	bold = true,
	nocombine = true,
})

vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
	fg = "#ff40ff",
	bold = true,
	nocombine = true,
})

vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
	fg = "#8280ff",
	bold = true,
	nocombine = true,
})

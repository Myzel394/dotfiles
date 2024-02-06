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

vim.cmd.colorscheme("catppuccin")


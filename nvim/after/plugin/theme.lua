require("catppuccin").setup({
	flavour = "mocha",
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
		headlines = false,
	},
	color_overrides = {
		mocha = {
			rosewater = "#efc9c2",
			flamingo = "#ebb2b2",
			pink = "#f2a7de",
			mauve = "#58ccf5",
			red = "#ea7183",
			maroon = "#b889f4",
			peach = "#f39967",
			yellow = "#eaca89",
			green = "#96d382",
			teal = "#78cec1",
			sky = "#91d7e3",
			sapphire = "#68bae0",
			blue = "#739df2",
			lavender = "#a0a8f6",
			text = "#b5c1f1",
			subtext1 = "#a6b0d8",
			subtext0 = "#959ec2",
			overlay2 = "#848cad",
			overlay1 = "#717997",
			overlay0 = "#63677f",
			surface2 = "#505469",
			surface1 = "#3e4255",
			surface0 = "#2c2f40",
			base = "#1a1c2a",
			mantle = "#141620",
			crust = "#0e0f16",
		},
	},
})

vim.cmd.colorscheme("catppuccin")

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

vim.api.nvim_set_hl(0, "EyelinerDimmed", { link = "Comment" })

require("modicator").setup({
	highlights = {
		-- Default options for bold/italic
		defaults = {
			bold = true,
			italic = false,
		},
	},
})

vim.api.nvim_set_hl(0, "NormalMode", {})
vim.api.nvim_set_hl(0, "InsertMode", { fg = "#2e8041" })
vim.api.nvim_set_hl(0, "CommandMode", { fg = "#CC6600" })
vim.api.nvim_set_hl(0, "VisualMode", { fg = "#215f9f" })
vim.api.nvim_set_hl(0, "ReplaceMode", { fg = "#ff4d4d" })

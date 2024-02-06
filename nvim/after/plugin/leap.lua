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

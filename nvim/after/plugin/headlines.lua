vim.cmd([[highlight Headline1 guibg=#4E4B5C]])
vim.cmd([[highlight Headline2 guibg=#3B384B]])
vim.cmd([[highlight Headline3 guibg=#302D41]])
vim.cmd([[highlight Headline4 guibg=#272338]])
vim.cmd([[highlight Headline5 guibg=#1F1C2C]])

require("headlines").setup({
	markdown = {
		headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5" },
	},
})

require("scope").setup({})

require("bufferline").setup({
	options = {
		separator_style = "slant",
		show_buffer_close_icon = false,
		show_close_icon = false,
		buffer_close_icon = "",
		close_icon = "",
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})

vim.keymap.set("n", "<leader>a", function()
	vim.cmd(":tabnew")
	vim.cmd(":Neotree position=current")
end, { desc = "Create new tab", noremap = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close this tab", noremap = true })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close all other tabs", noremap = true })

for i = 1, 9 do
	vim.keymap.set(
		"n",
		"<leader>" .. i,
		":" .. i .. "tabnext<CR>",
		{ desc = "Go to tab " .. i, noremap = true, silent = true }
	)
end

-- Open another tab in split
for i = 1, 9 do
	vim.keymap.set("n", "<leader>ts" .. i, function()
		local win_id = vim.api.nvim_tabpage_get_win(i)
		local buf = vim.api.nvim_win_get_buf(win_id)

		vim.cmd("vert belowright sb" .. buf)
		vim.cmd("tabclose " .. i)
	end, { desc = "Open tab " .. i .. " in vertical split" })
end

for i = 1, 9 do
	vim.keymap.set(
		"n",
		"<C-" .. i .. ">",
		":BufferLineGoToBuffer " .. i .. "<CR>",
		{ desc = "Go to tab " .. i, noremap = true, silent = true }
	)
end

vim.keymap.set("n", "<C-a>", ":BufferLineCyclePrev<CR>", { desc = "Go to previous tab", silent = true })
vim.keymap.set("n", "<C-d>", ":BufferLineCycleNext<CR>", { desc = "Go to next tab", silent = true })

-- Remap "ctrl - d to ctrl j
vim.keymap.set("n", "<C-j>", "<C-d>", { desc = "Scroll down", silent = true })
vim.keymap.set("n", "<C-k>", "<C-u>", { desc = "Scroll up", silent = true })

vim.keymap.set("n", "<leader>q", ":b#|bd#<CR>", { desc = "Close buffer", silent = true })

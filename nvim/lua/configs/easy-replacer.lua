-- Go x up, copy value and paste at current position
vim.keymap.set("n", "<leader>k", function()
	local amount = vim.v.count

	local cursor = vim.api.nvim_win_get_cursor(0)
	local new_line = vim.api.nvim_buf_get_lines(0, cursor[1] - amount - 1, cursor[1] - amount, false)[1]

	-- Replace current line with the new line
	vim.api.nvim_buf_set_lines(0, cursor[1], cursor[1], false, { new_line })
	-- Move cursor down
	vim.api.nvim_win_set_cursor(0, { cursor[1] + 1, cursor[2] })
end)
vim.keymap.set("v", "<leader>k", function()
	local amount = vim.v.count

	local cursor = vim.api.nvim_win_get_cursor(0)
	local new_line = vim.api.nvim_buf_get_lines(0, cursor[1] - amount - 1, cursor[1] - amount, false)[1]

	-- Replace current line with the new line
	vim.api.nvim_buf_set_lines(0, cursor[1] - 1, cursor[1], false, { new_line })
end)

-- Go x down, copy value and paste at current position
vim.keymap.set("n", "<leader>j", function()
	local amount = vim.v.count

	local cursor = vim.api.nvim_win_get_cursor(0)
	local new_line = vim.api.nvim_buf_get_lines(0, cursor[1] + amount - 1, cursor[1] + amount, false)[1]

	-- Replace current line with the new line
	vim.api.nvim_buf_set_lines(0, cursor[1], cursor[1], false, { new_line })
	-- Move cursor down
	vim.api.nvim_win_set_cursor(0, { cursor[1] + 1, cursor[2] })
end)
vim.keymap.set("v", "<leader>j", function()
	local amount = vim.v.count

	local cursor = vim.api.nvim_win_get_cursor(0)
	local new_line = vim.api.nvim_buf_get_lines(0, cursor[1] + amount - 1, cursor[1] + amount, false)[1]

	-- Replace current line with the new line
	vim.api.nvim_buf_set_lines(0, cursor[1] - 1, cursor[1], false, { new_line })
end)

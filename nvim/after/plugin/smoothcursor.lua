local IS_RUNNING_ON_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"
local last_positions = require("smoothcursor.last_positions")

require("smoothcursor").setup({
	type = "default", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".

	cursor = "", -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
	texthl = "SmoothCursor", -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.
	linehl = nil, -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.

	fancy = {
		enable = not IS_RUNNING_ON_LIMITED_HARDWARE,
		head = {
			cursor = "▷",
			texthl = "SmoothCursor",
			linehl = nil,
		}, -- false to disable fancy head
		body = {
			{ cursor = "", texthl = "SmoothCursorRed" },
			{ cursor = "", texthl = "SmoothCursorOrange" },
			{ cursor = "●", texthl = "SmoothCursorYellow" },
			{ cursor = "●", texthl = "SmoothCursorGreen" },
			{ cursor = "•", texthl = "SmoothCursorAqua" },
			{ cursor = ".", texthl = "SmoothCursorBlue" },
			{ cursor = ".", texthl = "SmoothCursorPurple" },
		},
		tail = { cursor = nil, texthl = "SmoothCursor" }, -- false to disable fancy tail
	},

	autostart = true, -- Automatically start SmoothCursor
	flyin_effect = nil, -- Choose "bottom" or "top" for flying effect
	speed = 45, -- Max speed is 100 to stick with your current position
	intervals = 40, -- Update intervals in milliseconds
	priority = 10, -- Set marker priority
	timeout = 3000, -- Timeout for animations in milliseconds
	threshold = 3, -- Animate only if cursor moves more than this many lines
	disable_float_win = false, -- Disable in floating windows
	enabled_filetypes = nil, -- Enable only for specific file types, e.g., { "lua", "vim" }
	disabled_filetypes = nil, -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
	show_last_positions = "leave",
})

-- Jump to last cursor position keymaps
vim.keymap.set("n", "<leader>ii", function()
	local buffer = vim.api.nvim_get_current_buf()
	local last_position = last_positions.get_positions(buffer)["i"]

	if last_position then
		vim.api.nvim_win_set_cursor(0, { last_position[1], last_position[2] })
	end
end, { noremap = true, silent = true, desc = "Jump to last input mode position" })
vim.keymap.set("n", "<leader>iv", function()
	local buffer = vim.api.nvim_get_current_buf()
	local last_position = last_positions.get_positions(buffer)["v"]

	if last_position == nil then
		last_position = last_positions.get_positions(buffer)["V"]
	end

	if last_position then
		vim.api.nvim_win_set_cursor(0, { last_position[1], last_position[2] })
	end
end, { noremap = true, silent = true, desc = "Jump to last visual mode position" })
vim.keymap.set("n", "<leader>iV", function()
	local buffer = vim.api.nvim_get_current_buf()
	local last_position = last_positions.get_positions(buffer)["V"]

	if last_position == nil then
		last_position = last_positions.get_positions(buffer)["v"]
	end

	if last_position then
		vim.api.nvim_win_set_cursor(0, { last_position[1], last_position[2] })
	end
end, { noremap = true, silent = true, desc = "Jump to last VISUAL (block) mode position" })
vim.keymap.set("n", "<leader>in", function()
	local buffer = vim.api.nvim_get_current_buf()
	local last_position = last_positions.get_positions(buffer)["n"]

	if last_position then
		vim.api.nvim_win_set_cursor(0, { last_position[1], last_position[2] })
	end
end, { noremap = true, silent = true, desc = "Jump to last normal mode position" })

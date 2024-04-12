local autocmd = vim.api.nvim_create_autocmd

autocmd({ "ModeChanged" }, {
	callback = function()
		local current_mode = vim.fn.mode()
		if current_mode == "n" then
			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#8aa872" })
			vim.fn.sign_define("smoothcursor", { text = "▷" })
		elseif current_mode == "v" then
			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
			vim.fn.sign_define("smoothcursor", { text = "" })
		elseif current_mode == "V" then
			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
			vim.fn.sign_define("smoothcursor", { text = "" })
		elseif current_mode == "�" then
			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
			vim.fn.sign_define("smoothcursor", { text = "" })
		elseif current_mode == "R" then
			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
			vim.fn.sign_define("smoothcursor", { text = "󰊄" })
		elseif current_mode == "i" then
			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#668aab" })
			vim.fn.sign_define("smoothcursor", { text = "" })
		end
	end,
})

vim.fn.sign_define("smoothcursor_v", { text = "" })
vim.fn.sign_define("smoothcursor_V", { text = "" })
vim.fn.sign_define("smoothcursor_i", { text = "" })
vim.fn.sign_define("smoothcursor_�", { text = "" })
vim.fn.sign_define("smoothcursor_R", { text = "󰊄" })


local ascii = require("ascii")

local settings = {
	-- every line should be same width without escaped \
	header = {
		type = "text",
		align = "center",
		fold_section = false,
		title = "Header",
		margin = 5,
		content = function()
			local lines = ascii.get_random_global()

			while #lines > 30 do
				lines = ascii.get_random_global()
			end

			return lines
		end,
		highlight = "Statement",
		default_color = "#FFFFFF",
		oldfiles_amount = 0,
	},
	-- name which will be displayed and command
	header_2 = {
		type = "mapping",
		align = "center",
		fold_section = true,
		title = "Basic Commands",
		margin = 5,
		content = {
			{ "  Find File", "Telescope find_files", "<C-f>" },
			{ "󰍉 Find Word", "Telescope live_grep", "<leader>s" },
			{ "  Recent Files", "Telescope oldfiles", "<leader>of" },
			{ "  File Browser", "Telescope file_browser", "<leader>n" },
			{ "  Colorschemes", "Telescope colorscheme", "<leader>cs" },
			{ "  New File", "lua require'startup'.new_file()", "<leader>nf" },
		},
		highlight = "String",
		default_color = "",
		oldfiles_amount = 0,
	},
	body = {
		type = "oldfiles",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Oldfiles",
		margin = 5,
		content = "",
		highlight = "String",
		default_color = "",
		oldfiles_amount = 5,
	},

	body_2 = {
		type = "oldfiles",
		oldfiles_directory = true,
		align = "center",
		fold_section = false,
		title = "",
		margin = 5,
		content = "",
		highlight = "String",
		oldfiles_amount = 5,
	},
	clock = {
		type = "text",
		content = function()
			local clock = "  " .. os.date("%H:%M")
			local date = "  " .. os.date("%d-%m-%y")
			return { clock, date }
		end,
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "",
		margin = 5,
		highlight = "TSString",
		default_color = "#FFFFFF",
		oldfiles_amount = 10,
	},

	options = {
		after = function()
			require("startup.utils").oldfiles_mappings()
		end,
		mapping_keys = true,
		cursor_column = 0.5,
		empty_lines_between_mappings = true,
		disable_statuslines = true,
		paddings = { 2, 2, 2, 2, 2, 2, 2 },
	},
	colors = {
		background = "#1f2227",
		folded_section = "#56b6c2",
	},
	parts = {
		"header",
		"header_2",
		"body",
		"body_2",
		"clock",
	},
}
return settings

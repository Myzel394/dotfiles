local builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")

local function send_to_quickfix(promtbufnr)
	telescope_actions.smart_send_to_qflist(promtbufnr)
	vim.cmd([[botright copen]])
end

require("telescope").setup({
	extensions = {
		undo = {
			use_delta = true,
			side_by_side = false,
			diff_context_lines = 10,
		},
		emoji = {
			action = function(emoji)
				-- argument emoji is a table.
				-- {name="", value="", cagegory="", description=""}

				-- insert emoji when picked
				vim.api.nvim_put({ emoji.value }, "c", false, true)
			end,
		},
		frecency = {
			ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*", "*/.venv/*" },
			db_root = vim.fn.stdpath("data") .. "/frecency",
		},
	},
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			mirror = true,
			preview_height = 0.65,
			prompt_position = "top",
		},
		mappings = {
			["n"] = {
				["<C-q>"] = send_to_quickfix,
			},
			["i"] = {
				["<C-q>"] = send_to_quickfix,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			-- Own additions
			"--trim",
		},
	},
})
-- require("telescope").load_extension("frecency")
require("telescope").load_extension("yank_history")
require("telescope").load_extension("undo")
require("telescope").load_extension("last_positions")
require("telescope").load_extension("emoji")

vim.keymap.set("n", "<leader>f", "<cmd>Telescope frecency<cr>", { desc = "Find frecent files" })
vim.keymap.set("n", "<leader>i", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>s", builtin.live_grep, { desc = "Find files with live grep" })
vim.keymap.set("n", "<leader>w", builtin.resume, { desc = "Resume your last search" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Open buffers" })
vim.keymap.set("n", "<leader>ss", builtin.grep_string, { desc = "Find files with live grep" })

vim.keymap.set("n", "<leader>cb", builtin.buffers, { desc = "Show buffers" })
vim.keymap.set("n", "<leader>ct", builtin.treesitter, { desc = "Show treesitter" })
vim.keymap.set("n", "<leader>cu", "<cmd>Telescope undo<cr>", { desc = "Show undo history" })
vim.keymap.set("n", "<leader>cl", "<cmd>Telescope last_positions<cr>", { desc = "Show last positions" })
vim.keymap.set("n", "<leader>cs", "<cmd>Telescope git_status<cr>", { desc = "Show git status" })
vim.keymap.set("n", "<leader>cb", "<cmd>Telescope git_branches<cr>", { desc = "Show git branches" })
vim.keymap.set("n", "<leader>cc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" })
vim.keymap.set("n", "<leader>cy", "<cmd>Telescope yank_history<cr>", { desc = "Show yank history" })
vim.keymap.set("n", "<leader>ce", "<cmd>Telescope emoji<cr>", { desc = "Show emoji selection" })

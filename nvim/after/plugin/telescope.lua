local builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")

local function send_to_quickfix(promtbufnr)
    print("builtin.find_files()")
    telescope_actions.smart_send_to_qflist(promtbufnr)
    vim.cmd([[botright copen]])
end

require("telescope").setup({
	extensions = {
		undo = {
			use_delta = true,
			side_by_side = false,
			diff_context_lines = 16,
		},
	},
    defaults = {
        layout_strategy = "horizontal",
        layout_config = {
            preview_width = 0.65
        },
        mappings = {
            ["n"] = {
                ["<C-q>"] = send_to_quickfix,
            },
            ["i"] = {
                ["<C-q>"] = send_to_quickfix,
            },
        },
    }
})
require("telescope").load_extension("yank_history")
require("telescope").load_extension("undo")
require("telescope").load_extension("last_positions")

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
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

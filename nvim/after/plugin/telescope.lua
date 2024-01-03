local builtin = require("telescope.builtin")

require("telescope").setup()
require("telescope").load_extension("yank_history")

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>s", builtin.live_grep, { desc = "Find files with live grep" })
vim.keymap.set("n", "<leader>ss", builtin.grep_string, { desc = "Find files with live grep" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Show buffers" })
vim.keymap.set("n", "<leader>t", builtin.treesitter, { desc = "Show treesitter" })

vim.keymap.set("n", "<leader>cs", function() vim.cmd("Telescope git_status") end, { desc = "Show git status" })
vim.keymap.set("n", "<leader>cb", function() vim.cmd("Telescope git_branches") end, { desc = "Show git branches" })
vim.keymap.set("n", "<leader>cc", function() vim.cmd("Telescope git_commits") end, { desc = "Show git commits" })

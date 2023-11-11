local builtin = require("telescope.builtin")

require("telescope").setup()
require("telescope").load_extension("yank_history")

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>s", builtin.live_grep, { desc = "Find files with live grep" })
vim.keymap.set("n", "<leader>ss", builtin.grep_string, { desc = "Find files with live grep" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Show buffers" })
vim.keymap.set("n", "<leader>t", builtin.treesitter, { desc = "Show treesitter" })

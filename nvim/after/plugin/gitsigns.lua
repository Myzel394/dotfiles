require("gitsigns").setup {}

vim.keymap.set("n", "<leader>gp", "<cmd>:Gitsigns preview_hunk_inline<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gl", "<cmd>:Gitsigns blame_line<cr>", { desc = "Blame line" })

vim.keymap.set("n", "<leader>ghn", "<cmd>:Gitsigns next_hunk<cr>", { desc = "Next hunk" })
vim.keymap.set("n", "<leader>ghp", "<cmd>:Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>ghr", "<cmd>:Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })

vim.keymap.set("n", "<leader>gsh", "<cmd>:Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gsb", "<cmd>:Gitsigns stage_buffer<cr>", { desc = "Stage buffer" })

vim.keymap.set("n", "<leader>grh", "<cmd>:Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>grb", "<cmd>:Gitsigns reset_buffer<cr>", { desc = "Reset buffer" })

require("gitsigns").setup {}

vim.keymap.set("n", "<leader>gh", "<cmd>:Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gn", "<cmd>:Gitsigns next_hunk<cr>", { desc = "Next hunk" })
vim.keymap.set("n", "<leader>gp", "<cmd>:Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>gr", "<cmd>:Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>gs", "<cmd>:Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gb", "<cmd>:Gitsigns stage_buffer<cr>", { desc = "Stage buffer" })
vim.keymap.set("n", "<leader>gu", "<cmd>:Gitsigns undo_stage_hunk<cr>", { desc = "Undo stage hunk" })
vim.keymap.set("n", "<leader>gl", "<cmd>:Gitsigns blame_line<cr>", { desc = "Blame line" })

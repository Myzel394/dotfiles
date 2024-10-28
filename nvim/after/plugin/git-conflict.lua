local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

if RUNNING_LIMITED_HARDWARE then
    return
end

vim.api.nvim_set_hl(0, "DiffText", { fg = "#ffffff", bg = "#1d3b40" })
vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#ffffff", bg = "#12401c" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#ffffff", bg = "#4f1c1c" })
vim.api.nvim_set_hl(0, "DiffChange", { fg = "#ffffff", bg = "#33324a" })

require"git-conflict".setup {
    default_mappings = false,
    highlight = {
        incoming = "DiffAdd",
        current = "DiffChange",
        ancestor = "DiffDelete",
    }
}

vim.keymap.set("n", "<leader>gcco", "<cmd>GitConflictChooseOurs<CR>", { desc = "Git Conflict: Choose ours", silent = true })
vim.keymap.set("n", "<leader>gcct", "<cmd>GitConflictChooseTheirs<CR>", { desc = "Git Conflict: Choose theirs", silent = true })
vim.keymap.set("n", "<leader>gccb", "<cmd>GitConflictChooseBoth<CR>", { desc = "Git Conflict: Choose both", silent = true })
vim.keymap.set("n", "<leader>gccn", "<cmd>GitConflictChooseNone<CR>", { desc = "Git Conflict: Choose none", silent = true })

vim.keymap.set("n", "<leader>gcn", "<cmd>GitConflictNextConflict<CR>", { desc = "Git Conflict: Jump to next Conflict", silent = true })
vim.keymap.set("n", "<leader>gcp", "<cmd>GitConflictPrevConflict<CR>", { desc = "Git Conflict: Jump to previous Conflict", silent = true })


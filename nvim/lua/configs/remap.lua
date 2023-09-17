vim.g.mapleader = " "

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Copilot
vim.keymap.set("i", "<C-j>", "copilot#Next()", {expr=true, silent=true})
vim.keymap.set("i", "<C-k>", "copilot#Previous()", {expr=true, silent=true})
vim.keymap.set("i", "<Tab>", "copilot#Accept('<CR>')", {expr=true, silent=true, noremap=true, replace_keycodes=false})


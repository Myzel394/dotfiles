require("substitute").setup({})

-- Substitute
-- Lua
vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })

vim.keymap.set("n", "<leader>s", require('substitute.range').operator, { noremap = true })
vim.keymap.set("x", "<leader>s", require('substitute.range').visual, { noremap = true })
vim.keymap.set("n", "<leader>ss", require('substitute.range').word, { noremap = true })


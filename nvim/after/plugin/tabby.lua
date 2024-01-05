require('tabby.tabline').use_preset('active_wins_at_tail', {
  nerdfont = true,              -- whether use nerdfont
})


vim.keymap.set("n", "<leader>a", ":tab split<CR>", { desc = "Create new tab", noremap = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close this tab", noremap = true })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close all other tabs", noremap = true })

for i = 1, 10 do
    vim.keymap.set("n", "<leader>" .. i, ":" .. i .. "tabnext<CR>", { desc = "Go to tab " .. i, noremap = true })
end

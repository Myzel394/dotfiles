require('tabby.tabline').use_preset('active_wins_at_tail', {
  nerdfont = true,              -- whether use nerdfont
})


vim.keymap.set("n", "<leader>a", ":tab split<CR>", { desc = "Create new tab", noremap = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close this tab", noremap = true })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close all other tabs", noremap = true })

for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, ":" .. i .. "tabnext<CR>", { desc = "Go to tab " .. i, noremap = true })
end


-- Open another tab in split
for i = 1, 9 do
    vim.keymap.set(
        "n",
        "<leader>ts" .. i,
        function()
            local win_id = vim.api.nvim_tabpage_get_win(i)
            local buf = vim.api.nvim_win_get_buf(win_id)

            vim.cmd("vert belowright sb" .. buf)
            vim.cmd("tabclose " .. i)
        end,
        { desc = "Open tab " .. i .. " in vertical split" }
    )
end

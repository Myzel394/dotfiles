vim.keymap.set(
    "n",
    "<leader>la",
    function() vim.cmd("Lspsaga code_action") end,
    { noremap = true, silent = true, desc = "Code Action (LSPSaga)" }
)
vim.keymap.set(
    "n",
    "<leader>lr",
    function() vim.cmd("Lspsaga rename") end,
    { noremap = true, silent = true, desc = "Rename (LSPSaga)" }
)
vim.keymap.set(
    "n",
    "<leader>lp",
    function() vim.cmd("Lspsaga peek_definition") end,
    { noremap = true, silent = true, desc = "Peek Definition (LSPSaga)" }
)
vim.keymap.set(
    "n",
    "<leader>lg",
    function()
        -- Run goto_definition in new tab
        vim.cmd("tabnew")
        vim.cmd("Lspsaga goto_definition")
    end,
    { noremap = true, silent = true, desc = "Go to Definition (LSPSaga)" }
)
vim.keymap.set(
    {"n", "i"},
    "<S-Space>", function() vim.cmd("Lspsaga hover_doc") end,
    { noremap = true, silent = true, desc = "Hover Doc (LSPSaga)" }
)

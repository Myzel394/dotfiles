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
    -- This function is quite hacky, if you know a better solution, please
    -- let me know
    function()
        -- Run goto_definition in new tab
        -- Get current file + path
        local buffer = vim.api.nvim_get_current_buf()
        local filepath = vim.api.nvim_buf_get_name(0)
        -- Get cursor
        local cursor = vim.api.nvim_win_get_cursor(0)

        vim.cmd("Lspsaga goto_definition")

        -- Wait for LSP to open new buffer
        vim.wait(30, function() end)

        local new_filepath = vim.api.nvim_buf_get_name(0)

        if filepath ~= new_filepath then
            local new_buffer = vim.api.nvim_get_current_buf()
            local new_cursor = vim.api.nvim_win_get_cursor(0)

            -- Set current buffer to previous file
            vim.api.nvim_set_current_buf(buffer)
            vim.api.nvim_win_set_cursor(0, cursor)

            -- Open new tab
            vim.cmd("tabnew")
            vim.api.nvim_set_current_buf(new_buffer)
            vim.api.nvim_win_set_cursor(0, new_cursor)
        end
    end,
    { noremap = true, silent = true, desc = "Go to Definition (LSPSaga)" }
)
vim.keymap.set(
    {"n", "i"},
    "<S-Space>", function() vim.cmd("Lspsaga hover_doc") end,
    { noremap = true, silent = true, desc = "Hover Doc (LSPSaga)" }
)

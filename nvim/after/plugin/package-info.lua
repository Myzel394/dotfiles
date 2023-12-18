vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "package.json",
    callback = function()
        require("package-info").setup()
    end,
})

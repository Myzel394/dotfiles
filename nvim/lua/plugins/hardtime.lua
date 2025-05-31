vim.keymap.set("n", "<Esc>", function()
  require("notify").dismiss()
end, { desc = "dismiss notify popup and clear hlsearch" })

return {
    "m4xshen/hardtime.nvim",
    lazy = false,
    opts = {
        restriction_mode = "hint",
        restricted_keys = {
            ["h"] = { "n", "x" },
            ["j"] = { "x" },
            ["k"] = { "x" },
            ["l"] = { "n", "x" },
            ["+"] = { "n", "x" },
            ["gj"] = { "n", "x" },
            ["gk"] = { "n", "x" },
            ["<C-M>"] = { "n", "x" },
            ["<C-N>"] = { "n", "x" },
            ["<C-P>"] = { "n", "x" },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            config = function()
                require("notify").setup({
                    render = "minimal",
                    stages = "slide",
                    on_open = function(win)
                        vim.api.nvim_win_set_config(win, { focusable = false })
                    end,
                })
                vim.notify = require("notify")
            end,
        }
    },
}

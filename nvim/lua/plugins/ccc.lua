local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

return {
    "uga-rosa/ccc.nvim",
    event = "BufEnter",
    enabled = not RUNNING_LIMITED_HARDWARE,
    opts = {
        highlighter = {
            auto_enable = true,
            lsp = true,
        },
    },
    keys = {
        {
            "<leader>cp",
            "<cmd>CccPick<cr>",
            desc = "Convert color",
            mode = "n",
        },
    },
}

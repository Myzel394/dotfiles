require("configs.lazynvim")
require("configs.lazy-plugins")
require("configs.remap")
require("configs.set")
require("configs.copilot-fix")
require("configs.smoothcursor")

require("leap").add_default_mappings()

vim.api.nvim_create_autocmd(
    "BufEnter",
    {
        pattern = {"*.typ"},
        command = "set filetype=typst"
    }
)

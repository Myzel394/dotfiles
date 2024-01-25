-- #232345
-- `termguicolors` needs to be set before `colorizer` is loaded
vim.opt.termguicolors = true

require "colorizer".setup {
    filetypes = { "*" },
    user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        css = true,
        css_fn = true,
        tailwind = true,
    },
    buftypes = {},
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	command = ":ColorizerAttachToBuffer",
})

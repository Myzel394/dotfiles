-- #232345
-- `termguicolors` needs to be set before `colorizer` is loaded
vim.opt.termguicolors = true

require"nvim-highlight-colors".setup {
    enable_tailwind = true,
}


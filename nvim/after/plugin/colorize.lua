-- #232345
-- `termguicolors` needs to be set before `colorizer` is loaded
vim.opt.termguicolors = true

require "colorizer".setup()

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.conf"},
  command = ":ColorizerAttachToBuffer",
})

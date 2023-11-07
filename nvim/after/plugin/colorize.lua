-- #232345
require 'colorizer'.setup()

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.conf"},
  command = ":ColorizerAttachToBuffer",
})

vim.opt.relativenumber = true
vim.opt.nu = true

vim.opt.showmatch = false
vim.opt.hlsearch = true

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.showmatch = true

vim.opt.history = 9999

-- A high number means that the cursor will be on the middle of the screen
vim.opt.scrolloff = 99999

vim.opt.updatetime = 50

-- Language
vim.opt.spelllang = "de,en"
vim.opt.spell = true

vim.o.cursorline = true
vim.o.number = true
vim.o.termguicolors = true

vim.o.conceallevel = 2

-- Neovide
vim.g.neovide_cursor_vfx_mode = "torpedo"
vim.g.neovide_cursor_animate_command_line = false

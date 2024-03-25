local tsj = require('treesj')

tsj.setup {
    use_default_keymaps = false,
    max_join_length = 9999,
}

vim.keymap.set("n", "gS", tsj.toggle, { desc = "Toggle node" })

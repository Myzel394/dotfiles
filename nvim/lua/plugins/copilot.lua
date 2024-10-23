return {
    "supermaven-inc/supermaven-nvim",
    opts = {
        keymaps = {
            accept_suggestion = "<C-o>",
        },
    },
}

-- return {
--     "zbirenbaum/copilot.lua",
--     opts = {
--         suggestion = {
--             auto_trigger = true,
--             keymap = {
--                 accept = "<C-o>",
--             }
--         },
--         panel = {
--             auto_refresh = true,
--             layout = {
--                 position = "right",
--             }
--         },
--         filetypes = {
--             yaml = true,
--             markdown = true,
--             help = false,
--             gitcommit = false,
--             gitrebase = false,
--             hgcommit = false,
--             svn = false,
--             cvs = false,
--             ["."] = false,
--         },
--     },
--     event = "BufEnter",
-- }

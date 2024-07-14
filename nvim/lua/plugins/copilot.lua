return {
    "zbirenbaum/copilot.lua",
    opts = {
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept = "<C-o>",
            }
        },
        panel = {
            auto_refresh = true,
            layout = {
                position = "right",
            }
        }
    },
    event = "BufEnter",
}

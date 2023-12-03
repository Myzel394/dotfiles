
        require("tokyonight").setup({
            style = "storm",
            light_style = "day",
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
                sidebars = "dark",
                floats = "dark",
            },
            sidebars = { "qf", "help" },
            day_brightness = 0.3,
            hide_inactive_statusline = false,
            dim_inactive = false,
            lualine_bold = false,

            on_colors = function(colors)
                colors.bg = "#18110f"
                colors.bg_dark = "#79483b"
                colors.bg_float = "#5d382d"
                colors.bg_highlight = "#5d382d"
                colors.bg_popup = "#422720"
                colors.bg_search = "#422720"
                colors.bg_sidebar = "#190f0c"
                colors.bg_statusline = "#120b09"
                colors.bg_visual = "#120b09"

                colors.cyan = "#3682c4"
                colors.green = "#3682c4"
                colors.green1 = "#3682c4"
                colors.green2 = "#3682c4"
                colors.magenta = "#3682c4"
                colors.magenta2 = "#3682c4"
                colors.orange = "#3682c4"
                colors.purple = "#3682c4"
                colors.red = "#3682c4"
                colors.red1 = "#3682c4"
                colors.teal = "#3682c4"
                colors.yellow = "#3682c4"
            end,

            on_highlights = function(highlights, colors) end,
        })
        vim.cmd[[colorscheme tokyonight]]
    
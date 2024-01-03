
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
                colors.bg = "#11171f"
                colors.bg_dark = "#2b3f4e"
                colors.bg_float = "#1c2a33"
                colors.bg_highlight = "#1c2a33"
                colors.bg_popup = "#0e1419"
                colors.bg_search = "#0e1419"
                colors.bg_sidebar = "#000000"
                colors.bg_statusline = "#000000"
                colors.bg_visual = "#000000"

                colors.cyan = "#044bc4"
                colors.green = "#044bc4"
                colors.green1 = "#044bc4"
                colors.green2 = "#044bc4"
                colors.magenta = "#044bc4"
                colors.magenta2 = "#044bc4"
                colors.orange = "#044bc4"
                colors.purple = "#044bc4"
                colors.red = "#044bc4"
                colors.red1 = "#044bc4"
                colors.teal = "#044bc4"
                colors.yellow = "#044bc4"
            end,

            on_highlights = function(highlights, colors) end,
        })
        vim.cmd[[colorscheme tokyonight]]
    
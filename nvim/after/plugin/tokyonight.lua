
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
                colors.bg = "#1a1410"
                colors.bg_dark = "#6d5948"
                colors.bg_float = "#554538"
                colors.bg_highlight = "#554538"
                colors.bg_popup = "#3c3128"
                colors.bg_search = "#3c3128"
                colors.bg_sidebar = "#17130f"
                colors.bg_statusline = "#110e0b"
                colors.bg_visual = "#110e0b"

                colors.cyan = "#b47a4a"
                colors.green = "#b47a4a"
                colors.green1 = "#b47a4a"
                colors.green2 = "#b47a4a"
                colors.magenta = "#b47a4a"
                colors.magenta2 = "#b47a4a"
                colors.orange = "#b47a4a"
                colors.purple = "#b47a4a"
                colors.red = "#b47a4a"
                colors.red1 = "#b47a4a"
                colors.teal = "#b47a4a"
                colors.yellow = "#b47a4a"
            end,

            on_highlights = function(highlights, colors) end,
        })
        vim.cmd[[colorscheme tokyonight]]
    
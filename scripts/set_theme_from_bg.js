const path = require("path");
const fs = require("fs");
const os = require("os");
const tinyColor = require("tinycolor2");
const Vibrant = require("node-vibrant");

/***
 * @param {Palette} colors
 * @returns {string}
 */
function createKittyTheme(colors) {
    const primary = tinyColor(colors.Muted.getHex());
    const secondary = tinyColor(colors.Vibrant.getHex());

    const bgColor = tinyColor(colors.DarkMuted.getHex()).darken(20);

    return {
        background: (() => {
            if (bgColor.getBrightness() <= 15) {
                return bgColor.lighten(5);
            }

            if (bgColor.getBrightness() >= 70) {
                return bgColor.darken(20);
            }

            if (bgColor.getBrightness() >= 50) {
                return bgColor.darken(10);
            }

            return bgColor;
        })().toHexString(),
        foreground: colors.LightMuted.getHex(),
        // first command color
        color2: primary.toHexString(),
        color3: primary.lighten(10).toHexString(),
        color4: secondary.darken(10).toHexString(),
        color5: secondary.darken(13).toHexString(),
        color6: secondary.toHexString(),
        color7: secondary.lighten(10).toHexString(),
        // preview color
        color8: (() => {
            // Make sure it's not too dark

            if (secondary.getBrightness() >= 60) {
                return secondary.darken(10);
            }

            if (secondary.getBrightness() <= 20) {
                return secondary.lighten(10);
            }

            return secondary;
        })().toHexString(),
        color9: primary.lighten(20).toHexString(),
        color10: primary.lighten(25).toHexString(),
        color11: secondary.lighten(15).toHexString(),
        color12: secondary.lighten(18).toHexString(),
        color13: secondary.lighten(21).toHexString(),
        color14: secondary.lighten(24).toHexString(),
        color15: secondary.lighten(30).toHexString(),
        cursor: primary,
    };
}

function createNvimTheme(colors) {
    const primary = tinyColor(colors.Muted.getHex());
    const secondary = tinyColor(colors.Vibrant.getHex());

    const background = tinyColor(colors.DarkMuted.getHex()).darken(20);

    const fullBackground = (() => {
            if (background.getBrightness() <= 15) {
                return background.lighten(5);
            }

            if (background.getBrightness() >= 70) {
                return background.darken(20);
            }

            if (background.getBrightness() >= 50) {
                return background.darken(10);
            }

            return background;
        })().toHexString()

    return `
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
                colors.bg = "${fullBackground}"
                colors.bg_dark = "${primary.darken(14).toHexString()}"
                colors.bg_float = "${primary.darken(8).toHexString()}"
                colors.bg_highlight = "${primary.toHexString()}"
                colors.bg_popup = "${primary.darken(8).toHexString()}"
                colors.bg_search = "${primary.toHexString()}"
                colors.bg_sidebar = "${primary.darken(12).toHexString()}"
                colors.bg_statusline = "${primary.darken(2).toHexString()}"
                colors.bg_visual = "${primary.toHexString()}"

                colors.cyan = "${secondary.toHexString()}"
                colors.green = "${secondary.toHexString()}"
                colors.green1 = "${secondary.toHexString()}"
                colors.green2 = "${secondary.toHexString()}"
                colors.magenta = "${secondary.toHexString()}"
                colors.magenta2 = "${secondary.toHexString()}"
                colors.orange = "${secondary.toHexString()}"
                colors.purple = "${secondary.toHexString()}"
                colors.red = "${secondary.toHexString()}"
                colors.red1 = "${secondary.toHexString()}"
                colors.teal = "${secondary.toHexString()}"
                colors.yellow = "${secondary.toHexString()}"
            end,

            on_highlights = function(highlights, colors) end,
        })
        vim.cmd[[colorscheme tokyonight]]
    `
}

async function main() {
    const imagePath = process.argv[2];

    const colors = await Vibrant.from(imagePath).getPalette();

    {
        const theme = createKittyTheme(colors);

        const themePath = path.resolve(
            os.homedir(),
            ".config",
            "kitty",
            "bg_image_theme.conf",
        );

        fs.writeFileSync(
            themePath,
            Object.entries(theme)
                .map(([key, value]) => `${key} ${value}`)
                .join("\n"),
        );
    };

    // {
    //     const theme = createNvimTheme(colors);
    //
    //     const themePath = path.resolve(
    //         os.homedir(),
    //         ".config",
    //         "nvim",
    //         "after",
    //         "plugin",
    //         "tokyonight.lua",
    //     );
    //
    //     fs.writeFileSync(
    //         themePath,
    //         theme,
    //     );
    // };
}

main();

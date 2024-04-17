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

            if (bgColor.getBrightness() >= 30) {
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
    })().toHexString();

    return `
    require("catppuccin").setup({
        integrations = {
            gitsigns = true,
            leap = true,
            indent_blankline = {
                enabled = true,
                scope_color = "lavender",
                colored_indent_levels = true,
            },
            neotree = true,
            treesitter = true,
            rainbow_delimiters = true,
            telescope = {
                enabled = true,
            },
            lsp_trouble = true,
            which_key = true,
        },
        color_overrides = {
            mocha = {
                text = "${primary.toHexString()}",
                subtext1 = "${primary.darken(10).toHexString()}",
                subtext0 = "${primary.darken(20).toHexString()}",
                overlay2 = "${primary.darken(13).toHexString()}",
                overlay1 = "${primary.darken(10).toHexString()}",
                overlay0 = "${primary.toHexString()}",
                surface2 = "${primary.lighten(10).toHexString()}",
                surface1 = "${primary.lighten(15).toHexString()}",
                surface0 = "${primary.lighten(20).toHexString()}",

                base = "${primary.toHexString()}",
                mantle = "#1a1016",
                crust = "#0d080b",
            },
        },
    })

    vim.cmd.colorscheme("catppuccin")
    `;
}

function createTmuxTheme(colors) {
    const primary = tinyColor(colors.Muted.getHex());
    const vibrant = tinyColor(colors.Vibrant.getHex());

    return `
set -g @catppuccin_window_default_color "${primary
            .clone()
            .darken(20)
            .toHexString()}" # text color
set -g @catppuccin_window_default_background "${primary
            .clone()
            .darken(35)
            .toHexString()}"

set -g @catppuccin_window_current_color "${primary
            .clone()
            .toHexString()}" # text color
set -g @catppuccin_window_current_background "${primary
            .clone()
            .darken(15)
            .toHexString()}"

# In order
set -g @catppuccin_application_color "${primary
            .clone()
            .darken(10)
            .toHexString()}"
set -g @catppuccin_session_color "${primary.clone().toHexString()}"
set -g @catppuccin_kripto_color "${primary.clone().lighten(10).toHexString()}"
    `;
}

function createBtopTheme(colors) {
    const primary = tinyColor(colors.Muted.getHex());
    const secondary = tinyColor(colors.Vibrant.getHex());

    return `
# Main background, empty for terminal default, need to be empty if you want transparent background
theme[main_bg]="${primary.clone().darken(35).toHexString()}"

# Main text color
theme[main_fg]="${primary.clone().lighten(10).toHexString()}"

# Title color for boxes
theme[title]="${primary.clone().toHexString()}"

# Color of inactive/disabled text
theme[inactive_fg]="${primary.clone().darken(10).desaturate(20).toHexString()}"

# Color of text appearing on top of graphs, i.e uptime and current network graph scaling
theme[graph_text]="${primary.clone().toHexString()}"

# Misc colors for processes box including mini cpu graphs, details memory graph and details status text
theme[proc_misc]="${primary.clone().toHexString()}"

# Cpu box outline color
theme[cpu_box]="#a89984"

# Memory/disks box outline color
theme[mem_box]="#a89984"

# Net up/down box outline color
theme[net_box]="#a89984"

# Processes box outline color
theme[proc_box]="#a89984"

# Box divider line and small boxes line color
theme[div_line]="#a89984"

# Temperature graph colors
theme[temp_start]="#458588"
theme[temp_mid]="#d3869b"
theme[temp_end]="#fb4394"

# CPU graph colors
theme[cpu_start]="#b8bb26"
theme[cpu_mid]="#d79921"
theme[cpu_end]="#fb4934"

# Mem/Disk free meter
theme[free_start]="#4e5900"
theme[free_mid]=""
theme[free_end]="#98971a"

# Mem/Disk cached meter
theme[cached_start]="#458588"
theme[cached_mid]=""
theme[cached_end]="#83a598"

# Mem/Disk available meter
theme[available_start]="#d79921"
theme[available_mid]=""
theme[available_end]="#fabd2f"

# Mem/Disk used meter
theme[used_start]="#cc241d"
theme[used_mid]=""
theme[used_end]="#fb4934"

# Download graph colors
theme[download_start]="#3d4070"
theme[download_mid]="#6c71c4"
theme[download_end]="#a3a8f7"

# Upload graph colors
theme[upload_start]="#701c45"
theme[upload_mid]="#b16286"
theme[upload_end]="#d3869b"
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
    }

    {
        const theme = createTmuxTheme(colors);

        const colorsPath = path.resolve(
            os.homedir(),
            ".config",
            "tmux",
            "colors.conf",
        );

        fs.writeFileSync(colorsPath, theme);
    }

    // {
    //   const theme = createNvimTheme(colors);
    //
    //   const themePath = path.resolve(
    //     os.homedir(),
    //     ".config",
    //     "nvim",
    //     "after",
    //     "plugin",
    //     "theme.lua",
    //   );
    //
    //   fs.writeFileSync(themePath, theme);
    // }
}

main();

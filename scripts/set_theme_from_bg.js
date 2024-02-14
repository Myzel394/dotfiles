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
    .darken(5)
    .clone()
    .toHexString()}" # text color
set -g @catppuccin_window_current_background "${primary
    .clone()
    .darken(20)
    .toHexString()}"
    `;
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

const path = require("path");
const fs = require("fs");
const os = require("os");
const tinyColor = require("tinycolor2");
const Vibrant = require("node-vibrant");

/***
 * @param {Palette} colors
 * @returns {string}
 */
function createTheme(colors) {
  const primary = tinyColor(colors.Muted.getHex());
  const secondary = tinyColor(colors.Vibrant.getHex());

  const bgColor = tinyColor(colors.DarkMuted.getHex()).darken(20);

  return {
    background: (() => {
        if (bgColor.getBrightness() <= 20) {
            return bgColor.lighten(5);
        }

        if (bgColor.getBrightness() >= 50) {
            return bgColor.darken(10);
        }

        return bgColor;
    })().toHexString(),
    foreground: colors.LightMuted.getHex(),
    color2: primary.toHexString(),
    color3: primary.lighten(10).toHexString(),
    color4: secondary.darken(10).toHexString(),
    color5: secondary.darken(13).toHexString(),
    color6: secondary.toHexString(),
    color7: secondary.lighten(10).toHexString(),
    color8: secondary.darken(15).toHexString(),
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

async function main() {
  const imagePath = process.argv[2];

  const colors = await Vibrant.from(imagePath).getPalette();

  const theme = createTheme(colors);

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

main();

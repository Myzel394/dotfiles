local IS_RUNNING_ON_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

if IS_RUNNING_ON_LIMITED_HARDWARE then
    return
end

require"tint".setup {
    tint = -25,  -- Darken colors, use a positive value to brighten
    saturation = 0.3,  -- Saturation to preserve
    transforms = require"tint".transforms.SATURATE_TINT,
    tint_background_colors = true,  -- Tint background portions of highlight groups
    highlight_ignore_patterns = {
        "WinSeparator",
        "Status.*",
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
        "IblIndent",
        "IblScope",
        "IblWhitespace",
    },  -- Highlight group patterns to ignore, see `string.find`
    window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")

        return buftype == "terminal"
    end
}

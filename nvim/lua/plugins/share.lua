local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

return {
    "azratul/live-share.nvim",
    enabled = not RUNNING_LIMITED_HARDWARE,
    dependencies = {
        "jbyuki/instant.nvim",
    },
    opts = {
        port_internal = tonumber(os.getenv("NVIM_SHARE_PORT")),
        max_attempts = 40 -- 10 seconds
    },
}

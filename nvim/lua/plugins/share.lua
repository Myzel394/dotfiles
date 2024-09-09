return {
    "azratul/live-share.nvim",
    dependencies = {
        "jbyuki/instant.nvim",
    },
    opts = {
        port_internal = tonumber(os.getenv("NVIM_SHARE_PORT")),
        max_attempts = 40 -- 10 seconds
    },
}

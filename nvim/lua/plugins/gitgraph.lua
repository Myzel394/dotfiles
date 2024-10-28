local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

return {
    'isakbm/gitgraph.nvim',
    enabled = not RUNNING_LIMITED_HARDWARE,
    ---@type I.GGConfig
    opts = {
        symbols = {
            merge_commit = 'M',
            commit = '*',
        },
        format = {
            timestamp = '%H:%M:%S %d-%m-%Y',
            fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
        },
        hooks = {
            on_select_commit = function(commit)
                print('selected commit:', commit.hash)
            end,
            on_select_range_commit = function(from, to)
                print('selected range:', from.hash, to.hash)
            end,
        },
    },
    keys = {
        {
            "<leader>gg",
            function()
                require('gitgraph').draw({}, { all = true, max_count = 5000 })
            end,
            desc = "GitGraph - Draw",
        },
    },
}

local is_restoring = false

require("auto-session").setup {
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_use_git_branch = true,
    post_restore_cmds = {
        function()
            is_restoring = true
        end
    }
}

-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         if not is_restoring then
--             vim.cmd("Neotree reveal current")
--         end
--     end,
-- })

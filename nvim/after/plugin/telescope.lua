local builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")

local function send_to_quickfix(promtbufnr)
    telescope_actions.smart_send_to_qflist(promtbufnr)
    vim.cmd([[botright copen]])
end

require("telescope").setup({
    extensions = {
        undo = {
            use_delta = true,
            side_by_side = false,
            diff_context_lines = 10,
        },
        emoji = {
            action = function(emoji)
                -- argument emoji is a table.
                -- {name="", value="", cagegory="", description=""}

                -- insert emoji when picked
                vim.api.nvim_put({ emoji.value }, "c", false, true)
            end,
        },
        frecency = {
            ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*", "*/.venv/*" },
            db_root = vim.fn.stdpath("data") .. "/frecency",
        },
    },
    defaults = {
        layout_strategy = "vertical",
        layout_config = {
            mirror = true,
            preview_height = 0.65,
            prompt_position = "top",
        },
        mappings = {
            ["n"] = {
                ["<C-q>"] = send_to_quickfix,
            },
            ["i"] = {
                ["<C-q>"] = send_to_quickfix,
            },
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            -- Own additions
            "--trim",
        },
    },
})
-- require("telescope").load_extension("frecency")
require("telescope").load_extension("yank_history")
require("telescope").load_extension("undo")
require("telescope").load_extension("last_positions")
require("telescope").load_extension("emoji")

vim.keymap.set("n", "<leader>f", "<cmd>Telescope frecency<cr>", { desc = "Find frecent files" })
vim.keymap.set("n", "<leader>i", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>s", builtin.live_grep, { desc = "Find files with live grep" })
vim.keymap.set("n", "<leader>w", builtin.resume, { desc = "Resume your last search" })

vim.keymap.set("n", "<leader>cb", builtin.buffers, { desc = "Show buffers" })
vim.keymap.set("n", "<leader>ct", builtin.treesitter, { desc = "Show treesitter" })
vim.keymap.set("n", "<leader>cu", "<cmd>Telescope undo<cr>", { desc = "Show undo history" })
vim.keymap.set("n", "<leader>cl", "<cmd>Telescope last_positions<cr>", { desc = "Show last positions" })
vim.keymap.set("n", "<leader>cs", "<cmd>Telescope git_status<cr>", { desc = "Show git status" })
vim.keymap.set("n", "<leader>cb", "<cmd>Telescope git_branches<cr>", { desc = "Show git branches" })
vim.keymap.set("n", "<leader>cc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" })
vim.keymap.set("n", "<leader>cy", "<cmd>Telescope yank_history<cr>", { desc = "Show yank history" })
vim.keymap.set("n", "<leader>ce", "<cmd>Telescope emoji<cr>", { desc = "Show emoji selection" })

local function get_visible_buffers()
    return vim.tbl_filter(function(bufnr)
        if 1 ~= vim.fn.buflisted(bufnr) then
            return false
        end

        if not vim.api.nvim_buf_is_loaded(bufnr) then
            return false
        end

        return true
    end, vim.api.nvim_list_bufs())
end


vim.keymap.set(
    "n",
    "<leader>bsr",
    function()
        local available_bufs = get_visible_buffers()
        local current_buf = vim.api.nvim_get_current_buf()

        local right_buf = nil

        for i, bufnr in ipairs(available_bufs) do
            if bufnr == current_buf then
                right_buf = available_bufs[i + 1]
                break
            end
        end

        if right_buf then
            vim.cmd("vert belowright sb " .. right_buf)
        end
    end,
    { desc = "Split right buffer vertically" }
)
vim.keymap.set(
    "n",
    "<leader>bsl",
    function()
        local available_bufs = get_visible_buffers()
        local current_buf = vim.api.nvim_get_current_buf()

        local left_buf = nil

        for i, bufnr in ipairs(available_bufs) do
            if bufnr == current_buf then
                left_buf = available_bufs[i - 1]
                break
            end
        end

        if left_buf then
            vim.cmd("vert belowright sb " .. left_buf)
        end
    end,
    { desc = "Split left buffer vertically" }
)

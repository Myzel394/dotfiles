local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        {
            "Myzel394/telescope-last-positions",
            enabled = not RUNNING_LIMITED_HARDWARE,
        },
        "Myzel394/jsonfly.nvim",
        {
            "xiyaowong/telescope-emoji.nvim",
            enabled = not RUNNING_LIMITED_HARDWARE,
        },
    },
    keys = {
        {
            "<leader>o",
            "<cmd>Telescope jsonfly<cr>",
            desc = "Open json(fly)",
            ft = { "json", "yaml" },
            mode = "n",
        },
        {
            "<leader>f",
            "<cmd>Telescope frecency workspace=CWD<cr>",
            desc = "Find frecent files",
            mode = "n",
        },
        {
            "<leader>j",
            "<cmd>Telescope jsonfly<cr>",
            desc = "Open jsonfly",
            ft = { "json" },
            mode = "n",
        }
    },
    config = function()
        local builtin = require("telescope.builtin")
        local telescope_actions = require("telescope.actions")
        local telescope = require("telescope")
        local previewers = require('telescope.previewers')

        local function send_to_quickfix(promtbufnr)
            telescope_actions.smart_send_to_qflist(promtbufnr)
            vim.cmd([[botright copen]])
        end

        telescope.setup({
            extensions = {
                undo = {
                    use_delta = true,
                    side_by_side = true,
                    diff_context_lines = 10,
                    layout_strategy = "vertical",
                    layout_config = {
                        mirror = true,
                        preview_height = 0.8,
                        prompt_position = "top",
                    },
                    mappings = {
                        n = {
                            ["<leader>ua"] = require("telescope-undo.actions").yank_additions,
                            ["<leader>ud"] = require("telescope-undo.actions").yank_deletions,
                            ["<leader>ur"] = require("telescope-undo.actions").restore,
                        },
                    },
                },
                emoji = {
                    action = function(emoji)
                        -- argument emoji is a table.
                        -- {name="", value="", cagegory="", description=""}

                        -- insert emoji when picked
                        vim.api.nvim_put({ emoji.value }, "c", false, true)
                    end,
                },
                -- frecency = {
                --     ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*", "*/.venv/*" },
                --     db_root = vim.fn.stdpath("data") .. "/frecency",
                --     layout_strategy = "vertical",
                --     layout_config = {
                --         mirror = true,
                --         prompt_position = "top",
                --     },
                -- },
                jsonfly = {
                    layout_strategy = "horizontal",
                    prompt_position = "top",
                    layout_config = {
                        mirror = false,
                        prompt_position = "top",
                        preview_width = 0.45,
                        preview_height = nil,
                    },
                },
            },
            pickers = {
                live_grep = {
                    layout_strategy = "vertical",
                    layout_config = {
                        mirror = true,
                        preview_height = 0.7,
                        prompt_position = "top",
                    },
                },
                find_files = {
                    layout_strategy = "vertical",
                    layout_config = {
                        mirror = true,
                        prompt_position = "top",
                    },
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--glob",
                        "!**/{node_modules,.git}/*",
                        "--sortr=path",
                    },
                },
                git_status = {
                    layout_config = {
                        preview_width = 0.6,
                    },
                },
            },
            defaults = {
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
                    "--sortr=path",
                },
            },
        })
        -- require("telescope").load_extension("frecency")
        telescope.load_extension("yank_history")
        telescope.load_extension("undo")
        telescope.load_extension("jsonfly")

        if not RUNNING_LIMITED_HARDWARE then
            telescope.load_extension("last_positions")
            telescope.load_extension("emoji")
        end

        local delta = previewers.new_termopen_previewer {
            get_command = function(entry)
                -- this is for status
                -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
                -- just do an if and return a different command
                if entry.status == '??' or 'A ' then
                    return {'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.path}
                end

                -- note we can't use pipes
                -- this command is for git_commits and git_bcommits
                return {'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.path .. '^!'}

            end
        }
        local function delta_git_status(opts)
            opts = opts or {}
            opts.previewer = delta

            builtin.git_status(opts)
        end

        -- vim.keymap.set("n", "<leader>f", "<cmd>Telescope frecency<cr>", { desc = "Find frecent files" })
        vim.keymap.set("n", "<leader>i", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>s", builtin.live_grep, { desc = "Find files with live grep" })
        vim.keymap.set("n", "<leader>w", builtin.resume, { desc = "Resume your last search" })

        vim.keymap.set("n", "<leader>cb", builtin.buffers, { desc = "Show buffers" })
        vim.keymap.set("n", "<leader>ct", builtin.treesitter, { desc = "Show treesitter" })
        vim.keymap.set("n", "<leader>cu", "<cmd>Telescope undo<cr>", { desc = "Show undo history" })
        vim.keymap.set("n", "<leader>cl", "<cmd>Telescope last_positions<cr>", { desc = "Show last positions" })
        vim.keymap.set("n", "<leader>cb", "<cmd>Telescope git_branches<cr>", { desc = "Show git branches" })
        vim.keymap.set("n", "<leader>cc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" })
        vim.keymap.set("n", "<leader>cy", "<cmd>Telescope yank_history<cr>", { desc = "Show yank history" })
        vim.keymap.set("n", "<leader>ce", "<cmd>Telescope emoji<cr>", { desc = "Show emoji selection" })
        vim.keymap.set("n", "<leader>cs", delta_git_status, { desc = "Show git status" })

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
    end
}

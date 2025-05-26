-- Required by lazy.nvim to be set before loading plugins
vim.g.mapleader = " "

local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

-- Create new highlight group called VisualWhitespace with `Visual` as bg and `comment` fg
vim.cmd("highlight VisualWhitespace guifg=#5F5F60 guibg=#404041 gui=bold")

require("lazy").setup({
    { import = "plugins" },
    {
        "Myzel394/jsonfly",
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = not RUNNING_LIMITED_HARDWARE,
        branch = "canary",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "ibhagwan/fzf-lua",
        },
        opts = {
        },
        keys = {
            {
                "<leader>cgc",
                "<cmd>CopilotChat<cr>",
                desc = "Open CopilotChat",
                mode = "n",
            },
            {
                "<leader>cgp",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - Prompt actions",
                mode = "n",
            },
            {
                "<leader>cgh",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.fzflua").pick(actions.help_actions())
                end,
                desc = "CopilotChat - Help actions",
                mode = "n",
            },
        }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            {
                "s1n7ax/nvim-window-picker",
                version = "2.*",
            },
        },
    },
    "lewis6991/gitsigns.nvim",
    {
        "ggandor/leap.nvim",
        dependencies = {
            "tpope/vim-repeat",
            -- ca
            "catppuccin/nvim",
        },
        event = "BufEnter",
        keys = { "s", "S", "gs" },
    },
    {
        "windwp/nvim-ts-autotag",
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "gbprod/yanky.nvim",
        opts = {
            ring = {
                -- I'm using yankbank for history
                history_length = 0,
            }
        }
    },
    {
        "numToStr/Comment.nvim",
        lazy = true,
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                opts = {
                    enable_autocmd = false,
                },
            }
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "VeryLazy",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 150
        end,
        opts = {},
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    ----- LSP -----
    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-context",
                enabled = not RUNNING_LIMITED_HARDWARE,
                opts = {
                    max_lines = 3,
                },
            },
        }
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "SergioRibera/cmp-dotenv",
                enabled = not RUNNING_LIMITED_HARDWARE,
            },
            "hrsh7th/cmp-nvim-lsp",
            "https://codeberg.org/FelipeLema/cmp-async-path",
            -- "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
            {
                "kdheepak/cmp-latex-symbols",
                enabled = not RUNNING_LIMITED_HARDWARE,
            },
            {
                "roobert/tailwindcss-colorizer-cmp.nvim",
                enabled = not RUNNING_LIMITED_HARDWARE,
            },
            -- "lukas-reineke/cmp-rg"
        },
    },
    {
        "uga-rosa/ccc.nvim",
        event = "BufEnter",
        enabled = not RUNNING_LIMITED_HARDWARE,
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
        },
        keys = {
            {
                "<leader>cc",
                "<cmd>CccPick<cr>",
                desc = "Convert color",
                mode = "n",
            },
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
    },
    {
        "sveltejs/language-tools",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        ft = { "svelte" },
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "ray-x/lsp_signature.nvim",
        enabled = not RUNNING_LIMITED_HARDWARE,
        opts = {
            always_trigger = true,
            hint_enable = true,
            hint_prefix = " ",
            toggle_key = "<C-k>",
        },
    },



    {
        "petertriho/nvim-scrollbar",
        dependencies = {
            {
                "kevinhwang91/nvim-hlslens",
                opts = {},
            }
        },
    },
    "tiagovla/scope.nvim",
    "akinsho/bufferline.nvim",
    -- {
    --     "gsuuon/model.nvim",
    --     cmd = { "M", "Model", "Mchat" },
    --     ft = "mchat",
    -- },
    "mawkler/modicator.nvim",
    {
        "xiyaowong/nvim-cursorword",
        event = "BufEnter",
    },
    "tzachar/highlight-undo.nvim",
    "jinh0/eyeliner.nvim",
    {
        "jackMort/ChatGPT.nvim",
        enabled = not RUNNING_LIMITED_HARDWARE,
        event = "BufEnter",
    },
    "akinsho/git-conflict.nvim",
    {
        "kevinhwang91/nvim-fundo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
    },
    "lewis6991/hover.nvim",
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        ft = { "markdown", "orgmode", "neorg" },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    "rmagatti/auto-session",
    "tyetye/cursor_yank_sit_stay.nvim",
    "Wansmer/treesj",
    {
        -- Lazy loading not required as it's automatically lazy loading by default
        "vuki656/package-info.nvim",
    },
    {
        "mcauley-penney/visual-whitespace.nvim",
        config = true,
        enabled = not RUNNING_LIMITED_HARDWARE and false,
        opts = {
            highlight = { link = "VisualWhitespace" },
        },
    },
    {
        "dhruvasagar/vim-table-mode",
        ft = { "markdown" },
        lazy = true,
    },
    -- Extra
    {
        "Myzel394/easytables.nvim",
        lazy = true,
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "pteroctopus/faster.nvim",
        opts = {},
    },
    {
        "gen740/SmoothCursor.nvim",
        lazy = true,
        event = "VeryLazy",
    },
    {
        "phelipetls/jsonpath.nvim",
        event = "VeryLazy",
        lazy = true,
        setup = {
            vim.keymap.set(
                "n",
                "<leader>y",
                function() vim.fn.setreg("+", require("jsonpath").get()) end,
                { desc = "Copy JSON path", buffer = true }
            )
        }
    },
    {
        "iamcco/markdown-preview.nvim",
        enabled = not RUNNING_LIMITED_HARDWARE,
        ft = { "markdown", "text" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        lazy = true,
    },
    {
        "yorickpeterse/nvim-tree-pairs",
        lazy = true,
        enabled = not RUNNING_LIMITED_HARDWARE,
        event = "VeryLazy",
        opts = {},
    },
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     ft = { "markdown", "text" },
    --     build = function()
    --         vim.fn["mkdp#util#install"]()
    --     end,
    --     lazy = true,
    --     enabled = not RUNNING_LIMITED_HARDWARE,
    -- },
    {
        "rust-lang/rust.vim",
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    -- {
    --     "fabridamicelli/cronex.nvim",
    --      opts = {},
    --      enabled = not RUNNING_LIMITED_HARDWARE,
    -- },
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        enabled = not RUNNING_LIMITED_HARDWARE,
        config = function()
            require("crates").setup()
        end,
    },
    -- {
    --     "stevearc/conform.nvim",
    --     enabled = not RUNNING_LIMITED_HARDWARE and false,
    -- },
    {
        "https://tpope.io/vim/fugitive.git",
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "levouh/tint.nvim",
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "michaelrommel/nvim-silicon",
        enabled = not RUNNING_LIMITED_HARDWARE,
        lazy = true,
        cmd = "Silicon",
        config = function()
            require("silicon").setup {
                -- font = "JetBrainsMono Nerd Font Mono=24",
                background = "#0E1117",
                theme = "TwoDark",
                pad_horiz = 40,
                pad_vert = 50,
                shadow_color = "#161B22",
                to_clipboard = true,
                no_window_controls = true,
                output = function()
                    return "/tmp/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
                end,
                window_title = function()
                    return vim.fn.fnamemodify(
                        vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
                        ":t"
                    )
                end,
            }
        end,
    },
    {
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        enabled = not RUNNING_LIMITED_HARDWARE,
        config = function()
            require("go").setup()
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
}, {
    dev = {
        path = "~/CodeProjects"
    },
})

-- Required by lazy.nvim to be set before loading plugins
vim.g.mapleader = " "

local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

-- Create new highlight group called VisualWhitespace with `Visual` as bg and `comment` fg
vim.cmd("highlight VisualWhitespace guifg=#5F5F60 guibg=#404041 gui=bold")

require("lazy").setup({
    {
        "Myzel394/jsonfly",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
            "Myzel394/telescope-last-positions",
            --"nvim-telescope/telescope-frecency.nvim",
            "xiyaowong/telescope-emoji.nvim",
        },
        keys = {
            {
                "<leader>o",
                "<cmd>Telescope jsonfly<cr>",
                desc = "Open json(fly)",
                ft = { "json", "yaml" },
                mode = "n"
            },
        }
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    "github/copilot.vim",
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            "github/copilot.vim",
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
    "rstacruz/vim-closer",
    {
        "ggandor/leap.nvim",
        dependencies = {
            "tpope/vim-repeat",
        },
        keys = { "s", "S", "gs" },
    },
    "windwp/nvim-ts-autotag",
    "gbprod/yanky.nvim",
    {
        "numToStr/Comment.nvim",
        lazy = true,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        lazy = true,
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
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    -- },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        dependencies = {
            "SergioRibera/cmp-dotenv",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-calc",
            "https://codeberg.org/FelipeLema/cmp-async-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
            "kdheepak/cmp-latex-symbols",
            "uga-rosa/cmp-dictionary",
            "roobert/tailwindcss-colorizer-cmp.nvim",
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
        "petertriho/nvim-scrollbar",
        dependencies = {
            "kevinhwang91/nvim-hlslens",
        },
    },
    "tiagovla/scope.nvim",
    "akinsho/bufferline.nvim",
    "nvimdev/galaxyline.nvim",
    -- {
    --     "gsuuon/model.nvim",
    --     cmd = { "M", "Model", "Mchat" },
    --     ft = "mchat",
    -- },
    "mawkler/modicator.nvim",
    "xiyaowong/nvim-cursorword",
    "tzachar/highlight-undo.nvim",
    "jinh0/eyeliner.nvim",
    {
        "jackMort/ChatGPT.nvim",
        enabled = not RUNNING_LIMITED_HARDWARE,
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
        enabled = not RUNNING_LIMITED_HARDWARE,
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
        "yorickpeterse/nvim-tree-pairs",
        lazy = true,
        event = "VeryLazy",
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown", "text" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        lazy = true,
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "rust-lang/rust.vim",
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "fabridamicelli/cronex.nvim",
         opts = {},
         enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        enabled = not RUNNING_LIMITED_HARDWARE,
        config = function()
            require("crates").setup()
        end,
    },
    {
        "stevearc/conform.nvim",
        enabled = not RUNNING_LIMITED_HARDWARE and false,
    },
    {
        "https://tpope.io/vim/fugitive.git",
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    {
        "levouh/tint.nvim",
        enabled = not RUNNING_LIMITED_HARDWARE,
    },
    "folke/neodev.nvim",
    {
        "michaelrommel/nvim-silicon",
        enabled = not RUNNING_LIMITED_HARDWARE,
        lazy = true,
        cmd = "Silicon",
        config = function()
            require("silicon").setup {
                font = "JetBrainsMono Nerd Font=24",
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
    -- {
    --     "vim-crystal/vim-crystal",
    --     enabled = not RUNNING_LIMITED_HARDWARE,
    -- }
}, {
    dev = {
        path = "~/CodeProjects"
    },
})

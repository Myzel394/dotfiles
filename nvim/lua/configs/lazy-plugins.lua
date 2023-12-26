-- Required by lazy.nvim to be set before loading plugins
vim.g.mapleader = " "

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    "mbbill/undotree",
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    "norcalli/nvim-colorizer.lua",
    "github/copilot.vim",
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
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
        }
    },
    "windwp/nvim-ts-autotag",
    "ThePrimeagen/harpoon",
    "gen740/SmoothCursor.nvim",
    "Myzel394/easytables.nvim",
    {
        "startup-nvim/startup.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "MaximilianLloyd/ascii.nvim",
        },
    },
    "numToStr/Comment.nvim",
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        event = "VeryLazy",
    },
    "gbprod/yanky.nvim",
    "rust-lang/rust.vim",
    "xiyaowong/transparent.nvim",
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            require("lspsaga").setup({})
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        lazy = true,
        event = "VeryLazy",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 150
        end,
        opts = {}
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    ----- LSP -----
    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        }
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
            "kdheepak/cmp-latex-symbols",
            "uga-rosa/cmp-dictionary",
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
    },
    {
        "lervag/vimtex",
        ft = { "tex", "plaintex", "markdown" },
        config = function()
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_compiler_engine = "lualatex"
            vim.g.maplocalleader = ","
        end,
        enabled = false,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "petertriho/nvim-scrollbar",
        dependencies = {
            "kevinhwang91/nvim-hlslens",
        }
    },
    "vuki656/package-info.nvim",
    "nanozuki/tabby.nvim",
    {
        "nvimdev/galaxyline.nvim",
    },
    {
        "gsuuon/model.nvim",
        cmd = { "M", "Model", "Mchat" },
        ft = "mchat",
    }
})

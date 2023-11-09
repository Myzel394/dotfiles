-- Required by lazy.nvim to be set before loading plugins
vim.g.mapleader = " "

require("lazy").setup({
    "ThePrimeagen/harpoon",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    "vim-airline/vim-airline",
    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    },
    "mbbill/undotree",
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
        }
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    "jayp0521/mason-null-ls.nvim",
    "tyrannicaltoucan/vim-deep-space",
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    --"nvim-tree/nvim-web-devicons",
    "norcalli/nvim-colorizer.lua",
    "github/copilot.vim",
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
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
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    "hrsh7th/nvim-cmp",
    "saadparwaiz1/cmp_luasnip",
    {
        "startup-nvim/startup.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "MaximilianLloyd/ascii.nvim",
        },
    },
    "numToStr/Comment.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "gbprod/yanky.nvim",
})

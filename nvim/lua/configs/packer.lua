vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        "nvim-telescope/telescope.nvim", tag = '0.1.3',
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use "vim-airline/vim-airline"

    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    }

    use "mbbill/undotree"

    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
        }
    }


    use {
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    }
    use "jayp0521/mason-null-ls.nvim"

    use "tyrannicaltoucan/vim-deep-space"

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use 'nvim-tree/nvim-web-devicons'
    use 'NvChad/nvim-colorizer.lua'


    use "github/copilot.vim"
    use({
        "jackMort/ChatGPT.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    })

    use({
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {
                enabled = false,
            }
        end,
    })

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                's1n7ax/nvim-window-picker',
                version = '2.*',
            },
        },
    }

    use "lewis6991/gitsigns.nvim"

    use "rstacruz/vim-closer"

    use({
        "ggandor/leap.nvim",
        requires = {
            "tpope/vim-repeat",
        }
    })

    use({
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    })

    use "windwp/nvim-ts-autotag"

    use "ThePrimeagen/harpoon"

    use "gen740/SmoothCursor.nvim"

    use "Myzel394/easytables.nvim"

    use {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    }
    use "hrsh7th/nvim-cmp"
    use { "saadparwaiz1/cmp_luasnip" }
end)

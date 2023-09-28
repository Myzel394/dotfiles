vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
            "nvim-telescope/telescope.nvim", tag = '0.1.3',
            requires = { {"nvim-lua/plenary.nvim"} }
    }
    use "vim-airline/vim-airline"


    use { "catppuccin/nvim", as = "catppuccin" }


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
            {
                "neovim/nvim-lspconfig",
                opts = {
                  servers = {
                    lua_ls = {
                      settings = {
                        Lua = {
                          format = {
                            enable = false,
                            defaultConfig = {
                              indent_style = "space",
                              indent_size = "4",
                            },
                          },
                        },
                      },
                    },
                  },
                },
            },
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"},
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

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    use({
	"Pocco81/auto-save.nvim",
	config = function()
		 require("auto-save").setup {
             enabled = false,
		 }
	end,
    })
end)


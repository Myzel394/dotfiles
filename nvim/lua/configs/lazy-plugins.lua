-- Required by lazy.nvim to be set before loading plugins
vim.g.mapleader = " "

local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	"norcalli/nvim-colorizer.lua",
	"github/copilot.vim",
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
	"gen740/SmoothCursor.nvim",
	{
		"numToStr/Comment.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	"gbprod/yanky.nvim",
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
		opts = {},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"Myzel394/telescope-last-positions",

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
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			"kdheepak/cmp-latex-symbols",
			"uga-rosa/cmp-dictionary",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"roobert/tailwindcss-colorizer-cmp.nvim",
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
		"petertriho/nvim-scrollbar",
		dependencies = {
			"kevinhwang91/nvim-hlslens",
		},
	},
	"tiagovla/scope.nvim",
	"akinsho/bufferline.nvim",
	"nvimdev/galaxyline.nvim",
	{
		"gsuuon/model.nvim",
		cmd = { "M", "Model", "Mchat" },
		ft = "mchat",
	},
	{
		"max397574/colortils.nvim",
		cmd = "Colortils",
		config = function()
			require("colortils").setup()
		end,
	},
	"mawkler/modicator.nvim",
	"xiyaowong/nvim-cursorword",
	"tzachar/highlight-undo.nvim",
	"jinh0/eyeliner.nvim",
	"jackMort/ChatGPT.nvim",
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
		config = true,
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
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	"tpope/vim-obsession",
	{ "chrisgrieser/nvim-spider", lazy = true },

	{
		-- Lazy loading not required as it's automatically lazy loading by default
		"vuki656/package-info.nvim",
	},
	-- Extra
	{
		"Myzel394/easytables.nvim",
		lazy = true,
		enabled = not RUNNING_LIMITED_HARDWARE,
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
		"stevearc/conform.nvim",
		enabled = not RUNNING_LIMITED_HARDWARE,
	},
})

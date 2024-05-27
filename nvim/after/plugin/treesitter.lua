local IS_RUNNING_ON_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

vim.opt.runtimepath:append("$HOME/.local/share/treesitter")

local ensure_installed = {
	"vim",
	"vimdoc",
	"query",
	"dockerfile",
    "markdown",
	"markdown_inline",
}

if not IS_RUNNING_ON_LIMITED_HARDWARE then
	table.insert(ensure_installed, "sql")
	table.insert(ensure_installed, "gitcommit")
	table.insert(ensure_installed, "gitignore")

	table.insert(ensure_installed, "javascript")
	table.insert(ensure_installed, "typescript")
	table.insert(ensure_installed, "scss")
	table.insert(ensure_installed, "python")
	table.insert(ensure_installed, "latex")
	table.insert(ensure_installed, "typst")
	table.insert(ensure_installed, "lua")
	table.insert(ensure_installed, "java")
	table.insert(ensure_installed, "kotlin")
	table.insert(ensure_installed, "c")
	table.insert(ensure_installed, "zig")
end

require("nvim-treesitter.configs").setup({
    modules = {},
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = ensure_installed,

	-- Install parsers synchronously (only applied to `ensure_installed`)
	-- f
	sync_install = false,

	parser_install_dir = "$HOME/.local/share/treesitter",

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	ignore_install = {},

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	autotag = {
		enable = true,
	},

    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                -- You can also use captures from other query groups like `locals.scm`
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            include_surrounding_whitespace = true,
        },
    },
})

----- Treesitter -----

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.crystal = {
--   install_info = {
--     url = "~/CodeProjects/tree-sitter/", -- local path or git repo
--     files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
--     -- optional entries:
--     branch = "main", -- default branch in case of git repo if different from master
--     generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--     requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--   },
--   filetype = "crystal", -- if filetype does not match the parser name
-- }
-- vim.treesitter.language.register('crystal', 'crystal')

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.numbat = {
--   install_info = {
--     url = "~/CodeProjects/tree-sitter-numbat",
--     files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
--     -- optional entries:
--     branch = "main", -- default branch in case of git repo if different from master
--     generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--     requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--   },
--   filetype = "numbat", -- if filetype does not match the parser name
-- }
-- vim.filetype.add {
--     extensions = {
--         numbat = "numbat",
--     }
-- }
-- vim.treesitter.language.register("numbat", "numbat")

----- Blankline & rainbow delimiters

local rainbow_delimiters = require("rainbow-delimiters")

vim.g.rainbow_delimiters = {
	strategy = {
		[""] = rainbow_delimiters.strategy["global"],
		vim = rainbow_delimiters.strategy["local"],
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
}

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)


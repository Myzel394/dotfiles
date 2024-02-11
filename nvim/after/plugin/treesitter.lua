local IS_RUNNING_ON_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

vim.opt.runtimepath:append("$HOME/.local/share/treesitter")

local ensure_installed = {
	"sql",
	"vim",
	"vimdoc",
	"query",
	"dockerfile",
	"markdown_inline",
	"gitcommit",
	"gitignore",
}

if not IS_RUNNING_ON_LIMITED_HARDWARE then
	table.insert(ensure_installed, "javascript")
	table.insert(ensure_installed, "typescript")
	table.insert(ensure_installed, "python")
	table.insert(ensure_installed, "latex")
	table.insert(ensure_installed, "markdown")
	table.insert(ensure_installed, "lua")
	table.insert(ensure_installed, "java")
	table.insert(ensure_installed, "kotlin")
end

require("nvim-treesitter.configs").setup({
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
})

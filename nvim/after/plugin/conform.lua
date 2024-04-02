local IS_RUNNING_ON_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

if IS_RUNNING_ON_LIMITED_HARDWARE or true then
	return
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { { "prettierd", "prettier" }, "eslint" },
	},
	format_on_save = { timeout_ms = 2000, lsp_fallback = true },
})

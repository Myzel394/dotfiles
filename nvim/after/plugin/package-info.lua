local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

if RUNNING_LIMITED_HARDWARE then
	return
end


vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "package.json",
	callback = function()
		require("package-info").setup()
	end,
})

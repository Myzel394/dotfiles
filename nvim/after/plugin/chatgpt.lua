local IS_RUNNING_ON_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

if IS_RUNNING_ON_LIMITED_HARDWARE then
	return
end

local home = vim.fn.expand("$HOME")

require("chatgpt").setup({
	api_key_cmd = "bash " .. home .. "/.config/nvim/scripts/extract-openai-api-key.sh",
	openai_params = {
		model = "gpt-4",
	},
})

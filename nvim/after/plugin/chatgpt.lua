local home = vim.fn.expand("$HOME")

require("chatgpt").setup({
	api_key_cmd = "bash " .. home .. "/.config/nvim/scripts/extract-openai-api-key.sh",
	openai_params = {
		model = "gpt-4",
	},
})

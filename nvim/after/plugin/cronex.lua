local IS_RUNNING_ON_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

if IS_RUNNING_ON_LIMITED_HARDWARE then
	return
end

require("cronex").setup({
    format = function(text)
        return "󰥔 " .. text
    end
})

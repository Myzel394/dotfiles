local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

if RUNNING_LIMITED_HARDWARE then
    return
end

-- local ls = require("luasnip")
--
-- require("luasnip/loaders/from_vscode").lazy_load()
--
-- vim.keymap.set({ "i" }, "<C-K>", function()
-- 	ls.expand()
-- end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-L>", function()
-- 	ls.jump(1)
-- end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-J>", function()
-- 	ls.jump(-1)
-- end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, { silent = true })

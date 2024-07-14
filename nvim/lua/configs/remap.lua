vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

vim.keymap.set({ "n", "v" }, "$", "g$")
vim.keymap.set({ "n", "v" }, "_", "g_")
vim.keymap.set({ "n", "v" }, "0", "g0")

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Add executable permission", silent = true })

-- Auto Save
vim.api.nvim_set_keymap("n", "<leader>n", ":ASToggle<CR>", {})

-- Copy paste
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>p", [["+p]])

-- NeoTree
vim.keymap.set("n", "<leader>n", ":Neotree position=float<CR>", { desc = "Toggle Neotree" })

-- Fix paste
vim.keymap.set("v", "p", '"_dP')

-- Yanky
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

vim.keymap.set("n", "<leader>y", ":Telescope yank_history<CR>", { desc = "Yank history" })

require("configs.easy-replacer")

vim.keymap.set(
	"n",
	"[c",
	function()
		require("treesitter-context").go_to_context(vim.v.count1)
	end,
	{ silent = true, desc = "Go to previous context" }
)

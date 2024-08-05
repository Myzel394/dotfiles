local IS_RUNNING_ON_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

local lsp = require("lsp-zero").preset("recommended")
local utils = require("lspconfig/util")

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()

require("mason").setup({})
local ensured_lsps = {
	"dockerls",
	"docker_compose_language_service",
	"yamlls",
	"bashls",
	"nil_ls",

	-- Javascript, Typescript and JSON
	"tsserver",
	"lemminx",
}

if not IS_RUNNING_ON_LIMITED_HARDWARE then
	table.insert(ensured_lsps, "rust_analyzer")

	table.insert(ensured_lsps, "eslint")
	table.insert(ensured_lsps, "tailwindcss")
	table.insert(ensured_lsps, "html")
	table.insert(ensured_lsps, "cssls")

	table.insert(ensured_lsps, "lua_ls")

	table.insert(ensured_lsps, "jdtls")

	-- texlab
	table.insert(ensured_lsps, "ltex")
	table.insert(ensured_lsps, "typst_lsp")
	-- table.insert(ensured_lsps, "marksman")

	-- table.insert(ensured_lsps, "kotlin_language_server")

	---- Python ----
	-- Formatter
	table.insert(ensured_lsps, "ruff_lsp")
	-- Linter
	table.insert(ensured_lsps, "jedi_language_server")

	table.insert(ensured_lsps, "solargraph")

	table.insert(ensured_lsps, "clangd")

	-- table.insert(ensured_lsps, "zls")
	table.insert(ensured_lsps, "ansiblels")

	table.insert(ensured_lsps, "gopls")

	table.insert(ensured_lsps, "nginx_language_server")

	-- table.insert(ensured_lsps, "crystalline")
end

require("mason-lspconfig").setup({
	ensure_installed = ensured_lsps,
})

----- Lsp Config -----
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local on_attach = function(client, bufnr) end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.documentFormattingProvider = false
capabilities.documentRangeFormattingProvider = false

-- Change the Diagnostic symbols in the sign column
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lspconfig["dockerls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["docker_compose_language_service"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["yamlls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["bashls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function()
		vim.lsp.start({
			name = "bash-language-server",
			cmd = { "bash-language-server", "start" },
		})
	end,
})

lspconfig["nil_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["lemminx"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

if not IS_RUNNING_ON_LIMITED_HARDWARE then
    require'lspconfig'.svelte.setup{}

	lspconfig["html"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["tsserver"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
	--
	-- configure typescript server with plugin
	lspconfig["tailwindcss"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["eslint"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- configure css server
	lspconfig["cssls"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- configure graphql language server

	-- configure graphql language server
	lspconfig["rust_analyzer"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["jedi_language_server"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["ruff_lsp"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- configure lua server (with special settings)
	lspconfig["lua_ls"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	lspconfig["jdtls"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- lspconfig["marksman"].setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- })

	lspconfig["texlab"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["ltex"].setup({
		filetypes = { "markdown", "md", "tex", "plaintex" },
		flags = { debounce_text_changes = 300 },
		settings = {
			ltex = {
				enabled = true,
				language = "de-DE",
				setenceCacheSize = 2000,
				additionalRules = {
					enablePickyRules = true,
				},
				trace = { server = "verbose" },
				disabledRules = {},
				hiddenFalsePositives = {},
				username = "x@y.z",
				apiKey = "tete",
			},
		},
		on_attach = on_attach,
	})

	lspconfig["typst_lsp"].setup({
        filetypes = {"typst"},
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["kotlin_language_server"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["solargraph"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["clangd"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["zls"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
    })

	lspconfig["ansiblels"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["crystalline"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["gopls"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = utils.root_pattern("go.work", "go.mod", ".git"),
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
            }
        }
	})

	lspconfig["nginx_language_server"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

------- CMP -------
local cmp = require("cmp")


local default_sources = {
	-- { name = "copilot"},
	{ name = "async_path" },
	{ name = "nvim_lsp" },
	{ name = "nvim_lua" },
	{
		name = "luasnip",
		option = {
			show_autosnippets = true,
		},
	},
	-- { name = "dotenv" },
	{ name = "calc" },
}

-- require("copilot_cmp").setup()
cmp.setup({
	preselect = "item",
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-j>"] = cmp.mapping.scroll_docs(6),
		["<C-k>"] = cmp.mapping.scroll_docs(-6),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		documentation = cmp.config.window.bordered(),
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:TransparentGroup,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			if entry.source.name == "calc" then
				vim_item.kind = " " .. "" .. " "
			elseif entry.source.name == "dotenv" then
				vim_item.kind = " " .. "" .. " "
			elseif entry.source.name == "luasnip" then
				vim_item.kind = " " .. "" .. " "
			else
				kind.kind = " " .. (strings[1] or "") .. " "
			end
			

			
			return kind
		end,
	},
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
})

local ALLOWED_PATH_FILES = {
	"md",
	"txt",
	"tex",
	"plaintex",
	"markdown",
}

local M = {}

function M:endswith(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

function M:is_name_allowed(name)
	for _, ending in ipairs(ALLOWED_PATH_FILES) do
		if M:endswith(name, ending) then
			return true
		end
	end

	return false
end

function table.simply_clone(t)
	local t2 = {}
	for k, v in pairs(t) do
		t2[k] = v
	end
	return t2
end

-- Add `path` only if in markdown or text buffers
vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function(context)
		local sources = default_sources
		local name = vim.api.nvim_buf_get_name(context.buf)

		if #name >= 3 and M:is_name_allowed(name) then
			table.insert(sources, {
				name = "dictionary",
				keyword_length = 2,
			})
			table.insert(sources, {
				name = "latex_symbols",
				option = {
					strategy = 2,
				},
			})
		end

		cmp.setup.buffer({
			sources = sources,
		})
	end,
})

require("cmp_dictionary").setup({
	paths = {
		vim.fn.expand("$HOME/.config/nvim/dicts/german.dict"),
		vim.fn.expand("$HOME/.config/nvim/dicts/english.dict"),
	},
})

-- Customization for Pmenu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })

vim.keymap.set("n", "<leader>jlp", vim.diagnostic.goto_prev, { silent = true, desc = "Go to previous diagnostic" })
vim.keymap.set("n", "<leader>jln", vim.diagnostic.goto_next, { silent = true, desc = "Go to next diagnostic" })

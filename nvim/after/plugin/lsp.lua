local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")
local lsp = require('lsp-zero').preset("recommended")

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup_servers({
    "tsserver",
    "eslint",
    "tailwindcss",
    "dockerls",
    "docker_compose_language_service"
})

lsp.setup()

local function filterReactDTS(value)
    return string.match(value.filename, "react/index.d.ts") == nil
end

-- custom list handler
local function on_list(options)
    local items = options.items
    if #items > 1 then
        -- filter out react/index.d.ts
        items = filter(items, filterReactDTS)
    end

    vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
    if #items > 1 then
        -- if more than one option, open loc list
        vim.api.nvim_command "copen"
    else
        -- else jump directly
        vim.api.nvim_command "cfirst"
    end
end

local null_opts = lsp.build_options("null-ls", {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = function()
                vim.lsp.buf.format {
                    filter = function()
                        -- only use null-ls for formatting
                        return client.name == "null-ls"
                    end,
                    bufnr = bufnr,
                }
            end,
        })
    end,
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition { on_list = on_list }
    end, opts)
end)

null_ls.setup {
    on_attach = null_opts.on_attach,
    sources = {
        -- null_ls.builtins.formatting.pg_format,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.rustfmt
    },
}

mason_null_ls.setup {
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
    handlers = {},
}

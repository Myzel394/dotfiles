local cmp = require("cmp")

cmp.setup({
    preselect = "item",
    mapping = cmp.mapping.preset.insert({
        ["<C-f>"] = function()
            if cmp.visible_docs() then
                cmp.mapping.scroll_docs(4)
            else
                cmp.open_docs()
            end
        end,
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false })
    }),
    snippet = {
        expand = function(args)
            require "luasnip".lsp_expand(args.body)
        end
    },
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip", option = { show_autosnippets = true } },
    },
    snippet = {
        expand = function(args)
            local luasnip = prequire("luasnip")
            if not luasnip then
                return
            end
            luasnip.lsp_expand(args.body)
        end,
    }
})

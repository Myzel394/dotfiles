local cmp = require('cmp')

cmp.setup({
    preselect = "item",
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    },
    formatting = { format = require("tailwindcss-colorizer-cmp").formatter },
})

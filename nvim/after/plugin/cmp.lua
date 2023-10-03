local cmp = require('cmp')

cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    },
    formatting = { format = require("tailwindcss-colorizer-cmp").formatter },
})

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping.confirm({select = false}),
  },
  sources = {
      { name = 'path' }
  },
	formatting = { format = require("tailwindcss-colorizer-cmp").formatter },
})

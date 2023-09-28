require('lspconfig').ltex.setup({
  filetypes = {  "markdown", "md", "tex" },  flags = { debounce_text_changes = 300 },
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
    }
  },
  on_attach = on_attach,
})


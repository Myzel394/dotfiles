require "conform".setup{
    formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "prettierd", "prettier" }, "eslint" },
    },
    format_on_save = { timeout_ms = 2000, lsp_fallback = true },
}

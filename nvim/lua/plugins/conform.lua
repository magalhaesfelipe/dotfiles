return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      css = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
    formatters = {
      biome = {
        require_cwd = false,
      },
    },
    log_level = vim.log.levels.DEBUG,
    -- format_on_save = {
    --   timeout_ms = 2000,
    --   lsp_fallback = true,
    -- },
  },
}

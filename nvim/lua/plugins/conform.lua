return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "biome-check" },
      typescript = { "biome-check" },
      javascriptreact = { "biome-check" },
      typescriptreact = { "biome-check" },
      css = { "biome-check" },
      json = { "biome-check" },
      jsonc = { "biome-check" },
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
    formatters = {
      ["biome-check"] = {
        require_cwd = false,
      },
    },
    log_level = vim.log.levels.DEBUG,
    format_on_save = {
      timeout_ms = 2000,
      lsp_format = "fallback",
    },
  },
}

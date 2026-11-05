return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
    formatters = {
      prettier = {
        cwd = require('conform.util').root_file({
          "prettier.config.js",
          "prettier.config.cjs",
          "prettier.config.mjs",
          ".prettierrc",
          ".prettierrc.json",
          "package.json"
        })
      }
    },
    log_level = vim.log.levels.DEBUG,
    format_on_save = {
      timeout_ms = 2000,
      lsp_fallback = true,
    },
  },
}

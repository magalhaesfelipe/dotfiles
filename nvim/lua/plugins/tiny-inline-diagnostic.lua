return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "minimal",
      options = {
        severity = { vim.diagnostic.severity.ERROR }, -- errors only, like your current setup
        multilines = { enabled = false },
        overflow = { mode = "oneline" },
      },
    })
  end,
}

return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    vim.diagnostic.config({ virtual_text = false })
    require("tiny-inline-diagnostic").setup({
      options = {
        overflow = { mode = "wrap", padding = 0 },
        softwrap = 30,
        show_all_diags_on_cursorline = true,
      },
    })
  end,
}

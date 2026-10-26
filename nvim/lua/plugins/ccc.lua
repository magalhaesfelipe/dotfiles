return {
  "uga-rosa/ccc.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color picker" },
    { "<leader>cc", "<cmd>CccConvert<cr>", desc = "Convert color format" },
  },
  opts = function()
    local ccc = require("ccc")
    return {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
      outputs = {
        ccc.output.css_hsl,
        ccc.output.hex,
        ccc.output.css_rgb,
      },
    }
  end,
}

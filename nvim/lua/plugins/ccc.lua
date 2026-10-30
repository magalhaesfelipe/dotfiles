local function convert_to(output)
  return function()
    local ccc = require("ccc")
    require("ccc.config").options.convert = {
      { ccc.picker.hex, output },
      { ccc.picker.css_rgb, output },
      { ccc.picker.css_hsl, output },
    }
    vim.cmd("CccConvert")
  end
end

return {
  "uga-rosa/ccc.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color picker" },
    { "<leader>cc", "<cmd>CccConvert<cr>", desc = "Convert color format" },
    { "<leader>ph", function() convert_to(require("ccc").output.hex)() end, desc = "Color → hex" },
    { "<leader>pr", function() convert_to(require("ccc").output.css_rgb)() end,  desc = "Color → rgb" },
    { "<leader>pl", function() convert_to(require("ccc").output.css_hsl)() end,  desc = "Color → hsl" },
  },
  opts = function()
    local ccc = require("ccc")
    return {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
      inputs = {
        ccc.input.rgb,
        ccc.input.hsl,
      },
      pickers = {
       ccc.picker.hex,
       ccc.picker.css_hsl,
      },
      outputs = {
        ccc.output.hex,
        ccc.output.css_hsl,
        ccc.output.css_rgb,
      },
    }
  end,
}

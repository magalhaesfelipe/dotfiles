return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    -- You can set default options here
    direction = "float", -- This makes the default terminal open at the bottom
    float_opts = {
      width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.65)
      end,
    },
  },
}

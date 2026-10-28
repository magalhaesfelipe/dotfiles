return {
  "dchinmay2/alabaster.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
  },
  config = function()
    vim.o.termguicolors = true
    vim.o.background = "dark" -- optional, otherwise it follows the terminal
    -- vim.g.alabaster_dim_comments = true -- comments are bright yellow by default
    vim.cmd.colorscheme("alabaster")
  end,
}

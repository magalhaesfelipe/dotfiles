return {
  "vimcolorschemes/olive-crt.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
  },
  config = function(_, opts)
    require("olive_crt").setup(opts)
    vim.cmd.colorscheme("olive-crt")
  end,
}

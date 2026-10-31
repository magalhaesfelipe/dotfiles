return {
  { "LazyVim/LazyVim",       opts = { colorscheme = function() end } },
  { "catppuccin/nvim",       enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
    keys = {
      { "<leader>e",  false },
      { "<leader>E",  false },
      { "<leader>fe", false },
      { "<leader>fE", false },
    },
  },
}

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "FILE TREE" },
  },
  opts = {
    view = { width = 30, side = "right" },
    renderer = { icons = { show = { git = false } } },
  },
}

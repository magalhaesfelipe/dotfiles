return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "FILE TREE" },
  },
  opts = function()
    local width = 35
    return {
      view = {
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = width,
            height = 25,
            row = 1,
            col = vim.o.columns - width - 2,
          },
        },
      },
      renderer = { icons = { show = { git = false } } },
    }
  end,
}

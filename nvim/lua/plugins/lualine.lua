return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto", -- follows your colorscheme (works with gruvbox)
      globalstatus = true, -- one statusline for all splits
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1 } }, -- 1 = relative path
      lualine_x = { "encoding", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}

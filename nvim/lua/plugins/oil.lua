return {
  "stevearc/oil.nvim",
  opts = {
    keymaps = {
      ["<C-s>"] = false, -- Disable oil's default Ctrl+S split-screen mapping
      ["<leader>s"] = { "actions.select", opts = { vertical = true }, desc = "Open in split" },
      ["o"] = {
        callback = function()
          vim.api.nvim_buf_set_lines(0, -1, -1, false, { "" })
          vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
          vim.cmd("startinsert!")
        end,
        desc = "Create new file",
      },
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}


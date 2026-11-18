return {
  "LazyVim/LazyVim",
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        vim.o.statuscolumn = ""
      end,
    })
  end,
}

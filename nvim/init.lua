-- Leader keys must be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = false, -- tiny-inline-diagnostic replaces this
  -- virtual_text = { severity = vim.diagnostic.severity.ERROR }
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  -- Only show virtual text for errors, not warnings/hints
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "kitty",
  callback = function()
    vim.opt_local.dictionary = vim.fn.expand("~/.config/nvim/dict/kitty.txt")
    vim.opt_local.complete:append("k")
  end,
})

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
require("config.ui") -- after lazy so the colorscheme is available

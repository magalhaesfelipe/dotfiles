-- Leader keys must be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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


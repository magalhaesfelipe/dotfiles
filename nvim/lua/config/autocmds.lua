-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
})

-- :Config opens init.lua
vim.api.nvim_create_user_command("Config", "edit $MYVIMRC", { desc = "EDIT CONFIG" })

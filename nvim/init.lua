-- Leader keys must be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function format_diagnostic(diagnostic)
  local msg = diagnostic.message or ""

  -- Extract rule code if Biome/ESLint put it at the start: [category/rule]
  local rule = msg:match("^%[([^%]]+)%]")
  if rule then
    msg = msg:gsub("^%[[^%]]+%]%s*", "")
  elseif diagnostic.code then
    rule = tostring(diagnostic.code)
  end

  -- Strip trailing file locations like "HeatMap2.tsx:91:39:"
  msg = msg:gsub("%s*[%a%d_%-%.]+%a+:%d+:%d+:?%s*", "")

  -- Keep the first clean line of the message
  local first_line = msg:match("([^\n]+)")
  if first_line and #first_line > 0 then
    msg = vim.trim(first_line)
  end

  -- Message first, followed by the rule code at the end
  if rule and #rule > 0 and not msg:find(rule, 1, true) then
    return string.format(" %s  [%s] ", msg, rule)
  end
  return string.format(" %s ", msg)
end

vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
    format = format_diagnostic,
  },
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
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

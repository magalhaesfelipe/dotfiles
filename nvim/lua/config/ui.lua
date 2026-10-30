vim.opt.fillchars = {
  horiz = "─", horizup = "┴", horizdown = "┬",
  vert = "│", vertleft = "┤", vertright = "├", verthoriz = "┼",
}

vim.g.alabaster_transparent = true
vim.cmd.colorscheme("toge")

-- vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7d9b76", bg = "NONE" })

-- Interval line numbers (every 10th)
-- function _G.StatusCol()
--   local lnum = vim.v.lnum
--   local last = vim.api.nvim_buf_line_count(0)
--   local text = ""
--   if vim.v.virtnum == 0 and (vim.v.relnum == 0 or lnum == 1 or lnum == last or lnum % 10 == 0) then
--     text = tostring(lnum)
--   end
--   return "%s%=" .. text .. " "
-- end
--
-- vim.opt.statuscolumn = "%!v:lua.StatusCol()"

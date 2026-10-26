local M = {}

M.values = {
  tab_bar_edge = { "top", "bottom" },
  tab_bar_style = { "fade", "slant", "separator", "powerline", "custom", "hidden" },
  tab_powerline_style = { "angled", "slanted", "round" },
  tab_bar_align = { "left", "center", "right" },
  cursor_shape = { "block", "beam", "underline" },
  hide_window_decorations = { "no", "yes", "titlebar-only", "titlebar-and-corners" },
  dynamic_background_opacity = { "yes", "no" },
  remember_window_size = { "yes", "no" },
  enable_audio_bell = { "yes", "no" },
}

function M.new() return setmetatable({}, { __index = M }) end
function M:enabled() return vim.bo.filetype == "kitty" end
function M:get_trigger_characters() return { " " } end

function M:get_completions(ctx, callback)
  local before = ctx.line:sub(1, ctx.cursor[2])
  local opt = before:match("^%s*([%w_]+)%s+")
  local items = {}
  for _, v in ipairs(M.values[opt] or {}) do
    items[#items + 1] = {
      label = v,
      kind = vim.lsp.protocol.CompletionItemKind.EnumMember,
    }
  end
  callback({ items = items, is_incomplete_forward = false, is_incomplete_backward = false })
end

return M

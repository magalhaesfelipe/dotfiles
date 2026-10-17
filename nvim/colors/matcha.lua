-- Matcha: a muted green dark colorscheme for Neovim
-- Windows location: ~/AppData/Local/nvim/colors/matcha.lua  (Windows)
-- Options (set before :colorscheme matcha):
--   vim.g.matcha_transparent = false   -- solid background (default: true)
--   vim.g.matcha_italic = true         -- italic comments, params, etc. (default: false)

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "matcha"

local transparent = vim.g.matcha_transparent ~= false
local italic = vim.g.matcha_italic == true

-- ----------------------------------------------------------------------------
-- Palette
-- ----------------------------------------------------------------------------
local c = {
  bg = "#1d1f1b",
  bg_dark = "#161814",
  bg_light = "#282b25",
  border = "#3a3d36",
  sep = "#4a4d46",
  fg = "#ede8dc",
  fg_dim = "#c9c4b8",
  muted = "#a89f8b",
  comment = "#6b6357",
  green = "#7d9b76",
  green_light = "#a4c49b",
  green_hover = "#8dab86",
  teal = "#7ba3a3",
  sage = "#8fa8a0",
  tan = "#c9b896",
  lavender = "#b8a9c9",
  red = "#c47d7d",
  amber = "#d4a574",
  string = "#e8dcc4",
  string_punct = "#d4c4a8",
  cursor = "#aeafad",
  -- pre-blended highlight backgrounds (Neovim has no alpha)
  cursorline = "#20231e",
  selection = "#353e32",
  search = "#534f41",
  search_dim = "#3e3c32",
  word = "#3a393c",
  diff_add = "#2b3028",
  diff_del = "#2e2825",
  diff_change = "#262c29",
  none = "NONE",
}

local base_bg = transparent and c.none or c.bg
local side_bg = transparent and c.none or c.bg_dark

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to })
end

-- ----------------------------------------------------------------------------
-- Editor UI
-- ----------------------------------------------------------------------------
hl("Normal", { fg = c.fg, bg = base_bg })
hl("NormalNC", { fg = c.fg, bg = base_bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg_light })
hl("FloatBorder", { fg = c.green, bg = c.bg_light })
hl("FloatTitle", { fg = c.green, bg = c.bg_light, bold = true })
hl("Cursor", { fg = c.bg, bg = c.cursor })
hl("lCursor", { link = "Cursor" })
hl("TermCursor", { link = "Cursor" })
hl("CursorLine", { bg = c.cursorline })
hl("CursorColumn", { bg = c.cursorline })
hl("ColorColumn", { bg = c.cursorline })
hl("LineNr", { fg = c.comment, bg = c.none })
hl("CursorLineNr", { fg = c.green, bg = c.none, bold = true })
hl("SignColumn", { fg = c.comment, bg = c.none })
hl("FoldColumn", { fg = c.comment, bg = c.none })
hl("Folded", { fg = c.muted, bg = c.bg_light })
hl("EndOfBuffer", { fg = base_bg == c.none and c.bg or c.bg, bg = c.none })
hl("NonText", { fg = c.border })
hl("Whitespace", { fg = c.border })
hl("SpecialKey", { fg = c.border })
hl("Conceal", { fg = c.comment })
hl("Directory", { fg = c.teal })
hl("Title", { fg = c.green, bold = true })
hl("Visual", { bg = c.selection })
hl("VisualNOS", { bg = c.selection })
hl("Search", { bg = c.search_dim })
hl("CurSearch", { fg = c.fg, bg = c.search })
hl("IncSearch", { fg = c.fg, bg = c.search })
hl("Substitute", { fg = c.bg, bg = c.tan })
hl("MatchParen", { fg = c.green_light, bold = true, underline = true })
hl("WinSeparator", { fg = c.sep, bg = c.none })
hl("VertSplit", { link = "WinSeparator" })
hl("StatusLine", { fg = c.fg_dim, bg = c.bg_dark })
hl("StatusLineNC", { fg = c.comment, bg = c.bg_dark })
hl("TabLine", { fg = c.muted, bg = c.bg_dark })
hl("TabLineSel", { fg = c.fg, bg = c.bg, bold = true })
hl("TabLineFill", { bg = c.bg_dark })
hl("WinBar", { fg = c.fg_dim, bg = c.none })
hl("WinBarNC", { fg = c.comment, bg = c.none })
hl("Pmenu", { fg = c.fg, bg = c.bg_light })
hl("PmenuSel", { fg = "#ffffff", bg = c.selection })
hl("PmenuSbar", { bg = c.bg_light })
hl("PmenuThumb", { bg = c.comment })
hl("WildMenu", { fg = "#ffffff", bg = c.selection })
hl("QuickFixLine", { bg = c.selection })

-- Messages
hl("ErrorMsg", { fg = c.red, bold = true })
hl("WarningMsg", { fg = c.amber })
hl("MoreMsg", { fg = c.green })
hl("ModeMsg", { fg = c.fg_dim })
hl("Question", { fg = c.teal })

-- Diff
hl("DiffAdd", { bg = c.diff_add })
hl("DiffDelete", { fg = c.red, bg = c.diff_del })
hl("DiffChange", { bg = c.diff_change })
hl("DiffText", { bg = c.search_dim })
hl("Added", { fg = c.green_light })
hl("Removed", { fg = c.red })
hl("Changed", { fg = c.teal })

-- Spell
hl("SpellBad", { undercurl = true, sp = c.red })
hl("SpellCap", { undercurl = true, sp = c.amber })
hl("SpellLocal", { undercurl = true, sp = c.teal })
hl("SpellRare", { undercurl = true, sp = c.lavender })

-- Diagnostics
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.amber })
hl("DiagnosticInfo", { fg = c.teal })
hl("DiagnosticHint", { fg = c.sage })
hl("DiagnosticOk", { fg = c.green_light })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.amber })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.teal })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.sage })
hl("DiagnosticVirtualTextError", { fg = c.red })
hl("DiagnosticVirtualTextWarn", { fg = c.amber })
hl("DiagnosticVirtualTextInfo", { fg = c.teal })
hl("DiagnosticVirtualTextHint", { fg = c.sage })

-- LSP references
hl("LspReferenceText", { bg = c.word })
hl("LspReferenceRead", { bg = c.word })
hl("LspReferenceWrite", { bg = c.word })
hl("LspInlayHint", { fg = c.comment, bg = c.none })

-- ----------------------------------------------------------------------------
-- Classic syntax groups
-- ----------------------------------------------------------------------------
hl("Comment", { fg = c.comment, italic = italic })
hl("Constant", { fg = c.tan })
hl("String", { fg = c.string })
hl("Character", { fg = c.string })
hl("Number", { fg = c.lavender })
hl("Boolean", { fg = c.green_light })
hl("Float", { fg = c.lavender })
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.sage })
hl("Statement", { fg = c.green })
hl("Conditional", { fg = c.green })
hl("Repeat", { fg = c.green })
hl("Label", { fg = c.tan })
hl("Operator", { fg = c.green })
hl("Keyword", { fg = c.green })
hl("Exception", { fg = c.green })
hl("PreProc", { fg = c.lavender })
hl("Include", { fg = c.green, italic = italic })
hl("Define", { fg = c.lavender })
hl("Macro", { fg = c.lavender })
hl("PreCondit", { fg = c.lavender })
hl("Type", { fg = c.teal, italic = italic })
hl("StorageClass", { fg = c.green, italic = italic })
hl("Structure", { fg = c.teal })
hl("Typedef", { fg = c.teal })
hl("Special", { fg = c.sage })
hl("SpecialChar", { fg = c.lavender })
hl("Tag", { fg = c.green })
hl("Delimiter", { fg = c.muted })
hl("SpecialComment", { fg = c.lavender })
hl("Debug", { fg = c.amber })
hl("Underlined", { fg = c.sage, underline = true })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.bg, bg = c.tan, bold = true })

-- ----------------------------------------------------------------------------
-- Treesitter
-- ----------------------------------------------------------------------------
hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.green_light, italic = italic })
hl("@variable.parameter", { fg = c.tan, italic = italic })
hl("@variable.member", { fg = c.muted })
hl("@property", { fg = c.muted })
hl("@field", { fg = c.muted })
hl("@constant", { fg = c.tan })
hl("@constant.builtin", { fg = c.green_light })
hl("@constant.macro", { fg = c.lavender })
hl("@module", { fg = c.teal })
hl("@namespace", { fg = c.teal })
hl("@label", { fg = c.tan })

hl("@string", { fg = c.string })
hl("@string.escape", { fg = c.lavender })
hl("@string.regexp", { fg = c.green_light })
hl("@string.special", { fg = c.string_punct })
hl("@character", { fg = c.string })
hl("@number", { fg = c.lavender })
hl("@boolean", { fg = c.green_light })
hl("@float", { fg = c.lavender })

hl("@function", { fg = c.sage })
hl("@function.call", { fg = c.sage })
hl("@function.builtin", { fg = c.sage })
hl("@function.macro", { fg = c.lavender })
hl("@function.method", { fg = c.sage })
hl("@function.method.call", { fg = c.sage })
hl("@constructor", { fg = c.teal })

hl("@keyword", { fg = c.green })
hl("@keyword.function", { fg = c.green, italic = italic })
hl("@keyword.modifier", { fg = c.green, italic = italic })
hl("@keyword.import", { fg = c.green, italic = italic })
hl("@keyword.return", { fg = c.green })
hl("@keyword.operator", { fg = c.green })
hl("@keyword.conditional", { fg = c.green })
hl("@keyword.repeat", { fg = c.green })
hl("@keyword.exception", { fg = c.green })
hl("@operator", { fg = c.green })

hl("@type", { fg = c.teal, italic = italic })
hl("@type.builtin", { fg = c.teal })
hl("@type.definition", { fg = c.teal })
hl("@attribute", { fg = c.lavender })
hl("@attribute.builtin", { fg = c.lavender })

hl("@tag", { fg = c.green })
hl("@tag.attribute", { fg = c.tan, italic = italic })
hl("@tag.delimiter", { fg = c.muted })
hl("@punctuation", { fg = c.muted })
hl("@punctuation.bracket", { fg = c.muted })
hl("@punctuation.delimiter", { fg = c.muted })
hl("@punctuation.special", { fg = c.green })

hl("@comment", { fg = c.comment, italic = italic })
hl("@comment.todo", { fg = c.bg, bg = c.tan, bold = true })
hl("@comment.note", { fg = c.bg, bg = c.teal, bold = true })
hl("@comment.warning", { fg = c.bg, bg = c.amber, bold = true })
hl("@comment.error", { fg = c.bg, bg = c.red, bold = true })

hl("@markup.heading", { fg = c.green, bold = true })
hl("@markup.strong", { fg = c.tan, bold = true })
hl("@markup.italic", { fg = c.lavender, italic = italic })
hl("@markup.strikethrough", { strikethrough = true })
hl("@markup.link", { fg = c.sage })
hl("@markup.link.url", { fg = c.sage, underline = true })
hl("@markup.raw", { fg = c.string })
hl("@markup.list", { fg = c.green })
hl("@markup.quote", { fg = c.comment, italic = italic })

hl("@diff.plus", { fg = c.green_light })
hl("@diff.minus", { fg = c.red })
hl("@diff.delta", { fg = c.teal })

-- LSP semantic tokens
link("@lsp.type.class", "@type")
link("@lsp.type.interface", "@type")
link("@lsp.type.enum", "@type")
link("@lsp.type.namespace", "@module")
link("@lsp.type.parameter", "@variable.parameter")
link("@lsp.type.property", "@property")
link("@lsp.type.variable", "@variable")
link("@lsp.type.function", "@function")
link("@lsp.type.method", "@function.method")
link("@lsp.type.macro", "@function.macro")

-- ----------------------------------------------------------------------------
-- Plugins (harmless if not installed)
-- ----------------------------------------------------------------------------
-- nvim-tree
hl("NvimTreeNormal", { fg = c.fg_dim, bg = side_bg })
hl("NvimTreeNormalNC", { fg = c.fg_dim, bg = side_bg })
hl("NvimTreeWinSeparator", { fg = c.sep, bg = c.none })
hl("NvimTreeRootFolder", { fg = c.green, bold = true })
hl("NvimTreeFolderName", { fg = c.teal })
hl("NvimTreeOpenedFolderName", { fg = c.teal, bold = true })
hl("NvimTreeEmptyFolderName", { fg = c.comment })
hl("NvimTreeIndentMarker", { fg = c.border })
hl("NvimTreeGitDirty", { fg = c.teal })
hl("NvimTreeGitNew", { fg = c.green_light })
hl("NvimTreeGitDeleted", { fg = c.red })
hl("NvimTreeCursorLine", { bg = c.cursorline })

-- toggleterm
hl("ToggleTermBorder", { fg = c.green, bg = c.none })

-- gitsigns
hl("GitSignsAdd", { fg = c.green_light })
hl("GitSignsChange", { fg = c.teal })
hl("GitSignsDelete", { fg = c.red })

-- ----------------------------------------------------------------------------
-- Terminal colors
-- ----------------------------------------------------------------------------
vim.g.terminal_color_0 = "#282b25"
vim.g.terminal_color_1 = "#c47d7d"
vim.g.terminal_color_2 = "#4ab888"
vim.g.terminal_color_3 = "#d4a574"
vim.g.terminal_color_4 = "#7ba3a3"
vim.g.terminal_color_5 = "#dc5a8c"
vim.g.terminal_color_6 = "#8fa8a0"
vim.g.terminal_color_7 = "#ede8dc"
vim.g.terminal_color_8 = "#6b6357"
vim.g.terminal_color_9 = "#d4908f"
vim.g.terminal_color_10 = "#b4d4ab"
vim.g.terminal_color_11 = "#e4b584"
vim.g.terminal_color_12 = "#8bb3b3"
vim.g.terminal_color_13 = "#c8b9d9"
vim.g.terminal_color_14 = "#9fb8b0"
vim.g.terminal_color_15 = "#ffffff"

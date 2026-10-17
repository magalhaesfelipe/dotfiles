-- micro-gruvbox: Neovim port of micro editor's gruvbox colorscheme.
-- Paste into init.lua (after plugins), then run: vim.cmd.colorscheme("micro-gruvbox")

local c = {
  bg = "NONE",
  -- bg        = "#1d2021",
  fg        = "#ebdbb2",
  comment   = "#928374",
  symbol    = "#d79921",
  constant  = "#d3869b",
  string    = "#b8bb26",
  ident     = "#ebdbb2",
  statement = "#fb4934",
  type      = "#fe8019",
  special   = "#d79921",
  error     = "#9d0006",
  search_fg = "#1d2021",
  search_bg = "#fabd2f",
  added     = "#00af00",
  modified  = "#ffaf00",
  deleted   = "#d70000",
  linenr    = "#665c54",
  curlinenr = "#92b681",
  cursorln  = "#3c3836",
  colorcol  = "#665c54",
  todo      = "#ffcc00",
  ui_bg     = "#665c54",
  preproc_bg = "#262626", -- xterm 235
}

local function hl(group, opts) vim.api.nvim_set_hl(0, group, opts) end

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "micro-gruvbox"

-- Editor UI
hl("Normal",       { fg = c.fg, bg = c.bg })
hl("NormalNC",     { fg = c.fg, bg = c.bg })
hl("NormalFloat",  { fg = c.fg, bg = c.cursorln })
hl("FloatBorder",  { fg = c.linenr, bg = c.cursorln })
hl("CursorLine",   { bg = c.cursorln })
hl("ColorColumn",  { bg = c.colorcol })
hl("LineNr",       { fg = c.linenr, bg = c.bg })
hl("CursorLineNr", { fg = c.curlinenr, bg = c.bg })
hl("SignColumn",   { bg = c.bg })
hl("FoldColumn",   { fg = c.linenr, bg = c.bg })
hl("Folded",       { fg = c.comment, bg = c.cursorln })
hl("EndOfBuffer",  { fg = c.bg })
hl("NonText",      { fg = c.linenr })
hl("Whitespace",   { fg = c.linenr })
hl("VertSplit",    { fg = c.ui_bg })
hl("WinSeparator", { fg = c.ui_bg })
hl("Visual",       { bg = c.ui_bg })
hl("MatchParen",   { fg = c.search_bg, bold = true })
hl("Search",       { fg = c.search_fg, bg = c.search_bg })
hl("IncSearch",    { fg = c.search_fg, bg = c.search_bg, bold = true })
hl("CurSearch",    { fg = c.search_fg, bg = c.search_bg, bold = true })
hl("Pmenu",        { fg = c.fg, bg = c.cursorln })
hl("PmenuSel",     { fg = "#1d2021", bg = c.ident })
hl("PmenuSbar",    { bg = c.cursorln })
hl("PmenuThumb",   { bg = c.ui_bg })
hl("StatusLine",   { fg = c.ident, bg = c.ui_bg })
hl("StatusLineNC", { fg = c.comment, bg = c.cursorln })
hl("TabLine",      { fg = c.fg, bg = c.ui_bg })
hl("TabLineFill",  { fg = c.fg, bg = c.ui_bg })
hl("TabLineSel",   { fg = c.ident, bg = c.bg, bold = true })
hl("WinBar",       { fg = c.fg, bg = c.bg })
hl("Directory",    { fg = c.ident })
hl("Title",        { fg = c.statement, bold = true })
hl("ErrorMsg",     { fg = c.statement, bg = c.bg })
hl("WarningMsg",   { fg = c.symbol, bg = c.bg })
hl("ModeMsg",      { fg = c.ident })
hl("MoreMsg",      { fg = c.ident })
hl("Question",     { fg = c.ident })

-- Syntax
hl("Comment",      { fg = c.comment })
hl("Constant",     { fg = c.constant })
hl("String",       { fg = c.string })
hl("Character",    { fg = c.string })
hl("Number",       { fg = c.constant })
hl("Boolean",      { fg = c.constant })
hl("Float",        { fg = c.constant })
hl("Identifier",   { fg = c.ident })
hl("Function",     { fg = c.ident })
hl("Statement",    { fg = c.statement })
hl("Conditional",  { fg = c.statement })
hl("Repeat",       { fg = c.statement })
hl("Label",        { fg = c.statement })
hl("Operator",     { fg = c.symbol })
hl("Keyword",      { fg = c.statement })
hl("Exception",    { fg = c.statement })
hl("PreProc",      { fg = c.statement, bg = c.preproc_bg })
hl("Include",      { fg = c.statement })
hl("Define",       { fg = c.statement })
hl("Macro",        { fg = c.statement })
hl("PreCondit",    { fg = c.statement })
hl("Type",         { fg = c.type })
hl("StorageClass", { fg = c.type })
hl("Structure",    { fg = c.type })
hl("Typedef",      { fg = c.type })
hl("Special",      { fg = c.special })
hl("SpecialChar",  { fg = c.special })
hl("Tag",          { fg = c.special })
hl("Delimiter",    { fg = c.symbol })
hl("SpecialComment", { fg = c.comment })
hl("Debug",        { fg = c.special })
hl("Underlined",   { underline = true })
hl("Error",        { fg = c.error, bg = c.bg })
hl("Todo",         { fg = c.todo, bg = c.bg, bold = true })

-- Treesitter
local links = {
  ["@variable"] = "Normal", ["@variable.builtin"] = "Constant",
  ["@property"] = "Identifier", ["@field"] = "Identifier",
  ["@parameter"] = "Identifier", ["@variable.parameter"] = "Identifier",
  ["@function"] = "Function", ["@function.call"] = "Function",
  ["@function.builtin"] = "Function", ["@method"] = "Function",
  ["@constructor"] = "Type", ["@keyword"] = "Keyword",
  ["@keyword.function"] = "Keyword", ["@keyword.return"] = "Keyword",
  ["@conditional"] = "Conditional", ["@repeat"] = "Repeat",
  ["@include"] = "Include", ["@type"] = "Type", ["@type.builtin"] = "Type",
  ["@string"] = "String", ["@string.escape"] = "Special",
  ["@number"] = "Number", ["@boolean"] = "Boolean",
  ["@constant"] = "Constant", ["@constant.builtin"] = "Constant",
  ["@operator"] = "Operator", ["@punctuation"] = "Delimiter",
  ["@punctuation.bracket"] = "Delimiter", ["@punctuation.delimiter"] = "Delimiter",
  ["@comment"] = "Comment", ["@tag"] = "Statement",
  ["@tag.attribute"] = "Identifier", ["@tag.delimiter"] = "Delimiter",
}
for from, to in pairs(links) do hl(from, { link = to }) end

-- Diagnostics
hl("DiagnosticError", { fg = c.statement })
hl("DiagnosticWarn",  { fg = c.symbol })
hl("DiagnosticInfo",  { fg = c.ident })
hl("DiagnosticHint",  { fg = c.ident })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.statement })
hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.symbol })
hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.ident })
hl("DiagnosticUnderlineHint",  { undercurl = true, sp = c.ident })

-- Diff / git
hl("DiffAdd",    { fg = c.added,    bg = c.bg })
hl("DiffChange", { fg = c.modified, bg = c.bg })
hl("DiffDelete", { fg = c.deleted,  bg = c.bg })
hl("DiffText",   { fg = c.modified, bg = c.cursorln, bold = true })
hl("Added",      { fg = c.added })
hl("Changed",    { fg = c.modified })
hl("Removed",    { fg = c.deleted })
hl("GitSignsAdd",    { fg = c.added })
hl("GitSignsChange", { fg = c.modified })
hl("GitSignsDelete", { fg = c.deleted })

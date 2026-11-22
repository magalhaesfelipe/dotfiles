-- toge: Neovim colorscheme ported from the VS Code "toge" theme
-- Place at: ~/.config/nvim/colors/toge.lua  (Windows: ~\AppData\Local\nvim\colors\toge.lua)
-- Use:      vim.cmd.colorscheme("toge")

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "toge-dark"

local c = {
  -- surfaces
  bg       = "#232121", -- editor.background (lighter)
  bg_dark  = "#1b1a1a", -- sidebar / panels / statusline
  bg_alt   = "#1f1d1d", -- line highlight / inputs
  border   = "#211f1f",
  sel      = "#383636", -- selection
  -- text
  fg       = "#e8dcc4", -- editor.foreground
  ui_fg    = "#dbd7ca",
  side_fg  = "#bfbaaa",
  muted    = "#898783", -- #dedcd590 over bg
  dim      = "#585654", -- #dedcd550 over bg
  gray     = "#959da5",
  -- accents
  green    = "#4d9375",
  blue     = "#6394bf",
  orange   = "#d4976c",
  red      = "#cb7676",
  yellow   = "#e6cc77",
  cyan     = "#5eaab5",
  pink     = "#d9739f",
  -- syntax (tokenColors)
  comment  = "#8ba4b0", -- dragonBlue2
  string   = "#e2b178",
  escape   = "#737c8c",
  const    = "#d27e99",
  -- entity   = "#7d9b76",
  entity   = "#98bb6c",
  punct    = "#737c8c",
  keyword  = "#e8dcc4", -- theme leaves keywords at fg; change here (e.g. "#4d9375") to taste
  -- diff / search
  diff_add = "#2a3f36",
  diff_del = "#472d2d",
  diff_chg = "#2a3646",
  find     = "#504932",
  find_cur = "#6b5d33",
  word_hl  = "#2d3732",
}

local function hl(group, opts) vim.api.nvim_set_hl(0, group, opts) end

local groups = {
  -- Editor UI
  Normal                      = { fg = c.fg, bg = c.bg },
  NormalNC                    = { fg = c.fg, bg = c.bg },
  NormalFloat                 = { fg = c.ui_fg, bg = c.bg_dark },
  FloatBorder                 = { fg = c.dim, bg = c.bg_dark },
  FloatTitle                  = { fg = c.ui_fg, bg = c.bg_dark, bold = true },
  Cursor                      = { fg = c.bg, bg = "#aeafad" },
  CursorLine                  = { bg = c.bg_alt },
  CursorColumn                = { bg = c.bg_alt },
  ColorColumn                 = { bg = c.bg_alt },
  LineNr                      = { fg = c.dim },
  CursorLineNr                = { fg = c.side_fg },
  SignColumn                  = { fg = c.dim, bg = c.bg },
  FoldColumn                  = { fg = c.muted, bg = c.bg },
  Folded                      = { fg = c.muted, bg = "#2b2929" },
  VertSplit                   = { fg = "#322f2f" },
  WinSeparator                = { fg = "#322f2f" },
  EndOfBuffer                 = { fg = c.bg },
  NonText                     = { fg = "#363434" },
  Whitespace                  = { fg = "#363434" },
  SpecialKey                  = { fg = "#363434" },
  Visual                      = { bg = c.sel },
  VisualNOS                   = { bg = c.sel },
  Search                      = { bg = c.find },
  CurSearch                   = { bg = c.find_cur, fg = c.fg },
  IncSearch                   = { bg = c.find_cur, fg = c.fg },
  Substitute                  = { bg = c.find_cur, fg = c.fg },
  MatchParen                  = { bg = "#243a31", bold = true },
  Directory                   = { fg = c.blue },
  Title                       = { fg = c.ui_fg, bold = true },
  ErrorMsg                    = { fg = c.red },
  WarningMsg                  = { fg = c.orange },
  MoreMsg                     = { fg = c.green },
  ModeMsg                     = { fg = c.side_fg },
  Question                    = { fg = c.green },
  WildMenu                    = { bg = c.bg_alt },
  QuickFixLine                = { bg = c.bg_alt },
  Conceal                     = { fg = c.dim },

  -- Statusline / tabline / winbar
  StatusLine                  = { fg = c.side_fg, bg = c.bg_dark },
  StatusLineNC                = { fg = c.gray, bg = c.bg_dark },
  TabLine                     = { fg = c.gray, bg = c.bg_dark },
  TabLineFill                 = { bg = c.bg_dark },
  TabLineSel                  = { fg = c.ui_fg, bg = c.bg_dark, bold = true },
  WinBar                      = { fg = c.ui_fg, bg = c.bg },
  WinBarNC                    = { fg = c.gray, bg = c.bg },

  -- Popup menu
  Pmenu                       = { fg = c.ui_fg, bg = c.bg_dark },
  PmenuSel                    = { fg = c.ui_fg, bg = c.bg_alt, bold = true },
  PmenuSbar                   = { bg = c.bg_alt },
  PmenuThumb                  = { bg = c.dim },

  -- Diff
  DiffAdd                     = { bg = c.diff_add },
  DiffDelete                  = { fg = c.red, bg = c.diff_del },
  DiffChange                  = { bg = c.diff_chg },
  DiffText                    = { bg = "#35506b" },
  Added                       = { fg = c.green },
  Removed                     = { fg = c.red },
  Changed                     = { fg = c.blue },

  -- Spell
  SpellBad                    = { undercurl = true, sp = c.red },
  SpellCap                    = { undercurl = true, sp = c.orange },
  SpellLocal                  = { undercurl = true, sp = c.blue },
  SpellRare                   = { undercurl = true, sp = c.cyan },

  -- Classic syntax groups
  Comment                     = { fg = c.comment },
  Constant                    = { fg = c.const },
  String                      = { fg = c.string },
  Character                   = { fg = c.const },
  Number                      = { fg = c.const },
  Boolean                     = { fg = c.const },
  Float                       = { fg = c.const },
  Identifier                  = { fg = c.fg },
  Function                    = { fg = c.entity },
  Statement                   = { fg = c.keyword },
  Conditional                 = { fg = c.keyword },
  Repeat                      = { fg = c.keyword },
  Label                       = { fg = c.keyword },
  Operator                    = { fg = c.punct },
  Keyword                     = { fg = c.keyword },
  Exception                   = { fg = c.keyword },
  PreProc                     = { fg = c.keyword },
  Include                     = { fg = c.keyword },
  Define                      = { fg = c.keyword },
  Macro                       = { fg = c.keyword },
  PreCondit                   = { fg = c.keyword },
  Type                        = { fg = c.entity },
  StorageClass                = { fg = c.keyword },
  Structure                   = { fg = c.entity },
  Typedef                     = { fg = c.entity },
  Special                     = { fg = c.escape },
  SpecialChar                 = { fg = c.escape },
  Tag                         = { fg = c.entity },
  Delimiter                   = { fg = c.punct },
  SpecialComment              = { fg = c.comment },
  Debug                       = { fg = c.orange },
  Underlined                  = { underline = true },
  Error                       = { fg = "#df334a" },
  Todo                        = { fg = c.yellow, bold = true },

  -- Treesitter
  ["@comment"]                = { link = "Comment" },
  ["@string"]                 = { fg = c.string },
  ["@string.regexp"]          = { fg = c.string },
  ["@string.escape"]          = { fg = c.escape },
  ["@string.special.symbol"]  = { fg = c.string },
  ["@character"]              = { fg = c.const },
  ["@number"]                 = { fg = c.const },
  ["@number.float"]           = { fg = c.const },
  ["@boolean"]                = { fg = c.const },
  ["@constant"]               = { fg = c.const },
  ["@constant.builtin"]       = { fg = c.const },
  ["@variable"]               = { fg = c.fg },
  ["@variable.builtin"]       = { fg = c.fg },
  ["@variable.parameter"]     = { fg = c.fg },
  ["@variable.member"]        = { fg = c.fg },
  ["@property"]               = { fg = c.fg },
  ["@function"]               = { fg = c.entity },
  ["@function.call"]          = { fg = c.entity },
  ["@function.method"]        = { fg = c.entity },
  ["@function.method.call"]   = { fg = c.entity },
  ["@function.builtin"]       = { fg = c.entity },
  ["@constructor"]            = { fg = c.entity },
  ["@type"]                   = { fg = c.entity },
  ["@type.builtin"]           = { fg = c.entity },
  ["@module"]                 = { fg = c.entity },
  ["@keyword"]                = { fg = c.keyword },
  ["@keyword.function"]       = { fg = c.keyword },
  ["@keyword.return"]         = { fg = c.keyword },
  ["@keyword.import"]         = { fg = c.keyword },
  ["@operator"]               = { fg = c.punct },
  ["@punctuation"]            = { fg = c.punct },
  ["@punctuation.bracket"]    = { fg = c.punct },
  ["@punctuation.delimiter"]  = { fg = c.punct },
  ["@punctuation.special"]    = { fg = c.punct },
  ["@tag"]                    = { fg = c.entity }, -- components: <Component
  ["@tag.builtin"]            = { fg = c.entity }, -- HTML elements in JSX/TSX: <div
  ["@tag.delimiter"]          = { fg = c.keyword }, -- < > </ />
  ["@tag.attribute"]          = { fg = c.fg },
  ["@markup.heading"]         = { fg = c.entity, bold = true },
  ["@markup.strong"]          = { bold = true },
  ["@markup.italic"]          = { italic = true },
  ["@markup.link"]            = { fg = c.green },
  ["@markup.link.url"]        = { fg = c.green, underline = true },
  ["@markup.raw"]             = { fg = c.string },

  -- LSP
  LspReferenceText            = { bg = c.word_hl },
  LspReferenceRead            = { bg = c.word_hl },
  LspReferenceWrite           = { bg = c.word_hl },
  LspInlayHint                = { fg = "#666666", bg = c.bg_alt },
  LspCodeLens                 = { fg = "#999999" },
  ["@lsp.type.variable"]      = { fg = c.fg },
  ["@lsp.type.property"]      = { fg = c.fg },
  ["@lsp.type.parameter"]     = { fg = c.fg },
  ["@lsp.type.function"]      = { fg = c.entity },
  ["@lsp.type.method"]        = { fg = c.entity },
  ["@lsp.type.class"]         = { fg = c.entity },
  ["@lsp.type.interface"]     = { fg = c.entity },
  ["@lsp.type.type"]          = { fg = c.entity },
  ["@lsp.type.namespace"]     = { fg = c.entity },
  ["@lsp.type.enum"]          = { fg = c.entity },
  ["@lsp.type.enumMember"]    = { fg = c.const },
  ["@lsp.type.comment"]       = { link = "Comment" },

  -- Diagnostics
  DiagnosticError             = { fg = c.red },
  DiagnosticWarn              = { fg = c.orange },
  DiagnosticInfo              = { fg = c.blue },
  DiagnosticHint              = { fg = c.green },
  DiagnosticOk                = { fg = c.green },
  DiagnosticUnderlineError    = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn     = { undercurl = true, sp = c.orange },
  DiagnosticUnderlineInfo     = { undercurl = true, sp = c.blue },
  DiagnosticUnderlineHint     = { undercurl = true, sp = c.green },
  DiagnosticVirtualTextError  = { fg = c.red, bg = "#2c2323" },
  DiagnosticVirtualTextWarn   = { fg = c.orange, bg = "#2e2820" },
  DiagnosticVirtualTextInfo   = { fg = c.blue, bg = "#232830" },
  DiagnosticVirtualTextHint   = { fg = c.green, bg = "#222a26" },
  DiagnosticVirtualLinesError = { fg = c.red, bg = "#2c2323" },
  DiagnosticVirtualLinesWarn  = { fg = c.orange, bg = "#2e2820" },
  DiagnosticVirtualLinesInfo  = { fg = c.blue, bg = "#232830" },
  DiagnosticVirtualLinesHint  = { fg = c.green, bg = "#222a26" },
  DiagnosticUnnecessary       = { fg = c.muted }, -- unused variables/imports

  -- gitsigns
  GitSignsUntracked           = { fg = c.dim }, -- whole-file "untracked" line
  GitSignsAdd                 = { fg = c.green },
  GitSignsChange              = { fg = c.blue },
  GitSignsDelete              = { fg = c.red },
  GitSignsCurrentLineBlame    = { fg = "#666666" },

  -- Telescope
  TelescopeNormal             = { fg = c.ui_fg, bg = c.bg_dark },
  TelescopeBorder             = { fg = c.dim, bg = c.bg_dark },
  TelescopePromptNormal       = { fg = c.ui_fg, bg = c.bg_alt },
  TelescopePromptBorder       = { fg = c.bg_alt, bg = c.bg_alt },
  TelescopePromptTitle        = { fg = c.bg_dark, bg = c.green },
  TelescopePreviewTitle       = { fg = c.bg_dark, bg = c.blue },
  TelescopeResultsTitle       = { fg = c.bg_dark, bg = c.dim },
  TelescopeSelection          = { bg = c.bg_alt, bold = true },
  TelescopeMatching           = { fg = c.green, bold = true },

  -- completion (nvim-cmp / blink.cmp)
  CmpItemAbbrMatch            = { fg = c.green, bold = true },
  CmpItemAbbrMatchFuzzy       = { fg = c.green },
  CmpItemAbbrDeprecated       = { fg = c.dim, strikethrough = true },
  CmpItemKind                 = { fg = c.entity },
  BlinkCmpMenu                = { link = "Pmenu" },
  BlinkCmpMenuSelection       = { link = "PmenuSel" },
  BlinkCmpLabelMatch          = { fg = c.green, bold = true },

  -- file trees
  NvimTreeNormal              = { fg = c.side_fg, bg = c.bg_dark },
  NvimTreeFolderName          = { fg = c.side_fg },
  NvimTreeOpenedFolderName    = { fg = c.ui_fg },
  NvimTreeRootFolder          = { fg = c.green, bold = true },
  NvimTreeIndentMarker        = { fg = "#2f363d" },
  NeoTreeNormal               = { fg = c.side_fg, bg = c.bg_dark },
  NeoTreeNormalNC             = { fg = c.side_fg, bg = c.bg_dark },

  -- indent-blankline / mini.indentscope
  IblIndent                   = { fg = "#383636" },
  IblScope                    = { fg = "#4d4b4b" },
  MiniIndentscopeSymbol       = { fg = "#4d4b4b" },
  SnacksIndentScope           = { fg = "#997a56", nocombine = true },

  -- Snacks Picker (grep / find files)
  SnacksPickerDir             = { fg = c.blue },
  SnacksPickerFile            = { fg = c.ui_fg, bold = true },
  SnacksPickerPath            = { fg = c.blue },
  SnacksPickerPathHidden      = { fg = c.muted },
  SnacksPickerPathIgnored     = { fg = c.dim },
  SnacksPickerMatch           = { fg = c.yellow, bold = true },
  SnacksPickerRow             = { fg = c.orange },
  SnacksPickerCol             = { fg = c.muted },

  -- Lualine
  lualine_a_insert            = { fg = c.bg_dark, bg = c.green, bold = true },
  lualine_z_insert            = { fg = c.bg_dark, bg = c.green },

  -- Incline
  InclineNormal               = { fg = c.fg, bg = c.bg_dark, bold = true },
  InclineNormalNC             = { fg = c.dim, bg = c.bg_alt },

  -- which-key, lazy, misc
  WhichKey                    = { fg = c.green },
  WhichKeyDesc                = { fg = c.ui_fg },
  WhichKeyGroup               = { fg = c.blue },
  LazyButton                  = { bg = c.bg_alt },
  LazyButtonActive            = { bg = c.green, fg = c.bg_dark },
}

for group, opts in pairs(groups) do hl(group, opts) end

-- Terminal palette
local term = {
  "#393a34", c.red, "#4ab888", c.yellow, c.blue, "#dc5a8c", c.cyan, "#dbd7ca",
  "#777777", c.red, c.green, c.yellow, c.blue, c.pink, c.cyan, "#ffffff",
}
for i, color in ipairs(term) do vim.g["terminal_color_" .. (i - 1)] = color end

vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

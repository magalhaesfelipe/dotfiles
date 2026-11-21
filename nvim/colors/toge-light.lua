-- toge-light: aged-paper (washi / xuan scroll) version of the toge Neovim colorscheme
-- Place at: ~/.config/nvim/colors/toge-light.lua  (Windows: ~\AppData\Local\nvim\colors\toge-light.lua)
-- Use:      vim.cmd.colorscheme("toge-light")

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.termguicolors = true
vim.o.background = "light"
vim.g.colors_name = "toge-light"

local c = {
  -- surfaces (aged paper)
  bg       = "#e9dbb4", -- editor.background
  bg_dark  = "#d9c898", -- sidebar / panels / statusline
  bg_alt   = "#e0d0a4", -- line highlight / inputs
  border   = "#c4b283",
  sel      = "#cbb986", -- selection
  -- text (sumi ink)
  fg       = "#231e18",
  ui_fg    = "#2e2720",
  side_fg  = "#4a4034",
  muted    = "#75684f",
  dim      = "#968766",
  gray     = "#6a6354",
  -- accents (mineral pigments)
  green    = "#3a6b4a", -- rokusho (malachite)
  blue     = "#2b4f7a", -- ai (indigo)
  orange   = "#9a5420", -- ochre
  red      = "#a02f25", -- shu (cinnabar)
  yellow   = "#7a5a0c", -- gamboge, darkened
  cyan     = "#2a6670",
  pink     = "#8f3a5c", -- plum
  -- syntax (tokenColors)
  comment  = "#6e6850", -- faded ink
  string   = "#8a4a1c",
  escape   = "#5c5444",
  const    = "#9a2f4a",
  entity   = "#3d6a3a",
  punct    = "#5c5444",
  keyword  = "#231e18", -- keywords left at fg; change here (e.g. "#a02f25") to taste
  -- diff / search
  diff_add = "#d2d9a8",
  diff_del = "#e2bfa0",
  diff_chg = "#c4cdbb",
  find     = "#e8c85a",
  find_cur = "#d4a93a",
  word_hl  = "#d4cfa0",
}

local function hl(group, opts) vim.api.nvim_set_hl(0, group, opts) end

local groups = {
  -- Editor UI
  Normal                     = { fg = c.fg, bg = c.bg },
  NormalNC                   = { fg = c.fg, bg = c.bg },
  NormalFloat                = { fg = c.ui_fg, bg = c.bg_dark },
  FloatBorder                = { fg = c.dim, bg = c.bg_dark },
  FloatTitle                 = { fg = c.ui_fg, bg = c.bg_dark, bold = true },
  Cursor                     = { fg = c.bg, bg = "#231e18" },
  CursorLine                 = { bg = c.bg_alt },
  CursorColumn               = { bg = c.bg_alt },
  ColorColumn                = { bg = c.bg_alt },
  LineNr                     = { fg = c.dim },
  CursorLineNr               = { fg = c.side_fg },
  SignColumn                 = { fg = c.dim, bg = c.bg },
  FoldColumn                 = { fg = c.muted, bg = c.bg },
  Folded                     = { fg = c.muted, bg = c.bg_dark },
  VertSplit                  = { fg = c.border },
  WinSeparator               = { fg = c.border },
  EndOfBuffer                = { fg = c.bg },
  NonText                    = { fg = "#d4c493" },
  Whitespace                 = { fg = "#d4c493" },
  SpecialKey                 = { fg = "#d4c493" },
  Visual                     = { bg = c.sel },
  VisualNOS                  = { bg = c.sel },
  Search                     = { bg = c.find },
  CurSearch                  = { bg = c.find_cur, fg = c.fg },
  IncSearch                  = { bg = c.find_cur, fg = c.fg },
  Substitute                 = { bg = c.find_cur, fg = c.fg },
  MatchParen                 = { bg = "#c3cf9f", bold = true },
  Directory                  = { fg = c.blue },
  Title                      = { fg = c.ui_fg, bold = true },
  ErrorMsg                   = { fg = c.red },
  WarningMsg                 = { fg = c.orange },
  MoreMsg                    = { fg = c.green },
  ModeMsg                    = { fg = c.side_fg },
  Question                   = { fg = c.green },
  WildMenu                   = { bg = c.bg_alt },
  QuickFixLine               = { bg = c.bg_alt },
  Conceal                    = { fg = c.dim },

  -- Statusline / tabline / winbar
  StatusLine                 = { fg = c.side_fg, bg = c.bg_dark },
  StatusLineNC               = { fg = c.gray, bg = c.bg_dark },
  TabLine                    = { fg = c.gray, bg = c.bg_dark },
  TabLineFill                = { bg = c.bg_dark },
  TabLineSel                 = { fg = c.ui_fg, bg = c.bg, bold = true },
  WinBar                     = { fg = c.ui_fg, bg = c.bg },
  WinBarNC                   = { fg = c.gray, bg = c.bg },

  -- Popup menu
  Pmenu                      = { fg = c.ui_fg, bg = c.bg_dark },
  PmenuSel                   = { fg = c.ui_fg, bg = c.sel, bold = true },
  PmenuSbar                  = { bg = c.bg_alt },
  PmenuThumb                 = { bg = c.dim },

  -- Diff
  DiffAdd                    = { bg = c.diff_add },
  DiffDelete                 = { fg = c.red, bg = c.diff_del },
  DiffChange                 = { bg = c.diff_chg },
  DiffText                   = { bg = "#a9bcc0" },
  Added                      = { fg = c.green },
  Removed                    = { fg = c.red },
  Changed                    = { fg = c.blue },

  -- Spell
  SpellBad                   = { undercurl = true, sp = c.red },
  SpellCap                   = { undercurl = true, sp = c.orange },
  SpellLocal                 = { undercurl = true, sp = c.blue },
  SpellRare                  = { undercurl = true, sp = c.cyan },

  -- Classic syntax groups
  Comment                    = { fg = c.comment },
  Constant                   = { fg = c.const },
  String                     = { fg = c.string },
  Character                  = { fg = c.const },
  Number                     = { fg = c.const },
  Boolean                    = { fg = c.const },
  Float                      = { fg = c.const },
  Identifier                 = { fg = c.fg },
  Function                   = { fg = c.entity },
  Statement                  = { fg = c.keyword },
  Conditional                = { fg = c.keyword },
  Repeat                     = { fg = c.keyword },
  Label                      = { fg = c.keyword },
  Operator                   = { fg = c.punct },
  Keyword                    = { fg = c.keyword },
  Exception                  = { fg = c.keyword },
  PreProc                    = { fg = c.keyword },
  Include                    = { fg = c.keyword },
  Define                     = { fg = c.keyword },
  Macro                      = { fg = c.keyword },
  PreCondit                  = { fg = c.keyword },
  Type                       = { fg = c.entity },
  StorageClass               = { fg = c.keyword },
  Structure                  = { fg = c.entity },
  Typedef                    = { fg = c.entity },
  Special                    = { fg = c.escape },
  SpecialChar                = { fg = c.escape },
  Tag                        = { fg = c.entity },
  Delimiter                  = { fg = c.punct },
  SpecialComment             = { fg = c.comment },
  Debug                      = { fg = c.orange },
  Underlined                 = { underline = true },
  Error                      = { fg = "#b01c34" },
  Todo                       = { fg = c.yellow, bold = true },

  -- Treesitter
  ["@comment"]               = { link = "Comment" },
  ["@string"]                = { fg = c.string },
  ["@string.regexp"]         = { fg = c.string },
  ["@string.escape"]         = { fg = c.escape },
  ["@string.special.symbol"] = { fg = c.string },
  ["@character"]             = { fg = c.const },
  ["@number"]                = { fg = c.const },
  ["@number.float"]          = { fg = c.const },
  ["@boolean"]               = { fg = c.const },
  ["@constant"]              = { fg = c.const },
  ["@constant.builtin"]      = { fg = c.const },
  ["@variable"]              = { fg = c.fg },
  ["@variable.builtin"]      = { fg = c.fg },
  ["@variable.parameter"]    = { fg = c.fg },
  ["@variable.member"]       = { fg = c.fg },
  ["@property"]              = { fg = c.fg },
  ["@function"]              = { fg = c.entity },
  ["@function.call"]         = { fg = c.entity },
  ["@function.method"]       = { fg = c.entity },
  ["@function.method.call"]  = { fg = c.entity },
  ["@function.builtin"]      = { fg = c.entity },
  ["@constructor"]           = { fg = c.entity },
  ["@type"]                  = { fg = c.entity },
  ["@type.builtin"]          = { fg = c.entity },
  ["@module"]                = { fg = c.entity },
  ["@keyword"]               = { fg = c.keyword },
  ["@keyword.function"]      = { fg = c.keyword },
  ["@keyword.return"]        = { fg = c.keyword },
  ["@keyword.import"]        = { fg = c.keyword },
  ["@operator"]              = { fg = c.punct },
  ["@punctuation"]           = { fg = c.punct },
  ["@punctuation.bracket"]   = { fg = c.punct },
  ["@punctuation.delimiter"] = { fg = c.punct },
  ["@punctuation.special"]   = { fg = c.punct },
  ["@tag"]                   = { fg = c.entity },  -- components: <Component
  ["@tag.builtin"]           = { fg = c.entity },  -- HTML elements in JSX/TSX: <div
  ["@tag.delimiter"]         = { fg = c.keyword }, -- < > </ />
  ["@tag.attribute"]         = { fg = c.fg },
  ["@markup.heading"]        = { fg = c.entity, bold = true },
  ["@markup.strong"]         = { bold = true },
  ["@markup.italic"]         = { italic = true },
  ["@markup.link"]           = { fg = c.green },
  ["@markup.link.url"]       = { fg = c.green, underline = true },
  ["@markup.raw"]            = { fg = c.string },

  -- LSP
  LspReferenceText           = { bg = c.word_hl },
  LspReferenceRead           = { bg = c.word_hl },
  LspReferenceWrite          = { bg = c.word_hl },
  LspInlayHint               = { fg = "#7d7358", bg = c.bg_alt },
  LspCodeLens                = { fg = "#6b6048" },
  ["@lsp.type.variable"]     = { fg = c.fg },
  ["@lsp.type.property"]     = { fg = c.fg },
  ["@lsp.type.parameter"]    = { fg = c.fg },
  ["@lsp.type.function"]     = { fg = c.entity },
  ["@lsp.type.method"]       = { fg = c.entity },
  ["@lsp.type.class"]        = { fg = c.entity },
  ["@lsp.type.interface"]    = { fg = c.entity },
  ["@lsp.type.type"]         = { fg = c.entity },
  ["@lsp.type.namespace"]    = { fg = c.entity },
  ["@lsp.type.enum"]         = { fg = c.entity },
  ["@lsp.type.enumMember"]   = { fg = c.const },
  ["@lsp.type.comment"]      = { link = "Comment" },

  -- Diagnostics
  DiagnosticError            = { fg = c.red },
  DiagnosticWarn             = { fg = c.orange },
  DiagnosticInfo             = { fg = c.blue },
  DiagnosticHint             = { fg = c.green },
  DiagnosticOk               = { fg = c.green },
  DiagnosticUnderlineError   = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn    = { undercurl = true, sp = c.orange },
  DiagnosticUnderlineInfo    = { undercurl = true, sp = c.blue },
  DiagnosticUnderlineHint    = { undercurl = true, sp = c.green },
  DiagnosticVirtualTextError = { fg = c.red, bg = "#e3c4aa" },
  DiagnosticVirtualTextWarn  = { fg = c.orange, bg = "#e4cf9c" },
  DiagnosticVirtualTextInfo  = { fg = c.blue, bg = "#cfd3b8" },
  DiagnosticVirtualTextHint  = { fg = c.green, bg = "#cdd6ae" },
  DiagnosticUnnecessary      = { fg = c.muted }, -- unused variables/imports

  -- gitsigns
  GitSignsUntracked          = { fg = c.dim }, -- whole-file "untracked" line
  GitSignsAdd                = { fg = c.green },
  GitSignsChange             = { fg = c.blue },
  GitSignsDelete             = { fg = c.red },
  GitSignsCurrentLineBlame   = { fg = "#7d7358" },

  -- Telescope
  TelescopeNormal            = { fg = c.ui_fg, bg = c.bg_dark },
  TelescopeBorder            = { fg = c.dim, bg = c.bg_dark },
  TelescopePromptNormal      = { fg = c.ui_fg, bg = c.bg_alt },
  TelescopePromptBorder      = { fg = c.bg_alt, bg = c.bg_alt },
  TelescopePromptTitle       = { fg = c.bg, bg = c.green },
  TelescopePreviewTitle      = { fg = c.bg, bg = c.blue },
  TelescopeResultsTitle      = { fg = c.bg, bg = c.muted },
  TelescopeSelection         = { bg = c.sel, bold = true },
  TelescopeMatching          = { fg = c.green, bold = true },

  -- completion (nvim-cmp / blink.cmp)
  CmpItemAbbrMatch           = { fg = c.green, bold = true },
  CmpItemAbbrMatchFuzzy      = { fg = c.green },
  CmpItemAbbrDeprecated      = { fg = c.dim, strikethrough = true },
  CmpItemKind                = { fg = c.entity },
  BlinkCmpMenu               = { link = "Pmenu" },
  BlinkCmpMenuSelection      = { link = "PmenuSel" },
  BlinkCmpLabelMatch         = { fg = c.green, bold = true },

  -- file trees
  NvimTreeNormal             = { fg = c.side_fg, bg = c.bg_dark },
  NvimTreeFolderName         = { fg = c.side_fg },
  NvimTreeOpenedFolderName   = { fg = c.ui_fg },
  NvimTreeRootFolder         = { fg = c.green, bold = true },
  NvimTreeIndentMarker       = { fg = c.border },
  NeoTreeNormal              = { fg = c.side_fg, bg = c.bg_dark },
  NeoTreeNormalNC            = { fg = c.side_fg, bg = c.bg_dark },

  -- indent-blankline / mini.indentscope
  IblIndent                  = { fg = "#d3c391" },
  IblScope                   = { fg = "#a3956c" },
  MiniIndentscopeSymbol      = { fg = "#a3956c" },
  SnacksIndentScope          = { fg = "#94702f", nocombine = true },

  -- Snacks Picker (grep / find files)
  SnacksPickerDir            = { fg = c.blue }, -- indigo pigment from toge palette; clear & readable on light bg
  SnacksPickerFile           = { fg = c.ui_fg, bold = true },
  SnacksPickerPath           = { fg = c.blue },
  SnacksPickerPathHidden     = { fg = c.muted },
  SnacksPickerPathIgnored    = { fg = c.dim },
  SnacksPickerMatch          = { fg = c.green, bold = true },
  SnacksPickerRow            = { fg = c.orange }, -- line numbers in ochre
  SnacksPickerCol            = { fg = c.muted },

  -- Lualine
  lualine_a_insert           = { fg = c.bg, bg = c.green, bold = true },
  lualine_z_insert           = { fg = c.bg, bg = c.green },

  -- which-key, lazy, misc
  WhichKey                   = { fg = c.green },
  WhichKeyDesc               = { fg = c.ui_fg },
  WhichKeyGroup              = { fg = c.blue },
  LazyButton                 = { bg = c.bg_alt },
  LazyButtonActive           = { bg = c.green, fg = c.bg },

  -- fff
  FFFNormal                  = { fg = c.ui_fg, bg = c.bg_dark },
  FFFBorder                  = { fg = c.dim, bg = c.bg_dark },
  FFFTitle                   = { fg = c.green, bg = c.bg_dark, bold = true },
  FFFCursor                  = { bg = c.sel },

}

for group, opts in pairs(groups) do hl(group, opts) end

-- Terminal palette
local term = {
  "#393a34", c.red, "#2e7a58", c.yellow, c.blue, c.pink, c.cyan, "#968766",
  "#75684f", c.red, c.green, c.yellow, c.blue, c.pink, c.cyan, "#4a4034",
}
for i, color in ipairs(term) do vim.g["terminal_color_" .. (i - 1)] = color end

vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

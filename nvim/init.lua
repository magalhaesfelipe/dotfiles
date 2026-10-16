-- ============================================================================
-- INIT.LUA - SINGLE-FILE NEOVIM CONFIG
-- ============================================================================

-- ----------------------------------------------------------------------------
-- LEADER KEYS (MUST BE SET BEFORE PLUGINS LOAD)
-- ----------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ----------------------------------------------------------------------------
-- OPTIONS
-- ----------------------------------------------------------------------------
local o = vim.opt

-- LINE NUMBERS (first, last, current, every 10th)
o.number = true
o.relativenumber = false

function _G.sparse_lnum()
  local lnum = vim.v.lnum
  local last = vim.api.nvim_buf_line_count(0)
  local cur = vim.api.nvim_win_get_cursor(0)[1]
  if vim.v.virtnum ~= 0 then return "" end -- wrapped lines
  if lnum == 1 or lnum == last or lnum == cur or lnum % 10 == 0 then
    return string.format("%" .. #tostring(last) .. "d", lnum)
  end
  return ""
end

o.statuscolumn = "%s%=%{v:lua.sparse_lnum()} "
-- LINE NUMBERS (first, last, current, every 10th)
o.number = true
o.relativenumber = false

function _G.sparse_lnum()
  local lnum = vim.v.lnum
  local last = vim.api.nvim_buf_line_count(0)
  local cur = vim.api.nvim_win_get_cursor(0)[1]
  if vim.v.virtnum ~= 0 then return "" end -- wrapped lines
  if lnum == 1 or lnum == last or lnum == cur or lnum % 10 == 0 then
    return string.format("%" .. #tostring(last) .. "d", lnum)
  end
  return ""
end

o.statuscolumn = "%s%=%{v:lua.sparse_lnum()} "-- INDENTATION
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

-- SEARCH
o.ignorecase = true
o.smartcase = true
o.hlsearch = true

-- UI
o.termguicolors = true
o.cursorline = true
o.signcolumn = "yes"
o.scrolloff = 8
o.wrap = false

-- BEHAVIOR
o.clipboard = "unnamedplus"
o.undofile = true
o.updatetime = 250
o.splitright = true
o.splitbelow = true

-- ----------------------------------------------------------------------------
-- KEYMAPS
-- ----------------------------------------------------------------------------
local map = vim.keymap.set

-- LEAVE INSERT MODE
map("i", "jk", "<Esc>")

-- FILE ACTIONS
map("n", "<leader>w", "<cmd>w<CR>", { desc = "SAVE FILE" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "QUIT" })

-- CLEAR SEARCH HIGHLIGHT
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- WINDOW NAVIGATION
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- MOVE SELECTED LINES
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- ----------------------------------------------------------------------------
-- AUTOCMDS
-- ----------------------------------------------------------------------------

-- HIGHLIGHT YANKED TEXT
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
})

-- ----------------------------------------------------------------------------
-- PLUGIN MANAGER (LAZY.NVIM BOOTSTRAP)
-- ----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ----------------------------------------------------------------------------
-- PLUGINS
-- ----------------------------------------------------------------------------
require("lazy").setup({

  -- COLORSCHEME
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      transparent_mode = true,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)    
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- CENTERED LAYOUT
  {
    "shortcuts/no-neck-pain.nvim",
    opts = { width = 100 },
  },

})

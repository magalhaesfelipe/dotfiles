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

-- LINE NUMBERS
o.number = true
o.relativenumber = true

-- INDENTATION
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
o.wrap = true
o.linebreak = true

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

-- CLEAR SEARCH WITH Esc
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ----------------------------------------------------------------------------
-- AUTOCMDS
-- ----------------------------------------------------------------------------

-- HIGHLIGHT YANKED TEXT
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
})

-- OPEN CONFIG FILE init.lua
vim.api.nvim_create_user_command("Config", "edit $MYVIMRC", { desc = "EDIT CONFIG" })

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
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "FILE TREE" },
    },
    opts = {
      view = { 
        width = 30,
        side = "right",
      },
      renderer = { icons = { show = { git = false } } },
    },
  },

  -- COLORSCHEME
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      transparent_mode = true,
    },
  },
  {
    "2nthony/vitesse.nvim",
      dependencies = { "tjdevries/colorbuddy.nvim" },
      priority = 1000,
      opts = { comment_italics = false, transparent_background = true },
  },

  -- CENTERED LAYOUT
  {
    "shortcuts/no-neck-pain.nvim",
    opts = { width = 100 },
  },

  -- SCROLLBARS (VERTICAL + HORIZONTAL)
  -- {
  --   "mihovilrak/scroll.nvim",
  --   opts = {},
  -- },
  
})
-- INDENTATION

-- KEYMAPS
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "SELECT ALL" })
vim.keymap.set("v", "<C-c>", "y", { desc = "COPY SELECTION" })
vim.keymap.set("n", "<C-BS>", "<cmd>e $MYVIMRC<CR>", { desc = "EDIT CONFIG" })
vim.keymap.set("n", "<leader>m", "<cmd>NoNeckPain<CR>", { desc = "TOGGLE NO-NECK-PAIN LAYOUT" })
vim.keymap.set("n", "<C-x>", "dd", { desc = "CUT LINE" })
vim.keymap.set("x", "<C-x>", "d", { desc = "CUT SELECTION" })
vim.keymap.set({ "n", "i", "x" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "SAVE FILE" })

vim.keymap.set("n", "<leader>t", '<cmd>botright split | resize 12 | terminal "C:/Program Files/Git/bin/bash.exe" -i<CR>', { desc = "OPEN SPLIT TERMINAL" })

-- INTERVAL LINE NUMBERS(10TH)
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

vim.opt.fillchars = { horiz = "─", horizup = "┴", horizdown = "┬", vert = "│", vertleft = "┤", vertright = "├", verthoriz = "┼" }

vim.cmd.colorscheme("custom-gruvbox")

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7d9b76", bg = "NONE" })

local map = vim.keymap.set

-- Leave insert mode
map("i", "jk", "<Esc>")

-- File actions
map("n", "<leader>w", "<cmd>w<CR>", { desc = "SAVE FILE" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "QUIT" })
map({ "n", "i", "x" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "SAVE FILE" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Editing helpers
map("n", "<C-a>", "ggVG", { desc = "SELECT ALL" })
map("v", "<C-c>", "y", { desc = "COPY SELECTION" })
map("n", "<C-x>", "dd", { desc = "CUT LINE" })
map("x", "<C-x>", "d", { desc = "CUT SELECTION" })

-- Config
map("n", "<C-BS>", "<cmd>e $MYVIMRC<CR>", { desc = "EDIT CONFIG" })

-- Layout / terminal
map("n", "<leader>m", "<cmd>NoNeckPain<CR>", { desc = "TOGGLE NO-NECK-PAIN LAYOUT" })
map("n", "<leader>t", '<cmd>botright split | resize 12 | terminal "C:/Program Files/Git/bin/bash.exe" -i<CR>', { desc = "OPEN SPLIT TERMINAL" })

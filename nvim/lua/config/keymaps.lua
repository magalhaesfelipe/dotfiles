local map = vim.keymap.set

-- Leave insert mode
map("i", "jk", "<Esc>")

-- File actions
map("n", "<leader>w", "<cmd>w<CR>", { desc = "SAVE FILE" })
map({ "n", "i", "x" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "SAVE FILE" })

-- Quit neovim
map("n", "<leader>q", "<cmd>q<CR>", { desc = "QUIT" })

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

-- Move current line up/down in Normal mode
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })

-- Move selected block up/down in Visual mode
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })

-- Toggle terminal
vim.keymap.set({ "n", "t" }, [[<C-\>]], "<cmd>ToggleTerm<CR>", { desc = "TOGGLE TERMINAL", silent = true })

-- Toggle the floating box with diagnostic, showing errors, warnings etc. 0_0 pretty useful
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end)
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end)

-- Oil vim - File explorer
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Git signs previews
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "Preview hunk inline" })
vim.keymap.set("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Toggle deleted lines" })
vim.keymap.set("n", "<leader>hd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff this" })

-- Git signs undo
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
vim.keymap.set("v", "<leader>hr", ":Gitsigns reset_hunk<cr>", { desc = "Reset selected lines" })

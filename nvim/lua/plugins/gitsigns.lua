return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "┃" },
      change       = { text = "┃" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    current_line_blame = false, -- set true for always-on blame
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)

    local gs = require("gitsigns")

    -- Navigation
    vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next Hunk" })
    vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Prev Hunk" })

    -- Stage / Reset
    vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
    vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
    vim.keymap.set("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Stage Selection" })
    vim.keymap.set("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Reset Selection" })
    vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
    vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
    vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })

    -- Preview
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
    vim.keymap.set("n", "<leader>hi", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })

    -- Blame
    vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
    vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })

    -- Diff
    vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
    vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff This ~" })

    -- Text object
    vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
  end,
}

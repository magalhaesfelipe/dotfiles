return {
  "andymass/vim-matchup",
  event = "VeryLazy",
  init = function()
    -- Optional: configure matchup if needed
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}

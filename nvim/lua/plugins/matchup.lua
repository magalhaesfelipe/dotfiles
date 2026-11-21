return {
  "andymass/vim-matchup",
  event = "VeryLazy",
  init = function()
    -- Defer highlighting until cursor stops moving (eliminates typing & scroll lag in TSX/JSX)
    vim.g.matchup_matchparen_deferred = 1
    -- Avoid floating popup windows when matching tags are offscreen during scroll
    vim.g.matchup_matchparen_offscreen = {}
    -- Do not continuously track surrounding matches
    vim.g.matchup_matchparen_hi_surround_always = 0
    -- Limit scan distance to prevent freezing on large trees
    vim.g.matchup_delim_stopline = 500
    -- Match calculation timeouts to prevent blocking UI
    vim.g.matchup_matchparen_timeout = 100
    vim.g.matchup_matchparen_insert_timeout = 50
  end,
}

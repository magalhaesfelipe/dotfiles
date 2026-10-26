return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    { "Kaiser-Yang/blink-cmp-dictionary", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  opts = {
    keymap = { preset = "enter" }, -- Enter accepts, Ctrl+n/p to navigate
    completion = {
      trigger = { show_on_blocked_trigger_characters = {} },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "dictionary", "kitty_values" },
      providers = {
        kitty_values = { name = "Kitty", module = "kitty.kitty_values", score_offset = 10 },
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          min_keyword_length = 2,
          opts = {
            dictionary_files = function()
              if vim.bo.filetype == "kitty" then
                return { vim.fn.expand("~/.config/nvim/dict/kitty.txt") }
              end
              return {}
            end,
          },
        },
      },
    },
  },
}

return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    { "Kaiser-Yang/blink-cmp-dictionary", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  opts = {
    -- Disable completion on non-code / notes files (.txt, .log, .raw, .todo)
    enabled = function()
      if vim.bo.buftype == "prompt" or vim.b.completion == false then
        return false
      end

      local disabled_filetypes = { "text", "plaintext", "log", "raw", "todo" }
      if vim.tbl_contains(disabled_filetypes, vim.bo.filetype) then
        return false
      end

      local bufname = vim.api.nvim_buf_get_name(0)
      local ext = vim.fn.fnamemodify(bufname, ":e"):lower()
      local disabled_extensions = { "txt", "log", "raw", "todo" }
      if vim.tbl_contains(disabled_extensions, ext) then
        return false
      end

      return true
    end,
    keymap = {
      preset = "default",
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-y>"] = { "select_and_accept" },
    },
    completion = {
      trigger = {
        -- Keep default blocked trigger characters (e.g. spaces/newlines)
        -- to prevent unnecessary completion requests while typing
      },
    },
    sources = {
      per_filetype = {
        text = {},
        plaintext = {},
        log = {},
        raw = {},
        todo = {},
      },
      -- "buffer" removed so random words previously typed are never suggested
      default = { "lsp", "path", "snippets", "dictionary", "kitty_values" },
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

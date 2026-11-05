return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "vtsls", "tailwindcss", "cssls", "html",
        "emmet_language_server", "eslint",
      },
    },
    config = function(_, opts)
      vim.lsp.config("eslint", {
        root_dir = function(bufnr, on_dir)
          local root = vim.fs.root(bufnr, {
            "eslint.config.js", "eslint.config.mjs",
            "eslint.config.cjs", "eslint.config.ts",
          })
          if root then on_dir(root) end
        end,
      })
      require("mason-lspconfig").setup(opts)
    end,
  },
  -- This is to stop nvim-lspconfig from re-enabling virtual text
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}

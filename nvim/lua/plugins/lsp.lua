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
  },
  -- Add this block to stop nvim-lspconfig from re-enabling virtual text
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}

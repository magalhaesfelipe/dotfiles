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
}

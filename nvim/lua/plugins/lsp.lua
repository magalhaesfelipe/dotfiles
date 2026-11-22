return {
  {
    "mason-org/mason.nvim",
    config = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "vtsls", "tailwindcss", "cssls", "html",
        "emmet_language_server", "eslint", "biome",
      },
    },
    config = function(_, opts)
      -- 1. Biome LSP: handles both linting diagnostics and code actions in Rust (much faster than ESLint)
      vim.lsp.config("biome", {
        root_dir = function(bufnr, on_dir)
          local root = vim.fs.root(bufnr, { "biome.json", "biome.jsonc" })
          if root then on_dir(root) end
        end,
      })

      -- 2. ESLint: only run on save, and skip entirely if project uses Biome
      vim.lsp.config("eslint", {
        root_dir = function(bufnr, on_dir)
          local is_biome = vim.fs.root(bufnr, { "biome.json", "biome.jsonc" })
          if is_biome then return end -- Use Biome instead of ESLint
          local root = vim.fs.root(bufnr, {
            "eslint.config.js", "eslint.config.mjs",
            "eslint.config.cjs", "eslint.config.ts",
            ".eslintrc.js", ".eslintrc.json",
          })
          if root then on_dir(root) end
        end,
        settings = {
          run = "onSave",
        },
      })

      -- 3. Disable vtsls formatting so it never conflicts with Biome
      vim.lsp.config("vtsls", {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      -- 4. Stop Tailwind from scanning every keystroke for inline color swatches
      vim.lsp.config("tailwindcss", {
        on_attach = function(client)
          client.server_capabilities.colorProvider = false
        end,
      })

      -- 5. Stop Emmet from firing completion requests inside JSX/TSX
      vim.lsp.config("emmet_language_server", {
        filetypes = { "html", "css", "scss", "less", "sass" },
      })

      require("mason-lspconfig").setup(opts)
    end,
  },
  -- Configure native Neovim diagnostics (floating window on hover, no shifting lines)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.diagnostics = opts.diagnostics or {}
      opts.diagnostics.virtual_text = false
      opts.diagnostics.virtual_lines = false
    end,
  },
}

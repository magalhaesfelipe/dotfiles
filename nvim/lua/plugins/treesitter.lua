return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "typescript", "tsx", "javascript", "html", "css", "json", "lua",
    })

    -- main branch doesn't auto-enable highlighting
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "typescript", "typescriptreact", "javascript", "javascriptreact",
        "html", "css", "json", "lua",
      },
      callback = function() vim.treesitter.start() end,
    })
  end,
}

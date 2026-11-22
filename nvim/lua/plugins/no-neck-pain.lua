return {
  "shortcuts/no-neck-pain.nvim",
  opts = {
    width = 86,
    autocmds = {
      enableOnVimEnter = "safe",
      enableOnTabEnter = true,
      reloadOnColorSchemeChange = true,
    },
    buffers = {
      right = {
        enabled = false,
      },
    },
    integrations = {
      NvimTree = { position = "right" },
    },
  },
}

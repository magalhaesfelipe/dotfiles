return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = "",
      section_separators = { left = "\u{e0b0}", right = "\u{e0b2}" },
    },
sections = {
  lualine_a = { "mode" },
  lualine_b = { { "branch", icon = "\u{e0a0}" }, "diff", "diagnostics" },
  lualine_c = {
    {
      "filetype",
      icon_only = true,
      padding = { right = 0, left = 2 },
    },
    { "filename", path = 1 },
    {
      "tabs",
      mode = 2,
      cond = function() return vim.fn.tabpagenr("$") > 1 end, -- only with 2+ tabs
      fmt = function(_, context)
        return vim.fn.fnamemodify(vim.fn.getcwd(-1, context.tabnr), ":t")
      end,
    },
  },
  lualine_x = { "progress", "location" },
  lualine_y = {
  {
    function() return os.date("%I:%M %p") end,
    icon = "",
    padding = { left = 1, right = 1 },
  },
},
  lualine_z = { function() return "\u{f007} " .. (vim.env.USER or "") end },
},
  },
}

local function get_theme()
  package.loaded["lualine.themes.auto"] = nil
  local auto = require("lualine.themes.auto")
  local is_dark = vim.o.background == "dark"
  local green = is_dark and "#4d9375" or "#3a6b4a"
  local fg = is_dark and "#121212" or "#e9dbb4"

  -- Override insert mode so mode and timer stay in theme's mineral green instead of orange
  auto.insert.a = { bg = green, fg = fg, gui = "bold" }
  auto.insert.z = { bg = green, fg = fg }
  return auto
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    -- Automatically reload lualine theme when switching between toge-light and toge-dark
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        pcall(function()
          require("lualine").setup({ options = { theme = get_theme() } })
        end)
      end,
    })
  end,
  opts = function()
    return {
      options = {
        theme = get_theme(),
        globalstatus = true,
        component_separators = "",
        section_separators = { left = "\u{e0b0}", right = "\u{e0b2}" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = { { "branch", icon = "\u{e0a0}" }, "diff", "diagnostics" },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            padding = { right = 0, left = 2 },
          },
          {
            "filename",
            path = 1,
            fmt = function(str)
              if vim.bo.filetype ~= "oil" then
                return str
              end
              local path = str:gsub("^oil://", "")
              local home = vim.env.HOME
              if home and path:sub(1, #home) == home then
                path = "~" .. path:sub(#home + 1)
              end
              return path
            end,
          },
          {
            "tabs",
            mode = 2,
            cond = function() return vim.fn.tabpagenr("$") > 1 end,
            fmt = function(_, context)
              return vim.fn.fnamemodify(vim.fn.getcwd(-1, context.tabnr), ":t")
            end,
          },
        },
        lualine_x = {

        },
        -- lualine_x = {
        --   {
        --     "location",
        --     separator = { left = "\u{e0b2}" },
        --     color = "lualine_b_normal",
        --   },
        --   {
        --     "progress",
        --     color = "lualine_b_normal",
        --   },
        -- },
        lualine_y = {}, -- disable default "progress"
        lualine_z = {
          {
            function() return os.date("%I:%M %p") end,
            icon = "\u{f017}",
            padding = { left = 1, right = 1 },
          },
        },
      },
      -- lualine_z = { function() return "\u{f007} " .. (vim.env.USER or "") end },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}

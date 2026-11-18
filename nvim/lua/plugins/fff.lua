return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  opts = {
    hl = {
      winhl =
      "Normal:FFFNormal,NormalFloat:FFFNormal,FloatBorder:FFFBorder,FloatTitle:FFFTitle,SignColumn:FFFNormal,FoldColumn:FFFNormal,EndOfBuffer:FFFNormal",
    },
  },
  lazy = false,
  keys = {
    { "ff", function() require("fff").find_files() end, desc = "FFFind files" },
    { "fg", function() require("fff").live_grep() end,  desc = "Live grep" },
  },
}

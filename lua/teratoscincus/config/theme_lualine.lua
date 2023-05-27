local colors = require("gruvbox-baby.colors").config()

return {
  normal = {
    a = { bg = colors.milk, fg = colors.dark, gui = "bold" },
    b = { bg = colors.medium_gray, fg = colors.milk },
    c = { bg = colors.background, fg = colors.milk },
  },
  insert = {
    a = { bg = colors.bright_yellow, fg = colors.dark, gui = "bold" },
    b = { bg = colors.medium_gray, fg = colors.milk },
    c = { bg = colors.background, fg = colors.milk },
  },
  visual = {
    a = { bg = colors.orange, fg = colors.dark, gui = "bold" },
    b = { bg = colors.medium_gray, fg = colors.milk },
    c = { bg = colors.background, fg = colors.milk },
  },
  replace = {
    a = { bg = colors.red, fg = colors.dark, gui = "bold" },
    b = { bg = colors.medium_gray, fg = colors.milk },
    c = { bg = colors.background, fg = colors.milk },
  },
  command = {
    a = { bg = colors.clean_green, fg = colors.dark, gui = "bold" },
    b = { bg = colors.medium_gray, fg = colors.milk },
    c = { bg = colors.background, fg = colors.milk },
  },
  inactive = {
    a = { bg = colors.dark_gray, fg = colors.gray, gui = "bold" },
    b = { bg = colors.dark_gray, fg = colors.gray },
    c = { bg = colors.dark_gray, fg = colors.gray },
  },
}

return {
  {
    "luisiacc/gruvbox-baby",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_baby_use_original_palette = true

      -- Text styles
      vim.g.gruvbox_baby_keyword_style = "NONE"
      vim.g.gruvbox_baby_function_style = "NONE"

      -- Override colors in colorscheme
      vim.g.gruvbox_baby_color_overrides = {
        foreground = "#EBDBB2", -- Softer foreground
        magenta = "#B16286",
        pink = "#D3869B",
        soft_yellow = "#D79921",
        forest_green = "#689d6a",
        light_gray = "#A89984", -- Added shade of gray
        light_blue = "#83a598",
        blue_gray = "#83a598",
      }

      -- Use above settings
      vim.cmd.colorscheme("gruvbox-baby")

      -- Override highlights

      local config = require("gruvbox-baby.config")
      local c = require("gruvbox-baby.colors")
      local colors = c.config(config)

      -- Color variables
      local primary = colors.bright_yellow
      local cursor_line = "#2D2D2D" -- Slightly lighter than bg
      local floating_window_bg = colors.background
      local search_match_fg = colors.magenta

      -- Diagnostic underline color an style
      local diagnostic_underline_style = { sp = colors.error_red, undercurl = true }

      -- Syntax highlight colors and styles
      local boolean_style = { fg = colors.pink }
      local class_style = { fg = colors.bright_yellow }
      local constant_style = { fg = colors.pink, bold = true }
      local constructor_style = class_style
      local decorator_style = { fg = colors.bright_yellow, bold = true }
      local annotation_style = { fg = colors.clean_green, bold = true }
      local field_style = { fg = colors.foreground }
      local function_style = { fg = colors.clean_green }
      local function_builtin_style = { fg = colors.orange }
      local keyword_style = { fg = colors.red }
      local enum_style = keyword_style
      local lable_style = { fg = colors.light_blue }
      local method_style = { fg = colors.clean_green }
      local number_style = { fg = colors.pink }
      local operator_style = { fg = colors.clean_green }
      local parameter_style = { fg = colors.light_blue }
      local property_style = { fg = colors.light_blue }
      local punctuation_bracket_style = { fg = colors.magenta }
      local punctuation_delimiter_style = { fg = colors.light_gray }
      local punctuation_special_style = { fg = colors.light_gray } -- Like $ in bash
      local string_style = { fg = colors.soft_green }
      local type_style = { fg = colors.bright_yellow }
      local variable_style = { fg = colors.foreground }
      local variable_special_style = { fg = parameter_style.fg, italic = true }

      local hl = vim.api.nvim_set_hl

      -- Cursor and Line numbers
      hl(0, "Cursor", { bg = colors.foreground })
      hl(0, "MultiCursor", { bg = colors.foreground })
      hl(0, "CursorLine", { bg = cursor_line })
      hl(0, "CursorLineNR", { fg = primary, bold = true })
      hl(0, "LineNR", { fg = primary, bold = true })
      hl(0, "LineNrAbove", { fg = colors.comment })
      hl(0, "LineNrBelow", { fg = colors.comment })

      -- Floating windows and completion suggestions
      hl(0, "NormalFloat", { bg = floating_window_bg })
      hl(0, "FloatBorder", { bg = floating_window_bg, fg = primary })
      hl(0, "NullLsInfoBorder", { bg = floating_window_bg, fg = primary })
      hl(0, "LspInfoBorder", { bg = floating_window_bg, fg = primary })
      hl(0, "Pmenu", { bg = floating_window_bg, fg = primary })
      hl(0, "PmenuSel", { fg = primary, bold = true })
      hl(0, "CmpItemAbbrMatch", { fg = search_match_fg })
      hl(0, "CmpItemAbbrMatchFuzzy", { fg = search_match_fg })
      hl(0, "CmpItemKindClass", class_style)
      hl(0, "CmpItemKindConstant", constant_style)
      hl(0, "CmpItemKindField", field_style)
      hl(0, "CmpItemKindFunction", function_style)
      hl(0, "CmpItemKindKeyword", keyword_style)
      hl(0, "CmpItemKindMethod", method_style)
      hl(0, "CmpItemKindProperty", property_style)
      hl(0, "CmpItemKindVariable", variable_style)

      -- Window separator
      hl(0, "WinSeparator", { fg = primary })

      -- Override treesitter capture groups
      hl(0, "@lsp.type.enum", enum_style)
      hl(0, "@punctuation.delimiter", punctuation_delimiter_style)
      hl(0, "@punctuation.bracket", punctuation_bracket_style)
      hl(0, "@punctuation.special", punctuation_special_style)
      hl(0, "@operator", operator_style)
      hl(0, "@variable", variable_style)
      hl(0, "@lsp.type.variable", variable_style)
      hl(0, "@lsp.type.parameter.java", variable_style) -- Parameters in method code block
      hl(0, "@variable.builtin", variable_special_style)
      hl(0, "@lsp.type.property", property_style)
      hl(0, "@parameter", parameter_style)
      hl(0, "@lsp.type.parameter", parameter_style)
      hl(0, "@lsp.typemod.parameter.declaration.java", parameter_style)
      hl(0, "@field", field_style)
      hl(0, "@lsp.type.class", class_style)
      hl(0, "@decorator", decorator_style)
      hl(0, "@lsp.type.decorator", decorator_style)
      hl(0, "@attribute.python", decorator_style) -- Decorator
      hl(0, "@lsp.type.annotation.java", annotation_style)
      hl(0, "@type", type_style)
      hl(0, "@type.builtin", type_style)
      hl(0, "@boolean", boolean_style)
      hl(0, "@number", number_style)
      hl(0, "@float", number_style)
      hl(0, "@string", string_style)
      hl(0, "@constructor", constructor_style)
      hl(0, "@method", method_style)
      hl(0, "@lsp.type.method", method_style)
      hl(0, "@method.call", method_style)
      hl(0, "@function", function_style)
      hl(0, "@function.call", function_style)
      hl(0, "@lsp.type.function", function_style)
      hl(0, "@function.builtin", function_builtin_style)
      hl(0, "@lsp.typemod.function.defaultLibrary.lua", function_builtin_style)
      hl(0, "@label", lable_style)

      -- UI
      hl(0, "VirtColumn", { link = "IndentBlanklineChar" })
      hl(0, "MiniIndentscopeSymbol", { fg = colors.comment })

      -- Diagnostics
      hl(0, "DiagnosticError", { fg = colors.error_red })
      hl(0, "DiagnosticWarn", { fg = colors.soft_yellow })
      hl(0, "DiagnosticHint", { fg = colors.light_blue })
      hl(0, "DiagnosticInfo", { fg = colors.foreground })
      hl(0, "DiagnosticOk", { fg = colors.forest_green })
      hl(0, "DiagnosticUnderlineError", diagnostic_underline_style)
      hl(0, "DiagnosticUnderlineWarn", diagnostic_underline_style)
      hl(0, "DiagnosticUnderlineInfo", diagnostic_underline_style)
      hl(0, "DiagnosticUnderlineHint", diagnostic_underline_style)

      -- Matching brackets
      hl(0, "MatchParen", {}) -- Disable style

      -- Rainbow-brackets
      hl(0, "TSRainbowGreen", { fg = "#98971a" }) -- Different to not confuse with string
      hl(0, "TSRainbowCyan", { fg = colors.forest_green })

      -- Telescope
      hl(0, "TelescopeBorder", { fg = primary })
      hl(0, "TelescopeMatching", { fg = search_match_fg })
      hl(0, "TelescopeSelection", { bg = floating_window_bg, fg = primary, bold = true })
      hl(0, "TelescopeSelectionCaret", { fg = primary, bold = true })
      hl(0, "TelescopePromptTitle", { bold = true })
      hl(0, "TelescopePromptPrefix", { fg = colors.comment })
      hl(0, "TelescopeResultsTitle", { bold = true })
      hl(0, "TelescopePreviewTitle", { bold = true })

      -- Harpoon
      hl(0, "HarpoonWindow", { bg = floating_window_bg })
      hl(0, "HarpoonBorder", { fg = primary, bold = true })

      -- Treesitter context
      hl(0, "TreesitterContext", { bg = cursor_line })
      hl(0, "TreesitterContextLineNumber", { bg = cursor_line, fg = colors.magenta, bold = true })

      -- Mason  -- TODO: Specify highlight groups

      -- Lazy plugin manager
      hl(0, "LazyButtonActive", { bg = colors.medium_gray, fg = colors.bright_yellow })
      hl(0, "LazyButton", { bg = cursor_line, fg = colors.soft_yellow })
      hl(0, "LazyH1", { bg = colors.medium_gray, fg = colors.bright_yellow })
      hl(0, "LazyH2", { fg = colors.soft_yellow, bold = true })
      hl(0, "LazySpecial", { fg = colors.comment })
    end,
  },
}

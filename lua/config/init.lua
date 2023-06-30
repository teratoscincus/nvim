local M = {}

-- Set colorscheme
-- Use name of lua file in the `nvim/lua/plugins/themes` directory to specify
-- colorscheme.
M.colorscheme = "gruvbox_baby"

M.window_border = "single" -- Options: "none", "single", "double", "rounded", "solid", "shadow"
local borderchars = {
  ["single"] = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  ["rounded"] = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
}
M.borderchars = borderchars[M.window_border]

M.diagnostic = {
  format = "[#{c}] #{m} (#{s})",
  options = {
    underline = true,
    virtual_text = true,
    signs = true,
  },
}

-- Icons used by plugins
M.icons = {
  diagnostics = {
    error = {
      Icon = " ", -- "✘ ", " ",
      Char = "E",
    },
    warn = {
      Icon = " ", -- "▲ ", " ",
      Char = "W",
    },
    hint = {
      Icon = " ", -- "⚑ ", " ",
      Char = "h",
    },
    info = {
      Icon = " ", -- " ", " ",
      Char = "i",
    },
  },
  git = {
    Added = " ",  -- " ",
    Modified = " ", -- " ",
    Removed = " ", -- " ",
  },
  mason = {
    Installed = "✓",
    Pending = "➜",
    Uninstalled = "✗",
  },
  current_buffer = {
    modified = "  ",
    readonly = "",
    unnamed = "",
  },
  kinds = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  },
}

return M

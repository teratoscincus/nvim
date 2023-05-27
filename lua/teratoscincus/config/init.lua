local M = {}

-- Set color sheme
-- Use name of lua file in the `nvim/lua/teratoscincus/plugins/themes` directory to
-- specify colorscheme
M.colorscheme = "gruvbox_baby"

-- Icons used by other plugins
M.icons = {
  diagnostics = {
    Error = " ", -- "✘ ", " ",
    Warn = " ", -- "▲ ", " ",
    Hint = " ", -- "⚑ ", " ",
    Info = " ", -- " ", " ",
  },
  git = {
    added = " ",  -- " ",
    modified = " ", -- " ",
    removed = " ", -- " ",
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

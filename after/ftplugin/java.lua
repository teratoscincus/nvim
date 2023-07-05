local o = vim.opt
local fo = vim.opt.formatoptions
-- local ol = vim.opt_local

o.expandtab = true
o.autoindent = true
o.smarttab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.colorcolumn = "101"

fo:remove("o")

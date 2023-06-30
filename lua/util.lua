local M = {}

-- Add individual values to desc field
M.opts = function(opts, desc)
  local _desc = { desc = desc }
  vim.tbl_extend("error", opts, _desc)
  return opts
end

return M

local M = {}

-- Add individual values to desc field
M.opts = function(opts, desc)
  local _desc = { desc = desc }
  return vim.tbl_extend("force", opts, _desc)
end

return M

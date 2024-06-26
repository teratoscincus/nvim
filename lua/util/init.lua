require("util.usercmds")

local M = {}

-- String manipulation

local function split(string, sep)
  local fields = {}

  local _sep = sep or " "
  local pattern = string.format("([^%s]+)", _sep)
  string.gsub(string, pattern, function(c)
    fields[#fields + 1] = c
  end)

  return fields
end

-- Filesystem

function M.is_git_root(dir)
  return vim.fn.isdirectory(dir .. "/.git") == 1
end

function M.get_git_root()
  local cwd = vim.loop.cwd()
  local git_root = nil

  if M.is_git_root(cwd) then
    git_root = cwd
  else
    for dir in vim.fs.parents(cwd) do
      if dir == os.getenv("HOME") then
        break
      end
      if M.is_git_root(dir) then
        git_root = dir
        break
      end
    end
  end

  return git_root
end

-- Creates directory if it doesn't exist
---@param path string Path to ensure existens of
---@return boolean true If `path` exists or was created successfully
function M.ensure_dir_exists(path)
  local child_path = path

  while true do
    if path == "" then
      return false
    end

    local stat = vim.loop.fs_stat(path) or {} -- Empty table if `path` exists
    if not vim.tbl_isempty(stat) then
      return true
    end

    local mode = 448
    if vim.loop.fs_mkdir(path, mode) then
      -- Directory created on first attempt
      if path == child_path then
        return true
      end
      -- Make sure children are created
      if vim.loop.fs_mkdir(child_path, mode) then
        return true
      end
    end

    child_path = path -- Save original path
    -- Create path for parent directory
    local split_char = "/"
    path = split(path, split_char)
    table.remove(path, #path)
    path = table.concat(path, split_char)
    path = split_char .. path -- Leading `split_char` get lost above
  end
end

-- Open file if it exists and is writable
function M.open_existing_writable(path_to_file)
  local success = false
  if vim.fn.filereadable(path_to_file) == 1 and vim.fn.filewritable(path_to_file) == 1 then
    vim.cmd.edit(path_to_file)
    success = true
  end
  return success
end

-- Keymap helpers

-- Add individual values to desc field of keymap opts
M.opts = function(opts, desc)
  opts.desc = desc
  return opts
end

-- Telescope helpers

-- Determine telescope layout dynamically
function M.telescope_layout_strategy()
  -- Min number of columns for horizontal layout to trigger.
  local columns_breakpoint = 140
  return vim.o.columns > columns_breakpoint and "horizontal" or "vertical"
end

-- Returns function calling a telescope builtin
function M.telescope(builtin, opts) -- Inspired by lazyvim
  return function()
    require("telescope.builtin")[builtin](
      vim.tbl_deep_extend("force", { layout_strategy = M.telescope_layout_strategy() }, opts or {})
    )
  end
end

return M

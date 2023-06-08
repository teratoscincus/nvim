-- Bootstrap lazy.nvim
-- Ensures the plugin manager is installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local defaults = require("teratoscincus.config")

-- Manage plugins
require("lazy").setup({
  spec = {
    -- Any lua file in the /nvim/lua/teratoscincus/plugins/ directory will be
    -- automatically merged in the main plugin spec.
    { import = "teratoscincus.plugins" },
  },
  install = {
    colorscheme = { "gruvbox-baby" },
  },
  ui = {
    border = defaults.window_border,
  },
})

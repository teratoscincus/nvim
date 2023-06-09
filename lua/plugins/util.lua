local defaults = require("config")

return {
  -- Measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Session management
  {
    "Shatur/neovim-session-manager",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local Path = require("plenary.path")
      require("session_manager").setup({
        sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),             -- The directory where the session files will be saved.
        path_replacer = "__",                                                    -- The character to which the path separator will be replaced for session files.
        colon_replacer = "++",                                                   -- The character to which the colon symbol will be replaced for session files.
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: `Disabled`, `CurrentDir`, `LastSession`
        autosave_last_session = true,                                            -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true,                                       -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_dirs = {},                                               -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = {                                            -- All buffers of these file types will be closed before the session is saved.
          "gitcommit",
        },
        autosave_ignore_buftypes = {},    -- All buffers of these bufer types will be closed before the session is saved.
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80,             -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
      })
      -- Keybinds
      local sm = require("session_manager")
      vim.keymap.set("n", "<leader>os", sm.load_last_session, { desc = "Resume last session" })
      vim.keymap.set("n", "<leader>ls", sm.load_session, { desc = "List sessions" })
    end,
  },

  -- Library used by other plugins
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- Keymaps helper
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      wk.setup({
        window = {
          border = defaults.window_border,
        },
      })
      wk.register({ -- TODO: Decide on grouping prefixes and complete list
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>!"] = { name = "+diagnostics/quickfixes" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>o"] = { name = "+open" },
        ["<leader>t"] = { name = "+toggle" },
        ["<leader>l"] = { name = "+list" },
        ["<leader>g"] = { name = "+git" },
      })
    end,
  },

  -- Makes some plugins dot-repeatable like leap
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- Clipbord history
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      {
        "kkharji/sqlite.lua",
        module = "sqlite",
      },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      -- Filter out whitespace only yanks
      local function is_whitespace(line)
        return vim.fn.match(line, [[^\s*$]]) ~= -1
      end

      local function all(tbl, check)
        for _, entry in ipairs(tbl) do
          if not check(entry) then
            return false
          end
        end
        return true
      end

      -- Config
      require("neoclip").setup({
        filter = function(data)
          return not all(data.event.regcontents, is_whitespace)
        end,
      })

      -- Keybinds
      require("telescope").load_extension("neoclip")
      vim.keymap.set("n", "<leader>lc", ":Telescope neoclip<CR>", { desc = "List clipboard history" })
    end,
  },
}

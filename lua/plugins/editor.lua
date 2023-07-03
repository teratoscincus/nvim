local map = vim.keymap.set

return {
  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim", -- TODO: Change border chars
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          borderchars = require("config").borderchars,
          file_ignore_patterns = {
            "__pycache__/",
          },
        },
      })

      local builtin = require("telescope.builtin")
      local wk = require("which-key")

      -- Keymaps
      wk.register({
        ["<leader>f"] = {
          name = "+find",
          ["t"] = { name = "+Telescope" },
          ["g"] = { name = "+git" },
        },
      })

      -- Finding
      map("n", "<leader>ftr", builtin.resume, { desc = "Resume last Telescope picker" })
      map("n", "<leader>ftp", builtin.pickers, { desc = "Find prev Telescope pickers" })
      map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      map("n", "<leader>fs", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end, { desc = "Find string" })
      map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      map("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })

      -- Suggestions
      map("n", "<leader>!s", builtin.spell_suggest, { desc = "Spell suggest" })

      -- Git
      map("n", "<leader>fgf", builtin.git_files, { desc = "Find git files" })
      map("n", "<leader>fgc", builtin.git_commits, { desc = "Git commits diff preview" })
    end,
  },

  -- Quick switch between files
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      map("n", "<leader>fh", mark.add_file, { desc = "Harpoon file" })
      map("n", "<leader>oh", ui.toggle_quick_menu, { desc = "Harpoon explorer" })

      -- Select files in quick menu
      map("n", "<C-s>", function()
        ui.nav_file(1)
      end, { desc = "Harpoon 1" })
      map("n", "<C-t>", function()
        ui.nav_file(2)
      end, { desc = "Harpoon 2" })
      map("n", "<C-f>", function()
        ui.nav_file(3)
      end, { desc = "Harpoon 3" })
      map("n", "<C-p>", function()
        ui.nav_file(4)
      end, { desc = "Harpoon 4" })
    end,
  },

  -- Undo-version control branches
  {
    "mbbill/undotree",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      map("n", "<leader>tut", vim.cmd.UndotreeToggle, { desc = "Undotree" })
    end,
  },

  -- Diagnostics panel
  {
    "folke/trouble.nvim",
    opts = {
      auto_preview = false,
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Keymaps
      map("n", "<leader>!!", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true, desc = "Trouble" })
      map(
        "n",
        "<leader>!w",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true, desc = "Trouble workspace" }
      )
      map(
        "n",
        "<leader>!d",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true, desc = "Trouble document" }
      )
      map(
        "n",
        "<leader>!l",
        "<cmd>TroubleToggle loclist<cr>",
        { silent = true, noremap = true, desc = "Trouble local" }
      )
      map(
        "n",
        "<leader>!q",
        "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true, desc = "Trouble quickfix" }
      )
      map(
        "n",
        "<leader>!r",
        "<cmd>TroubleToggle lsp_references<cr>",
        { silent = true, noremap = true, desc = "Trouble LSP references" }
      )
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Surround brackets etc
  -- `:h nvim-surround.usage`
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Comment line toggle
  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup({
        comment_empty = false,
        create_mappings = false,
      })

      -- Keymaps
      map("n", "<leader>/", ":CommentToggle<cr>", { desc = "(Un)Comment line" })
      map("v", "<leader>/", ":'<,'>CommentToggle<cr>", { desc = "(Un)Comment visual selection" })
    end,
  },
}

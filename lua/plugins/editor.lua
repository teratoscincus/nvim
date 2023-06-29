return {
  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      -- Keymaps
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) -- (f)uzzy (f)ind project files
      vim.keymap.set("n", "<leader>fg", builtin.git_files, {})  -- (f)uzzy find (g)it files
      vim.keymap.set("n", "<leader>fs", function()              -- (f)uzzy (s)tring project files search
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})   -- (f)uzzi find (b)uffers
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {}) -- (f)uzzy find (h)elp
    end,
  },

  -- Quick switch between files
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>ha", mark.add_file)        -- (h)arpoon (a)dd
      vim.keymap.set("n", "<leader>he", ui.toggle_quick_menu) -- (h)arpoon (e)xplore

      -- Select files in quick menu
      vim.keymap.set("n", "<C-s>", function()
        ui.nav_file(1)
      end)
      vim.keymap.set("n", "<C-t>", function()
        ui.nav_file(2)
      end)
      vim.keymap.set("n", "<C-f>", function()
        ui.nav_file(3)
      end)
      vim.keymap.set("n", "<C-p>", function()
        ui.nav_file(4)
      end)
    end,
  },

  -- Undo-version control branches
  {
    "mbbill/undotree",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.keymap.set("n", "<leader>tut", vim.cmd.UndotreeToggle) -- (t)oggle (u)ndo (t)ree
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
      vim.keymap.set("n", "<leader>!!", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
      vim.keymap.set(
        "n",
        "<leader>!w",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set(
        "n",
        "<leader>!d",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>xlsp", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
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
        -- Keymapings
        line_mapping = "gcc",             -- Normal mode mapping left hand side
        operator_mapping = "gc",          -- Visual/Operator mapping left hand side
        comment_chunk_text_object = "ic", -- text object mapping, comment chunk
      })
    end,
  },
}

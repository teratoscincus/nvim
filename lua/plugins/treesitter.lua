return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- Last release is old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
          local opts = require("lazy.core.plugin").values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then
            require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          end
        end,
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "html",
        "htmldjango",
        "css",
        "javascript",
        "typescript",
        "tsx",

        "python",
        "go",
        "java",
        "kotlin",

        "sql",

        "bash",

        "dockerfile",

        "json",
        "yaml",
        "toml",

        "markdown",
        "markdown_inline",

        "query",
        "regex",

        "lua",
        "luadoc",
        "luap",
        "vim",
        "help",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/playground",
    config = function()
      require("nvim-treesitter.configs").setup({})
    end,
  },

  -- Rainbow-brackets
  {
    "HiPhish/nvim-ts-rainbow2",
    config = function()
      require("nvim-treesitter.configs").setup({
        rainbow = {
          enable = true,
          -- Disable plugin for these languages
          disable = {
            "html",
            "htmldjango",
            "markdown",
            "markdown_inline",
          },
          -- Which query to use for finding delimiters
          query = "rainbow-parens",
          -- Highlight the entire buffer all at once
          strategy = require("ts-rainbow").strategy.global,
          hlgroups = {
            "TSRainbowViolet",
            "TSRainbowBlue",
            "TSRainbowCyan",
            "TSRainbowGreen",
            "TSRainbowYellow",
            "TSRainbowOrange",
          },
        },
      })
    end,
  },

  -- Context
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
}

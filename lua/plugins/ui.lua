return {
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(plugin)
      local icons = require("config").icons

      return {
        options = {
          theme = function()
            local colors = require("gruvbox-baby.colors").config(require("gruvbox-baby.config"))

            return {
              normal = {
                a = { bg = colors.milk, fg = colors.dark, gui = "bold" },
                b = { bg = colors.medium_gray, fg = colors.milk },
                c = { bg = colors.background, fg = colors.milk },
              },
              insert = {
                a = { bg = colors.secondary, fg = colors.dark, gui = "bold" },
                b = { bg = colors.medium_gray, fg = colors.milk },
                c = { bg = colors.background, fg = colors.milk },
              },
              visual = {
                a = { bg = colors.orange, fg = colors.dark, gui = "bold" },
                b = { bg = colors.medium_gray, fg = colors.milk },
                c = { bg = colors.background, fg = colors.milk },
              },
              replace = {
                a = { bg = colors.red, fg = colors.dark, gui = "bold" },
                b = { bg = colors.medium_gray, fg = colors.milk },
                c = { bg = colors.background, fg = colors.milk },
              },
              command = {
                a = { bg = colors.clean_green, fg = colors.dark, gui = "bold" },
                b = { bg = colors.medium_gray, fg = colors.milk },
                c = { bg = colors.background, fg = colors.milk },
              },
              inactive = {
                a = { bg = colors.dark_gray, fg = colors.gray, gui = "bold" },
                b = { bg = colors.dark_gray, fg = colors.gray },
                c = { bg = colors.dark_gray, fg = colors.gray },
              },
            }
          end,
          component_separators = "|", -- Suggestions: { left = "", right = ""}, "|"
          section_separators = "",    -- Suggestions: { left = "", right = ""}, ""
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diff",
              symbols = {
                added = icons.git.Added,
                modified = icons.git.Modified,
                removed = icons.git.Removed,
              },
            },
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = {
                left = 1,
                right = 0,
              },
            },
            {
              "filename",
              path = 1,
              symbols = {
                modified = icons.current_buffer.modified,
                readonly = icons.current_buffer.readonly,
                unnamed = icons.current_buffer.unnamed,
              },
            },
          },
          lualine_x = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.error.Icon,
                warn = icons.diagnostics.warn.Icon,
                info = icons.diagnostics.info.Icon,
                hint = icons.diagnostics.hint.Icon,
              },
            },
            {
              -- Display active LSP
              function()
                for _, client in ipairs(vim.lsp.get_active_clients()) do
                  if client.name ~= "null-ls" then
                    return client.name
                  end
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 1 } },
          },
          lualine_z = {
            { "location", padding = { left = 1, right = 1 } },
          },
        },
      }
    end,
  },

  -- Indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "▏", -- Suggestions: '|', '¦', '┆', '┊', '┃', '║', '▏'
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- Active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "▏", -- Suggestions: '|', '¦', '┆', '┊', '┃', '║', '▏'
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
    end,
  },

  -- Highlight all word matches under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({})
    end,
  },

  -- Vertical ruler
  {
    "lukas-reineke/virt-column.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("virt-column").setup({ char = "│" }) -- Suggestions: '▕', '│'
    end,
  },

  -- Todo-comments
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- Required
      "nvim-telescope/telescope.nvim", -- Optional
    },
    config = function()
      require("todo-comments").setup({})

      -- Keymaps
      local map = vim.keymap.set

      map("n", "<leader>fc", ":TodoTelescope keywords=TODO,FIX,FIXME,BUG,HACK<cr>", { desc = "Todo comments" })
    end,
  },

  -- Dim unused vars, functions, params, etc
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
      local background_color = require("gruvbox-baby.colors").config().background
      require("neodim").setup({
        alpha = 0.60,
        blend_color = background_color,
        update_in_insert = {
          enable = true,
          delay = 100,
        },
        hide = {
          virtual_text = true,
          signs = false,
          underline = true,
        },
      })
    end,
  },
  -- Colorizer
  {
    "NvChad/nvim-colorizer.lua",
    event = { "LspAttach", "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,          -- #RGB hex codes
          RRGGBB = true,       -- #RRGGBB hex codes
          names = false,       -- "Name" codes like Blue or blue
          RRGGBBAA = false,    -- #RRGGBBAA hex codes
          AARRGGBB = false,    -- 0xAARRGGBB hex codes
          rgb_fn = false,      -- CSS rgb() and rgba() functions
          hsl_fn = false,      -- CSS hsl() and hsla() functions
          css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false,                               -- Enable tailwind colors
          -- Parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
          virtualtext = "■",
          -- Update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false,
        },
        -- All the sub-options of filetypes apply to buftypes
        buftypes = {},
      })
    end,
  },
}

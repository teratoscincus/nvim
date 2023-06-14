-- Signs used in gutter
local Error_sign = "E"
local Warn_sign = "W"
local Hint_sing = "h"
local Info_sign = "i"

local Underline = true
local Virtual_text = true
local Signs = true

local Diagnostic_format = "[#{c}] #{m} (#{s})"

local defaults = require("teratoscincus.config")

return {
  -- Static language tools
  {
    -- Autoinstall linters and diagnostic tools used by `null-ls`.
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      { "jose-elias-alvarez/null-ls.nvim" }, -- Linting and diagnostics
      { "williamboman/mason.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      -- Mason config
      require("mason").setup({
        ui = {
          border = defaults.window_border,
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- Primary Source of Truth is null-ls
      -- Automatically install sources, but require manual config.
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      null_ls.setup({
        border = defaults.window_border,
        diagnostic_config = { underline = Underline, virtual_text = Virtual_text, signs = Signs },
        diagnostics_format = Diagnostic_format,
        -- Listed sources will be automatically installed by `mason-null-ls`.
        sources = {
          -- Shell script
          diagnostics.shellcheck,
          formatting.shellharden,
          formatting.shfmt,

          -- Lua
          diagnostics.luacheck.with({
            extra_args = { "--globals", "vim" },
          }),
          formatting.stylua,

          -- Python
          diagnostics.flake8.with({
            extra_args = { "--max-line-length", "88", "--ignore", "F401,E999" },
          }),
          formatting.isort,
          formatting.black,

          -- Django
          diagnostics.djlint.with({
            extra_args = { "--ignore", "H006", "H031" },
          }),
          formatting.djlint,

          -- Go
          diagnostics.golangci_lint,
          diagnostics.gospel,
          formatting.goimports_reviser,
          formatting.gofumpt,

          -- JS & TS
          diagnostics.eslint_d,
          formatting.prettier.with({
            extra_args = { "--single-quote", "false" },
          }),

          -- Java
          diagnostics.checkstyle.with({
            extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules.
          }),
          formatting.google_java_format,

          -- Kotlin
          diagnostics.ktlint,
          formatting.ktlint,

          -- Docker
          diagnostics.hadolint,

          -- Spelling
          diagnostics.misspell,
        },
        -- Sync Formatting
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })

      require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = true,
        automatic_setup = false,
      })
    end,
  },

  -- LSP
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },             -- Required
      { "williamboman/mason.nvim" },           -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Java specific LSP
      { "mfussenegger/nvim-jdtls" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },         -- Required
      { "hrsh7th/cmp-nvim-lsp" },     -- Required
      { "hrsh7th/cmp-buffer" },       -- Optional
      { "hrsh7th/cmp-path" },         -- Optional
      { "saadparwaiz1/cmp_luasnip" }, -- Optional
      { "hrsh7th/cmp-nvim-lua" },     -- Optional

      -- Snippets
      { "L3MON4D3/LuaSnip" },             -- Required
      { "rafamadriz/friendly-snippets" }, -- Optional

      -- Show function signatures as you type
      { "ray-x/lsp_signature.nvim" },
    },
    config = function()
      -- Mason
      -- Ensure LSPs are installed and setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          -- Available servers
          -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
          "html",
          "cssls",
          "tsserver",

          "pyright",
          "gopls",
          "jdtls", -- Needed for nvim-jdtls
          "kotlin_language_server",

          "bashls",
          "dockerls",
          "sqlls",

          "jsonls",
          "yamlls",
          "lemminx",

          "lua_ls",

          "marksman",
        },
      })

      -- LSP-Zero settings
      local lsp = require("lsp-zero").preset({
        name = "minimal",
        set_lsp_keymaps = true,
        manage_nvim_cmp = false,
        suggest_lsp_servers = true,
      })

      lsp.set_sign_icons({
        error = Error_sign,
        warn = Warn_sign,
        hint = Hint_sing,
        info = Info_sign,
      })

      -- (Optional) Configure lua language server for neovim
      lsp.nvim_workspace()

      -- Pyright config
      lsp.configure("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
            },
          },
        },
      })

      -- HTML config
      lsp.configure("html", {
        filetypes = { "html", "htmldjango" },
      })

      -- Skip specific LSP server setup
      -- Ignore jdtls in order for nvim-jdtls to have full control.
      lsp.skip_server_setup({ "jdtls" })

      lsp.setup()

      -- Diagnostic notifications
      vim.diagnostic.config({
        virtual_text = Virtual_text,
      })

      -- LSP_Signature settings
      require("lsp_signature").setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = defaults.window_border,
        },
        toggle_key = "<C-s>", -- Toggle signature on and off in insert mode
      })

      -- Nvim-CMP setup
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      luasnip.config.setup({})
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<Tab>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Insert,
          }),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        window = {
          completion = cmp.config.window.bordered({
            border = defaults.window_border,
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = defaults.window_border,
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
          }),
        },
      })

      -- Auto pairs
      --   Insert `(` after select function or method item
      --   Don’t use `nil` to disable a filetype. If a filetype is `nil` then `*` is
      --   used as fallback.
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local handlers = require("nvim-autopairs.completion.handlers")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
          filetypes = {
            ["*"] = {
              ["("] = {
                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method,
                },
                handler = handlers["*"],
              },
            },
            -- Disable for shellscripts
            sh = false,
            zsh = false,
          },
        })
      )

      -- Lsp UI
      require("lspconfig.ui.windows").default_options.border = defaults.window_border
    end,
  },
}

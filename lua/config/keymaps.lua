vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader> ", "l") -- Don't move two chars right on accidental SPACE

-- Disable defaults
map("n", "<CR>", "<Nop>") -- Prevent moving down on accidental ENTER

-- Quality of life bindings
map("n", "<leader>ex", vim.cmd.Ex, { desc = "Netrw" })
map("n", "<leader>w", ":w", { desc = "Write" })
map("n", "<leader>q", ":q", { desc = "Quit" })

-- Move blocks of code in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
map("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move block up" }) -- TODO: Does not work with more than one line

-- LSP
map("n", "<leader>!f", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open float" })
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Previous diagnostic" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic" })

-- Requires a language server to be attached
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = require("util").opts
    local _opts = { buffer = ev.buf }

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", "K", vim.lsp.buf.hover, opts(_opts, "Hover"))
    map("n", "<C-k>", vim.lsp.buf.signature_help, opts(_opts, "Signature help"))
    map("n", "gd", vim.lsp.buf.definition, opts(_opts, "Definition"))
    map("n", "gD", vim.lsp.buf.declaration, opts(_opts, "Declaration"))
    map("n", "go", vim.lsp.buf.type_definition, opts(_opts, "Type definition"))

    local wk = require("which-key")
    wk.register({
      mode = { "n", "v" },
      ["<leader>c"] = {
        name = "code",
      },
    })
    map("n", "<leader>cr", vim.lsp.buf.rename, opts(_opts, "Rename"))
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts(_opts, "Code action"))
    if vim.lsp.buf.range_code_action then
      map("v", "<leader>ca", vim.lsp.buf.range_code_action, opts(_opts, "Code action (range)"))
    else
      map("v", "<leader>ca", vim.lsp.buf.code_action, opts(_opts, "Code action"))
    end

    -- Telescope
    local builtin = require("telescope.builtin")
    wk.register({
      ["<leader>f"] = {
        name = "+find",
        ["l"] = { name = "+LSP" },
      },
    })
    map("n", "<leader>flt", builtin.treesitter, { desc = "Treesitter nodes" })
    map("n", "<leader>fli", builtin.lsp_implementations, opts(_opts, "Implementation"))
    map("n", "<leader>flr", builtin.lsp_references, opts(_opts, "References"))
  end,
})

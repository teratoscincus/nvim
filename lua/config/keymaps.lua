vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader> ", "l") -- Don't move two chars right on accidental SPACE

-- Disable defaults
map("n", "<CR>", "<Nop>") -- Prevent moving down on accidental ENTER

-- Quality of life bindings
map("n", "<leader>ex", vim.cmd.Ex) -- Go to (ex)plorer
map("n", "<leader>w", ":w")
map("n", "<leader>q", ":q")

-- Move blocks of code in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '>-2<CR>gv=gv") -- TODO: Does not work with more than one line

-- LSP
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
-- Requires a language server to be attached
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "go", vim.lsp.buf.type_definition, opts)
    map("n", "<leader>li", vim.lsp.buf.implementation, opts)
    map("n", "<leader>lr", vim.lsp.buf.references, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    if vim.lsp.buf.range_code_action then
      map("v", "<leader>ca", vim.lsp.buf.range_code_action, opts)
    else
      map("v", "<leader>ca", vim.lsp.buf.code_action, opts)
    end
  end,
})

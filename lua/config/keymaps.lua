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
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open float" })
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Previous diagnostic" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic" })
-- Requires a language server to be attached
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Add individual values to desc field
    local function opts(desc) -- TODO: refactor and use vim.tbl_extend()
      return { buffer = ev.buf, desc = desc }
    end

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- TODO: Add desscriptions
    map("n", "K", vim.lsp.buf.hover, opts("Hover"))
    map("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))
    map("n", "gd", vim.lsp.buf.definition, opts("Goto definition"))
    map("n", "gD", vim.lsp.buf.declaration, opts("Goto declaration"))
    map("n", "go", vim.lsp.buf.type_definition, opts("Goto type definition"))
    -- TODO: Conform below to initial key after SPACE
    map("n", "<leader>li", vim.lsp.buf.implementation, opts("List implementation"))
    map("n", "<leader>lr", vim.lsp.buf.references, opts("List references"))
    map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
    if vim.lsp.buf.range_code_action then
      map("v", "<leader>ca", vim.lsp.buf.range_code_action, opts("Code action (range)"))
    else
      map("v", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
    end
  end,
})

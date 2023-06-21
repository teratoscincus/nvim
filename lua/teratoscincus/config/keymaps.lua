vim.g.mapleader = " "

local key = vim.keymap.set

-- Disable defaults
key("n", "<CR>", "<Nop>") -- Prevent moving down on accidentay ENTER

-- Quality of life bindings
key("n", "<leader>ex", vim.cmd.Ex) -- Go to (ex)plorer
key("n", "<leader>w", ":w")
key("n", "<leader>q", ":q")

-- Move blocks of code in visual mode
key("v", "J", ":m '>+1<CR>gv=gv")
key("v", "K", ":m '>-2<CR>gv=gv") -- FIX: Does not work with more than one line

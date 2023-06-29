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

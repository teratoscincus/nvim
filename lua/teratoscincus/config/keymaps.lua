vim.g.mapleader = " "

vim.keymap.set("n", "<leader>ex", vim.cmd.Ex) -- Go to (ex)plorer

-- Move blocks of code in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv") -- FIX: Does not work with more than one line

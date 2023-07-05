return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    event = "BufRead",
    build = "cd app && npm install",
    config = function()
      local map = vim.keymap.set
      local wk = require("which-key")
      wk.register({
        ["<leader>om"] = {
          name = "+markdown",
        },
      })

      -- Keymaps
      map("n", "<leader>omp", "<cmd>MarkdownPreview<cr>", { desc = "Markdown preview" })
      map("n", "<leader>oms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop markdown preview" })
    end,
  },
}

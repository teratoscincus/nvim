return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    event = "BufRead",
    build = "cd app && npm install",
  },
}

return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn.system("cd " .. vim.fn.expand("~/.local/share/nvim/lazy/markdown-preview.nvim/app") .. " && npx --yes yarn install --frozen-lockfile")
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_browser = "termux-open-url"
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_theme = "dark"
    end,
  },
}

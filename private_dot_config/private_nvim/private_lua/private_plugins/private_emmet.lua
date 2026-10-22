return {
  -- Emmet LSP server configuration for blink.cmp autocompletion
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_language_server = {
          filetypes = {
            "html",
            "css",
            "scss",
            "sass",
            "less",
            "javascriptreact",
            "typescriptreact",
            "astro",
            "htmlangular",
          },
        },
      },
    },
  },

  -- nvim-emmet plugin for visual tag wrapping
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation, { desc = "Emmet: Wrap with Tag" })
    end,
  },
}

return {
  -- Tokyo Night colorscheme configuration
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon", -- Opciones: "moon" (por defecto en LazyVim), "night", "storm", "day"
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}

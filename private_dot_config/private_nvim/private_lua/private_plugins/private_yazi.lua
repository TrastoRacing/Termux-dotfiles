return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Yazi: Explorar archivo actual",
      },
      {
        "<leader>y",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Yazi: Abrir explorador",
      },
      {
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Yazi: Abrir en cwd del proyecto",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Yazi: Reanudar última sesión",
      },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}

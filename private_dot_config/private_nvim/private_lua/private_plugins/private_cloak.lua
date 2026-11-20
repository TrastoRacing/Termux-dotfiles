return {
  {
    "laytan/cloak.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "CloakEnable", "CloakDisable", "CloakToggle", "CloakPreviewLine" },
    keys = {
      { "<leader>uk", "<cmd>CloakToggle<cr>", desc = "Toggle Cloak (Secrets)" },
    },
    opts = {
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      patterns = {
        {
          file_pattern = {
            ".env*",
            "wrangler.toml",
            ".dev.vars",
          },
          cloak_pattern = "=.+",
        },
      },
    },
  },
}

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>n", group = "minimap", icon = { icon = "󰍍 ", color = "azure" } },
      },
    },
  },
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false,
    keys = {
      { "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle Minimap" },
      { "<leader>no", "<cmd>Neominimap Enable<cr>", desc = "Enable Minimap" },
      { "<leader>nc", "<cmd>Neominimap Disable<cr>", desc = "Disable Minimap" },
      { "<leader>nf", "<cmd>Neominimap Focus<cr>", desc = "Focus Minimap" },
      { "<leader>nu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus Minimap" },
      { "<leader>nr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh Minimap" },
    },
    init = function()
      -- Keep cursor offset from right edge to avoid overlap with floating minimap
      vim.opt.sidescrolloff = 28

      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = true,
        log_level = vim.log.levels.OFF,
        notification_level = vim.log.levels.WARN,

        layout = "float",
        float = {
          minimap_width = 20,
          max_minimap_height = nil,
          margin = {
            right = 0,
            top = 0,
            bottom = 0,
          },
          z_index = 1,
          window_border = "rounded",
        },

        -- Touch and pointer navigation optimized for tablets
        click = {
          enabled = true,
          auto_switch_focus = true,
        },

        -- Visual integrations
        diagnostic = {
          enabled = true,
          mode = "line",
        },
        git = {
          enabled = true,
          mode = "sign",
        },

        -- Exclude special buffers and tool windows to prevent layout collisions
        exclude_filetypes = {
          "help",
          "bigfile",
          "neo-tree",
          "yazi",
          "DiffviewFiles",
          "DiffviewFileHistory",
          "lazy",
          "mason",
          "trouble",
          "qf",
          "prompt",
          "dashboard",
          "snacks_dashboard",
        },
        exclude_buftypes = {
          "nofile",
          "nowrite",
          "quickfix",
          "terminal",
          "prompt",
        },
      }
    end,
  },
}

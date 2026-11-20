return {
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    keys = {
      {
        "<leader>xq",
        function()
          require("quicker").toggle()
        end,
        desc = "Quicker: Toggle Quickfix",
      },
      {
        "<leader>xl",
        function()
          require("quicker").toggle({ loclist = true })
        end,
        desc = "Quicker: Toggle Loclist",
      },
    },
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    },
  },
}

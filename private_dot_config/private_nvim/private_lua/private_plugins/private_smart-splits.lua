return {
  {
    "smart-splits-nvim/smart-splits.nvim",
    version = "^3.0.0",
    lazy = false, -- Required so @pane-is-vim is registered in Tmux on startup
    dependencies = {
      { "smart-splits-nvim/backend-tmux", main = "smart-splits-backend-tmux" },
    },
    opts = {
      mux = {
        backend = "smart-splits-backend-tmux",
        warn_if_unusable = false, -- Stay silent when opening Neovim outside Tmux
      },
      move = {
        at_edge = "wrap",
      },
      ignored_buftypes = { "nofile", "quickfix", "prompt" },
      ignored_filetypes = { "neo-tree", "yazi", "neominimap", "qf" },
    },
    keys = {
      -- Seamless navigation across Neovim splits and Tmux panes
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to left split/pane",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move to lower split/pane",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move to upper split/pane",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to right split/pane",
      },
      -- Unified resize (Alt + Shift + H/J/K/L, avoids collision with mini.move)
      {
        "<M-H>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize split/pane left",
      },
      {
        "<M-J>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize split/pane down",
      },
      {
        "<M-K>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize split/pane up",
      },
      {
        "<M-L>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize split/pane right",
      },
      -- Swap buffers across splits
      {
        "<leader>wH",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "Swap buffer left",
      },
      {
        "<leader>wJ",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "Swap buffer down",
      },
      {
        "<leader>wK",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "Swap buffer up",
      },
      {
        "<leader>wL",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "Swap buffer right",
      },
    },
  },
}

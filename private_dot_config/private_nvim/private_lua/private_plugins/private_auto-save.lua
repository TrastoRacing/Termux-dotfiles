return {
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      execution_message = {
        message = function()
          return "" -- Silent to avoid distracting notification popups
        end,
      },
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
        cancel_deferred_save = { "InsertEnter" },
      },
      condition = function(buf)
        local fn = vim.fn
        local buftype = fn.getbufvar(buf, "&buftype")
        if buftype ~= "" then
          return false
        end
        return true
      end,
      write_all_buffers = false,
      debounce_delay = 1000,
    },
    keys = {
      { "<leader>uv", "<cmd>ASToggle<cr>", desc = "Toggle Auto-Save" },
    },
  },
}

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable unused providers to avoid checkhealth warnings and improve startup speed
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Neovim 0.12+ native defaults
vim.o.winborder = "rounded" -- Native rounded borders for floating windows
vim.o.exrc = true -- Allow trusted project-local configs (.nvim.lua / .exrc)

-- Direct Android/Termux clipboard bridge (avoids probing X11/Wayland providers)
if
  not vim.env.SSH_CONNECTION
  and vim.fn.executable("termux-clipboard-set") == 1
  and vim.fn.executable("termux-clipboard-get") == 1
then
  vim.g.clipboard = {
    name = "termux-clipboard",
    copy = {
      ["+"] = "termux-clipboard-set",
      ["*"] = "termux-clipboard-set",
    },
    paste = {
      ["+"] = "termux-clipboard-get",
      ["*"] = "termux-clipboard-get",
    },
    cache_enabled = 1,
  }
end

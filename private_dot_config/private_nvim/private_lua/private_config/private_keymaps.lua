-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Neovim 0.12+ built-in textual Undotree
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>uu", "<cmd>Undotree<cr>", { desc = "Toggle Undotree (Built-in)" })

-- Neovim 0.12+ native :restart command
vim.keymap.set("n", "<leader>qr", "<cmd>restart<cr>", { desc = "Restart Neovim" })

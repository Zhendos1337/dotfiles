-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "gt", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "gT", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
for i = 1, 9 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    require("bufferline").go_to(i, true)
  end, { desc = "Go to buffer " .. i })
end

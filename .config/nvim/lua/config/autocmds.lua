-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Делаем окно Kitty полностью непрозрачным
    vim.fn.system("kitty @ set-background-opacity 1.0")
    -- Принудительно сбрасываем цвета Noctalia внутри nvim на чистый черный
    vim.fn.system("kitty @ set-colors background=#0c0f12")
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    -- При выходе возвращаем прозрачность 70%
    vim.fn.system("kitty @ set-background-opacity 0.7")
    -- Возвращаем управление цветами системе Noctalia
    vim.fn.system("kitty @ set-colors --reset")
  end,
})

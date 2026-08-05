-- bootstrap lazy.nvim, LazyVim and your plugins
print("jopa")
require("config.lazy")
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        -- 1. Для встроенных механизмов маппинга Vim: убираем кавычку из списка пар
        vim.opt_local.matchpairs:remove({ "':'" })
        
        -- 2. Если под капотом всё же спрятан mini.pairs (часто в LazyVim)
        vim.b.minipairs_disable = true

        -- 3. На всякий случай переопределяем ввод одинарной кавычки в режиме вставки,
        -- чтобы она печаталась как один символ без магии автопар
        vim.keymap.set("i", "'", "'", { buffer = true, noremap = true })
    end,
})


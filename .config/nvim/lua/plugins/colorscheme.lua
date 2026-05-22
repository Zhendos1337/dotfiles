return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",       -- Глубокий, плотный темный фон
      transparent = false,   -- ОТКЛЮЧАЕМ прозрачность внутри Neovim (1.1.1, 1.1.6)
      dim_inactive = false,  -- Запрещаем затухание окон
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      on_colors = function(c)
        -- Делаем фон Neovim сплошным черным, игнорируя блеклый цвет от Noctalia
        c.bg = "#0c0f12" 
        c.bg_sidebar = "#0c0f12"
        c.bg_statusline = "#0c0f12"
      end,
      on_highlights = function(hl, c)
        -- Принудительно делаем ключевые цвета яркими и сочными
        hl.Comment = { fg = "#737aa2", italic = true }   -- Аккуратные читаемые комментарии
        hl.Keyword = { fg = "#ff007f", bold = true }     -- Ярко-розовые ключевые слова (if, return)
        hl.Function = { fg = "#00f3ff", bold = true }    -- Насыщенные неоновые функции
        hl.String = { fg = "#b1ff29" }                   -- Салатовые строки
        hl.Variable = { fg = "#ffffff", bold = true }    -- Белоснежные переменные
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight", -- Применяем эту тему (1.1.2)
    },
  },
}

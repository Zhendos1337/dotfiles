return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",       -- Глубокий, плотный темный фон
      transparent = false,   -- ОТКЛЮЧАЕМ прозрачность внутри Neovim (1.1.1, 1.1.6)
      dim_inactive = false,  -- Запрещаем затухание окон
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      on_colors = function(c)
        -- c.bg = "#0c0f12" 
        -- c.bg_sidebar = "#0c0f12"
        -- c.bg_statusline = "#0c0f12"
      end,
      on_highlights = function(hl, c)
        hl.Comment = { fg = "#737aa2", italic = true }
        hl.Keyword = { fg = "#ff007f", bold = true }
        hl.Function = { fg = "#00f3ff", bold = true }
        hl.String = { fg = "#b1ff29" }
        hl.Variable = { fg = "#ffffff", bold = true }
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

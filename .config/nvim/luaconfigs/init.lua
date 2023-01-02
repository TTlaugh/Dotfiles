require("plugins")
require("options")
require("keymaps")
require("lsp")

-- Themes
local onedark = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }

require("onedark").setup({ style = onedark[4] })
require("onedark").load()

-- vim.cmd.colorscheme "tokyonight-moon"
-- tokyonight, tokyonight-day, tokyonight-moon, tokyonight-night, tokyonight-storm
-- catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

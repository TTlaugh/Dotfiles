require("core.options")

require("plugins")

require("core.mappings").load_mappings("general")
require("core.mappings").load_mappings("plugins")

require("core.colorschemes").colorscheme(3)
--[[
habamax is default colorscheme
[1]  onedark
[2]  tokyonight
[3]  tokyonight-moon
[4]  tokyonight-storm
[5]  tokyonight-night
[6]  tokyonight-day
[7]  catppuccin
[8]  catppuccin-mocha
[9]  catppuccin-latte
[10] catppuccin-frappe
[11] catppuccin-macchiato
]]

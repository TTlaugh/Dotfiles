require("core.options")

require("plugins")
require("core.autocmd")

require("core.mappings").load_mappings("general")
require("core.mappings").load_mappings("plugins")

require("core.colorschemes").colorscheme(2)
--[[ habamax is default colorscheme
[1]  tokyonight
[2]  tokyonight-moon
[3]  tokyonight-storm
[4]  tokyonight-night
[5]  tokyonight-day
]]

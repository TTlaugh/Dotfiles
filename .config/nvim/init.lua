require("core.options")

require("plugins")

require("core.mappings").load_mappings("general")
require("core.mappings").load_mappings("plugins")

require("core.colorschemes").colorscheme(3)
--[[ habamax is default colorscheme
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

vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("Startuptime", { clear = true }),
    pattern = "LazyVimStarted",
    callback = function()
        vim.cmd("echo '' | redraw")
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        vim.notify("⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms", vim.log.levels.INFO, { render = "minimal" })
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("AutoSourceTEST", { clear = true }),
    pattern = { "test.lua", "tmp.lua" },
    command = "source %",
})

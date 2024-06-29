require("core.options")

require("plugins")

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

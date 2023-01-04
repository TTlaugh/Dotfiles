-- Autocommand that reloads neovim config whenever you save every file in lua/ directory
local ex = vim.fn.expand
local autoreload_group = vim.api.nvim_create_augroup("AutoReload", { clear = true })
local nvim_path = ex("~") .. "/.config/nvim/"
vim.api.nvim_create_autocmd("BufWritePost", {
    group = autoreload_group,
    pattern = nvim_path .. "lua/*.lua",
    callback = function()
        if (ex('%:p') == nvim_path .. "lua/plugins.lua") then
            vim.cmd [[source <afile> | PackerCompile]]
        else
            vim.cmd [[source <afile>]]
        end
    end
})

require("plugins")
require("options")
require("keymaps")
require("lsp")
require("colorschemes").colorscheme(1)
require("snippets")

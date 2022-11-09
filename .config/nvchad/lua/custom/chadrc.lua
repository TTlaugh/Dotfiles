local M = {}

local override = require("custom.plugins.override")

M.plugins = {
    -- Add plugins
    user = require("custom.plugins"),

    -- Remove plugins
    remove = {
        -- "NvChad/nvterm",
    },

    -- Override default config of plugins
    override = {
        ["williamboman/mason.nvim"] = override.mason,
        ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
        ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
        ["NvChad/ui"] = override.ui,
    },
}

M.ui = {
    theme_toggle = { "catppuccin", "catppuccin_latte" },
    theme = "catppuccin", -- default theme
}

M.mappings = require("custom.mappings")

return M

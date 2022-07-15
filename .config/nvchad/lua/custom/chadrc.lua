local M = {}

-- UI
M.ui = {
    theme_toggle = { "catppuccin", "catppuccin_latte" },
    theme = "catppuccin", -- default theme

    tabufline = {
        enabled = true,
        lazyload = false,
        override = {},
    },
}

-- Plugins
M.plugins = {
    -- Add plugins
    user = {

        -- Markdown preview
        ["iamcco/markdown-preview.nvim"] = {
            run = function()
                vim.fn["mkdp#util#install"](0)
            end,
            ft = {
                "markdown",
            },
        },

        -- Git
        ["tpope/vim-fugitive"] = {},
        ["airblade/vim-gitgutter"] = {},

        -- Surround
        ["tpope/vim-surround"] = {},

        -- Cmake
        ["cdelledonne/vim-cmake"] = {
            config = function ()
                vim.g.cmake_link_compile_commands = 1
            end
        },

        -- ...
    },

    -- Remove plugins
    remove = {
        -- "NvChad/nvterm",
    },

    -- Override default config of plugins
    override = {
        -- Treesitter
        ["nvim-treesitter/nvim-treesitter"] = {
            ensure_installed = {
                "c",
                "cpp",
                "lua",
                "bash",
                "python",
            },
        },
        -- ...
    },

    options = {
        lspconfig = {
            setup_lspconf = "custom.plugins.lspconfig",
        },
    },
}

-- Mappings
M.mappings = require "custom.mappings"

return M

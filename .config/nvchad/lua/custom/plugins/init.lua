return {

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

    ["neovim/nvim-lspconfig"] = {
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.plugins.lspconfig"
        end,
    },

    -- ...
}

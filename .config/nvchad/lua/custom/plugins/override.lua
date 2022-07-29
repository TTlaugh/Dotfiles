local M = {}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",

        -- c/c++
        "clangd",

        -- python
        "pyright",

        -- shell
        "shellcheck",
    },
}

M.treesitter = {
    ensure_installed = {
        "c",
        "cpp",
        "lua",
        "bash",
        "python",
    },
}

M.nvimtree = {
    git = {
        enable = true,
    },
    view = {
        adaptive_size = false,
        side = "left",
        width = 25,
        hide_root_folder = false,
    },
}

M.ui = {
    tabufline = {
        lazyload = false, -- to show tabufline by default
    },
}

return M

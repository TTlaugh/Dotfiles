local M = {}

-- Disable default keys
M.disable = {
    t = {
        -- nvterm --
        ["<A-i>"] = "",
        -- ["<A-h>"] = "",
        -- ["<A-v>"] = "",
    },
    n = {
        -- nvterm --
        ["<A-i>"] = "",
        -- ["<A-h>"] = "",
        -- ["<A-v>"] = "",
        ["<leader>h"] = "",
        -- ["<leader>v"] = "",
    },
}

M.general = {
    n = {
        -- spellcheck
        ["<F4>"] = { "<cmd> setlocal spell! spelllang=en_us<cr>", "暈 spellcheck" },
        ["<leader><F4>"] = { "<cmd> normal! mz1z=`z<cr>", "Automatically fix misspelled word" },

        -- Use ALT+{h,j,k,l} to navigate windows from normal mode
        ["<A-h>"] = { "<C-w>h", " window left", opts = {noremap = true} },
        ["<A-l>"] = { "<C-w>l", " window right", opts = {noremap = true} },
        ["<A-j>"] = { "<C-w>j", " window down", opts = {noremap = true} },
        ["<A-k>"] = { "<C-w>k", " window up", opts = {noremap = true} },

        -- Resize split window
        ["<C-h>"] = { "<C-w>>", "Increase width", opts = {noremap = true} },
        ["<C-l>"] = { "<C-w><", "Decrease width", opts = {noremap = true} },
        ["<C-j>"] = { "<C-w>-", "Decrease height", opts = {noremap = true} },
        ["<C-k>"] = { "<C-w>+", "Increase height", opts = {noremap = true} },

        -- Toggle horiz/vert
        ["<leader>zv"] = { "<C-w>t<C-w>K", "vertically  horizonally" },
        ["<leader>zh"] = { "<C-w>t<C-w>H", "horizonally  vertically" },

        -- Open terminal in vertically split window (zsh)
        ["<leader>v"] = { "<cmd> vnew term://zsh<cr>", " built-in terminal" },
    },

    v = {
        ["<C-r>"] = { "\"hy:%s/<C-r>h//gc<left><left><left>", "﯒ find and replace in visual mode", opts = {noremap = true} },
    },

    t = {
        -- Use ALT+{h,j,k,l} to navigate windows from terminal mode
        ["<A-h>"] = { "<C-\\><C-N><C-w>h", " window left", opts = {noremap = true} },
        ["<A-l>"] = { "<C-\\><C-N><C-w>l", " window right", opts = {noremap = true} },
        ["<A-j>"] = { "<C-\\><C-N><C-w>j", " window down", opts = {noremap = true} },
        ["<A-k>"] = { "<C-\\><C-N><C-w>k", " window up", opts = {noremap = true} },
    },
}

M.markdown_preview = {
    n = {
        ["<leader>mp"] = { "<cmd> MarkdownPreviewToggle<cr>", "MarkdownPreviewToggle" },
    },
}

M.cmake = {
    n= {
        ["<leader>gg"] = { "<cmd> CMakeGenerate<cr>", "CMakeGenerate" },
        ["<leader>bb"] = { "<cmd> CMakeBuild<cr>", "CMakeBuild" },
        ["<leader>cx"] = { "<cmd> CMakeClose<cr>", "CMakeClose" },
    },
}

M.nvterm = {
    t = {
        -- toggle in terminal mode
        ["<A-f>"] = {
            function()
                require("nvterm.terminal").toggle "float"
            end,
            "   toggle floating term",
        },

        ["<A-c>"] = {
            function()
                require("nvterm.terminal").toggle "horizontal"
            end,
            "   toggle horizontal term",
        },

        ["<A-v>"] = {
            function()
                require("nvterm.terminal").toggle "vertical"
            end,
            "   toggle vertical term",
        },
    },

    n = {
        -- toggle in normal mode
        ["<A-f>"] = {
            function()
                require("nvterm.terminal").toggle "float"
            end,
            "   toggle floating term",
        },

        ["<A-c>"] = {
            function()
                require("nvterm.terminal").toggle "horizontal"
            end,
            "   toggle horizontal term",
        },

        ["<A-v>"] = {
            function()
                require("nvterm.terminal").toggle "vertical"
            end,
            "   toggle vertical term",
        },

        -- new

        ["<leader>`h"] = {
            function()
                require("nvterm.terminal").new "horizontal"
            end,
            "   new horizontal term",
        },

        ["<leader>`v"] = {
            function()
                require("nvterm.terminal").new "vertical"
            end,
            "   new vertical term",
        },
    },
}

return M

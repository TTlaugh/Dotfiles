-- vim:foldmethod=marker
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
return require("lazy").setup({

    -- {{{ Libraries
    { "https://github.com/nvim-lua/plenary.nvim" },
    { "https://github.com/kyazdani42/nvim-web-devicons" },
    -- }}}

    -- {{{ UI
    { "https://github.com/folke/tokyonight.nvim", lazy = false, priority = 1000 },
    { "https://github.com/navarasu/onedark.nvim", lazy = false },
    { "https://github.com/catppuccin/nvim", name = "catppuccin", lazy = false },

    { "https://github.com/rcarriga/nvim-notify",
        lazy = false, -- event = "VeryLazy",
        opts = {},
        config = function()
            vim.notify = require("notify")
        end
    },
    { "https://github.com/akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {},
    },
    { "https://github.com/nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                globalstatus = true,
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    { "https://github.com/lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            char = "▏",
            show_trailing_blankline_indent = false,
            show_first_indent_level = false,
            show_current_context = true,
            -- use_treesitter = true,
            filetype_exclude = {
                "python",
                "markdown",
                "lspinfo",
                "packer",
                "checkhealth",
                "help",
                "man",
                "",
            },
        },
    },
    { "https://github.com/folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        config = function()
            require("which-key").register({
                ["<leader>m"] = { name = "+markdown" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>f"] = { name = "+find/file" },
                ["<leader>t"] = { name = "+sw split type" },
                ["<leader>d"] = { name = "+dap" },
                ["<leader>w"] = { name = "+workspace" },
                ["<leader>c"] = { name = "+code/cmake" },
            })
        end,
    },
        -- }}}

    -- {{{ Syntax highlighting
    { "https://github.com/nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        opts = {
            ensure_installed = {
                "c",
                "cpp",
                "bash",
                "dockerfile",
                "go",
                "javascript",
                "json",
                "latex",
                "lua",
                "nix",
                "python",
                "rego",
                "rust",
                "typescript",
                "yaml",
                "markdown_inline",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    -- }}}

    -- {{{ Completion
    { "https://github.com/hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "https://github.com/L3MON4D3/LuaSnip",
                dependencies = { "https://github.com/rafamadriz/friendly-snippets" },
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            { "https://github.com/windwp/nvim-autopairs",
                event = "InsertEnter",
                opts = { check_ts = true },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)
                    require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
                end,
            },
            "https://github.com/hrsh7th/cmp-buffer",
            "https://github.com/hrsh7th/cmp-nvim-lsp",
            "https://github.com/hrsh7th/cmp-nvim-lua",
            "https://github.com/hrsh7th/cmp-path",
            "https://github.com/saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            return {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-c>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "path" },
                },
                -- window = {
                --     completion = cmp.config.window.bordered(),
                --     documentation = cmp.config.window.bordered(),
                -- },
            }
        end,
    },
    -- }}}

    -- {{{ IntelliSense
    { "https://github.com/neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate", "LspInfo", "LspLog" },
        dependencies = {
            { "https://github.com/williamboman/mason.nvim", build = ":MasonUpdate" },
            "https://github.com/williamboman/mason-lspconfig.nvim",
        },
        config = function ()
            require("plugins.configs.lsp")
        end
    },
    { "https://github.com/j-hui/fidget.nvim",
        event = "VeryLazy",
        version = "legacy",
        opts = {
            text = {
                spinner = "dots",
            },
        },
    },
    { "https://github.com/folke/trouble.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            height = 5,
            auto_open = true,
            auto_close = true,
            use_diagnostic_signs = true
        },
    },
    -- }}}

    -- {{{ Search
    { "https://github.com/nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
        opts = function()
            local actions = require("telescope.actions")
            return {
                defaults = {
                    path_display = { "absolute" },
                    file_ignore_patterns = { ".git/", "node_modules" },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case". The default case_mode is "smart_case"
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        no_ignore_parent = true,
                    },
                    buffers = {
                        sort_lastused = true,
                    },
                },
            }
        end,
    },
    -- }}}

    -- {{{ File Manager
    { "https://github.com/stevearc/oil.nvim",
        cmd = "Oil",
        opts = {
            view_options = {
                show_hidden = true,
            },
        },
        config = function(_, opts)
            require("oil").setup(opts)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "oil",
                callback = function(event)
                    vim.bo[event.buf].buflisted = false
                    vim.keymap.set("n", "q", "<cmd>bdelete<cr>", { buffer = event.buf, silent = true })
                end,
            }) -- Close oil with <q>
        end,
    },
    -- }}}

    -- {{{ Git
    { "https://github.com/lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = { "gitsigns.nvim" } }
                        end)
                    end
                end,
            })
        end,
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                require("core.mappings").load_mappings("gitsigns", { buffer = bufnr })
            end,
        },
    },
    -- }}}

    -- {{{ Debugging
    { "https://github.com/mfussenegger/nvim-dap",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            { "https://github.com/rcarriga/nvim-dap-ui", opts = {} }
        },
        config = function()
            require("plugins.configs.daps")
        end,
    },
    -- }}}

    -- {{{ Editing & motion
    { "https://github.com/numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            padding = true,     -- Add a space b/w comment and the line
            toggler = {         -- LHS of toggle mappings in NORMAL mode
                line = '\\\\',  -- Line-comment toggle keymap
                block = '||',   -- Block-comment toggle keymap
            },
            opleader = {        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
                line = '\\',    -- Line-comment keymap
                block = '|',    -- Block-comment keymap
            },
            extra = {           -- LHS of extra mappings
                above = '\\O',  -- Add comment on the line above
                below = '\\o',  -- Add comment on the line below
                eol = '\\A',    -- Add comment at the end of line
            },
        },
    },

    { "https://github.com/kylechui/nvim-surround",
        event = "VeryLazy",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        opts = {},
    },

    { "https://github.com/ggandor/leap.nvim",
        event = "VeryLazy",
        -- config = function()
        --     require('leap').add_default_mappings()
        -- end
    },
    -- }}}

    -- {{{ Miscellaneous
    { "https://github.com/norcalli/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
    },

    { "https://github.com/iamcco/markdown-preview.nvim",
        build = 'cd app && npm install',
        init = function() vim.g.mkdp_filetypes = { 'markdown' } end,
        ft = { 'markdown' },
    },

    { "https://github.com/cdelledonne/vim-cmake",
        cmd = { "CMakeGenerate", "CMakeBuild", "CMakeClose", "CMakeClean" },
        init = function() vim.g.cmake_link_compile_commands = 1 end,
    },
    -- }}}

},
{ -- Lazy opts
    defaults = { lazy = true },
    install = { colorscheme = { "habamax" } },
})

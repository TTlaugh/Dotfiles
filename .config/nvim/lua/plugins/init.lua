-- vvim:foldmethod=marker
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
return require("lazy").setup({

    -- {{{ Libraries
    { "https://github.com/nvim-lua/plenary.nvim" }, -- lua functions
    -- }}}

    -- {{{ UI
    { "https://github.com/folke/tokyonight.nvim", lazy = false, priority=1000, opts = {} },
    { "https://github.com/akinsho/bufferline.nvim", event = "VeryLazy", opts = {} },
    { "https://github.com/lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = { char = "▏", tab_char = "→", },
            scope = { enabled = false, },
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
                ["<leader>w"] = { name = "+workspace" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>b"] = { name = "+build" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
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
                "vimdoc",
                "c",
                "cpp",
                "cmake",
                "bash",
                "javascript",
                "java",
                "json",
                "lua",
                "python",
                "yaml",
                "markdown_inline",
            },
            highlight = { enable = true, },
            indent = { enable = true, },
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
                experimental = {
                    ghost_text = false,
                },
                -- window = {
                --     completion = cmp.config.window.bordered(),
                --     documentation = cmp.config.window.bordered(),
                -- },
            }
        end,
    },

    -- {{{ IntelliSense
    { "https://github.com/neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate", "LspInfo", "LspLog" },
        dependencies = {
            "https://github.com/williamboman/mason.nvim",
            "https://github.com/williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("plugins.configs.lsp")
        end
    },
    { "https://github.com/j-hui/fidget.nvim",
        event = "VeryLazy",
        opts = {},
    },
    -- }}}

    -- {{{ Search
    { "https://github.com/ibhagwan/fzf-lua",
        event = "VeryLazy",
        opts = {
            "max-perf",
            winopts = {
                height = 0.5,
                width = 1,
                row = 1,
            }
        },
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
                group = vim.api.nvim_create_augroup("close_oil", { clear = true }),
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
    { "https://github.com/tpope/vim-fugitive", cmd = "Git" },
    { "https://github.com/echasnovski/mini.diff", event = "VeryLazy", opts = {} },
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
        version = "*",
        opts = {},
    },
    { "https://github.com/ggandor/leap.nvim", event = "VeryLazy" },
    -- }}}

    -- {{{ AI
    -- { "https://github.com/Exafunction/codeium.vim",
    --     event = { "BufReadPost", "BufNewFile" },
    --     config = function()
    --         vim.g.codeium_manual = true
    --         vim.g.codeium_no_map_tab = true
    --         vim.g.codeium_filetypes = {
    --             TelescopePrompt = false,
    --         }
    --     end
    -- },
    -- }}}

    -- {{{ Miscellaneous
    { "https://github.com/norcalli/nvim-colorizer.lua", cmd = "ColorizerToggle" },

    { "https://github.com/iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- { "https://github.com/cdelledonne/vim-cmake",
    --     cmd = { "CMakeGenerate", "CMakeBuild", "CMakeClose", "CMakeClean" },
    --     init = function() vim.g.cmake_link_compile_commands = 1 end,
    -- },

},
    { -- Lazy opts
        defaults = { lazy = true },
        install = { colorscheme = { "habamax" } },
    })

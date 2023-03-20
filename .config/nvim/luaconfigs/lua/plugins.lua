-- Automatically install packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
        print "Cloning packer .."
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     command = "source <afile> | PackerCompile",
--     group = packer_group,
--     pattern = vim.fn.expand("plugins.lua"),
-- })

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)

    use({ "https://github.com/lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end
    })

    use({ "https://github.com/wbthomason/packer.nvim" }) -- Have packer manage itself

    use({ "https://github.com/nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins

    use({ "https://github.com/kyazdani42/nvim-web-devicons" })

    -- Colorschemes
    use({ "https://github.com/navarasu/onedark.nvim" })
    use({ "https://github.com/folke/tokyonight.nvim" })
    use({ "https://github.com/catppuccin/nvim", as = "catppuccin" })

    use({ "https://github.com/kyazdani42/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true,
                },
            })
        end,
    })

    use({ "https://github.com/akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup()
        end
    })
    use({ "https://github.com/nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                    -- theme = 'tokyonight',
                    component_separators = '|',
                    section_separators = '',
                },
            })
        end,
    })
    use({ "https://github.com/lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
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
            })
        end
    })

    -- Treesitter
    use({ "https://github.com/nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
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
            })
        end
    })

    -- Completion
    use({ "https://github.com/hrsh7th/nvim-cmp",
        requires = {
            "https://github.com/hrsh7th/cmp-buffer",
            "https://github.com/hrsh7th/cmp-nvim-lsp",
            "https://github.com/hrsh7th/cmp-nvim-lua",
            "https://github.com/hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
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
            })
        end
    })
    use({ "https://github.com/L3MON4D3/LuaSnip",
        require = {
            "https://github.com/saadparwaiz1/cmp_luasnip",
            "https://github.com/rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    })
    use({ "https://github.com/windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
            })
        end,
    })
    use({ "https://github.com/numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                padding = true,     ---Add a space b/w comment and the line
                toggler = {         ---LHS of toggle mappings in NORMAL mode
                    line = '\\\\',  ---Line-comment toggle keymap
                    block = '||',   ---Block-comment toggle keymap
                },
                opleader = {        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
                    line = '\\',    ---Line-comment keymap
                    block = '|',    ---Block-comment keymap
                },
                extra = {           ---LHS of extra mappings
                    above = '\\O',  ---Add comment on the line above
                    below = '\\o',  ---Add comment on the line below
                    eol = '\\A',    ---Add comment at the end of line
                },
            })
        end,
    })
    use({ "https://github.com/kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup()
        end
    })

    -- LSP
    use({ "https://github.com/neovim/nvim-lspconfig",
        requires = {
            "https://github.com/williamboman/mason.nvim",
            "https://github.com/williamboman/mason-lspconfig.nvim",
        },
    })
    use({ "https://github.com/j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({
                text = {
                    spinner = "dots",
                },
            })
        end,
    })

    -- Telescope
    use({ "https://github.com/nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
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
            })
        end,
    })
    use({ "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    })

    -- Git
    use({ "https://github.com/lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
            })
        end
    })
    use({ "https://github.com/tpope/vim-fugitive" })

    use({ "https://github.com/norcalli/nvim-colorizer.lua" })

    use({ "https://github.com/iamcco/markdown-preview.nvim",
        run = 'cd app && npm install',
        setup = function() vim.g.mkdp_filetypes = { 'markdown' } end,
        ft = { 'markdown' },
    })

    -- Cmake
    use({ "https://github.com/cdelledonne/vim-cmake",
        setup = function() vim.g.cmake_link_compile_commands = 1 end,
    })

    -- Vimspector
    -- use({ "https://github.com/puremourning/vimspector" })

    -- DAP
    use({ "https://github.com/mfussenegger/nvim-dap",
        requires = {
            "https://github.com/rcarriga/nvim-dap-ui",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.disconnect["dapui_config"] = function()
                dapui.close()
            end
        end,
    })
    use({
        "https://github.com/ravenxrz/DAPInstall.nvim",
        config = function()
            local dap_install = require("dap-install")
            dap_install.setup()
            dap_install.config("python", {})
            dap_install.config( "ccppr_vsc", { adapters = { id = 'cppdbg', }, })
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

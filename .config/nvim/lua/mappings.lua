local M = {}

M.load_mappings = function(section, mapping_opt)
    vim.schedule(function()
        local mappings = require("mappings")
        if type(section) == "string" then
            mappings = mappings[section]
        else
            mappings = mappings["general"]
        end
        if type(mappings) == "table" then
            for _, info in pairs(mappings) do
                local opts = vim.tbl_deep_extend("force", mapping_opt or {}, info.opts or {})
                opts.desc = info[4]
                vim.keymap.set(info[1], info[2], info[3], opts)
            end
        end
    end)
end

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-- Ex:
-- local opts = { silent = true, noremap = true }
-- { 'mode' , 'key', function, 'desciption', opts = opts },
-- { {mode} , 'key', function, 'desciption', opts = {} },
M.general = {
    { {'n', 'v'},'<Space>'         , '<Nop>'                                                                                           },
    { 'n'       ,'<leader>e'       , '<cmd> e $MYVIMRC<CR>'                     , '[E]dit init.lua'                                    },
    { 'n'       ,'<leader>sl'      , '<cmd> set list!<CR>'                      , '[S]how [L]istchars'                                 },
    { 'n'       ,'<F4>'            , '<cmd> setlocal spell! spelllang=en_us<CR>', '暈Built-in spell-checker'                           },
    { 'n'       ,'<leader><F4>'    , '<cmd> normal! mz1z=`z<CR>'                , ' Automatically fix misspelled word'                },
    { 'v'       ,'<C-r>'           , '"hy:%s/<C-r>h//gc<left><left><left>'      , '﯒ Find and replace selected words'                  },
    { 'v'       ,'<S-p>'           , '"_dP'                                     , 'Replace by new text but not copy old text'          },
    { 'v'       ,'<'               , '<gv-gv'                                   , 'Move the lines to the left'                         },
    { 'v'       ,'>'               , '>gv-gv'                                   , 'Move the lines to the right'                        },
    { 'v'       ,'<C-j>'           , ":move '>+1<CR>gv-gv"                      , ' Move the contents of the lines down'              },
    { 'v'       ,'<C-k>'           , ":move '<-2<CR>gv-gv"                      , ' Move the contents of the lines upwards'           },
    { {'t', 'i'},'<A-h>'           , '<C-\\><C-N><C-w>h'                        , ' Window  Left'                                    },
    { {'t', 'i'},'<A-j>'           , '<C-\\><C-N><C-w>j'                        , ' Window  Down'                                    },
    { {'t', 'i'},'<A-k>'           , '<C-\\><C-N><C-w>k'                        , ' Window  Up'                                      },
    { {'t', 'i'},'<A-l>'           , '<C-\\><C-N><C-w>l'                        , ' Window  Right'                                   },
    { 'n'       ,'<A-h>'           , '<C-w>h'                                   , ' Window  Left'                                    },
    { 'n'       ,'<A-j>'           , '<C-w>j'                                   , ' Window  Down'                                    },
    { 'n'       ,'<A-k>'           , '<C-w>k'                                   , ' Window  Up'                                      },
    { 'n'       ,'<A-l>'           , '<C-w>l'                                   , ' Window  Right'                                   },
    { 'n'       ,'<C-Up>'          , '<cmd> resize -2<CR>'                      , ' Resize horizontally'                              },
    { 'n'       ,'<C-Down>'        , '<cmd> resize +2<CR>'                      , ' Resize horizontally'                              },
    { 'n'       ,'<C-Left>'        , '<cmd> vertical resize -2<CR>'             , ' Resize vertically'                                },
    { 'n'       ,'<C-Right>'       , '<cmd> vertical resize +2<CR>'             , ' Resize vertically'                                },
    { 'i'       ,'<C-h>'           , '<Left>'                                   , ' Move Left'                                        },
    { 'i'       ,'<C-j>'           , '<Down>'                                   , ' Move Down'                                        },
    { 'i'       ,'<C-k>'           , '<Up>'                                     , ' Move Up'                                          },
    { 'i'       ,'<C-l>'           , '<Right>'                                  , ' Move Right'                                       },
    { 'n'       ,'<leader>th'      , '<C-w>t<C-w>H'                             , 'Switch to horizontal split'                         },
    { 'n'       ,'<leader>tk'      , '<C-w>t<C-w>K'                             , 'Switch to vertical split'                           },
    { 'n'       ,'<leader>tt'      , '<cmd> new term://zsh<CR>'                 , 'Open terminal in horiz split window (zsh)'          },
    { 'n'       ,'<C-x>'           , '<cmd> bdelete!<CR>'                       , 'Delete Buffer'                                      },
    { 'n'       ,'<C-h>'           , '<cmd> bprev<CR>'                          , 'Delete Buffer'                                      },
    { 'n'       ,'<C-l>'           , '<cmd> bnext<CR>'                          , 'Delete Buffer'                                      },
    { 'n'       ,'<leader><leader>', '<cmd> nohlsearch<CR>'                     , 'Turn off highlighting'                              },
    { 'n'       ,'[d'              , vim.diagnostic.goto_prev                   , 'Go to the previous diagnostic'                      },
    { 'n'       ,']d'              , vim.diagnostic.goto_next                   , 'Go to the next diagnostic'                          },
    { 'n'       ,'F'               , vim.diagnostic.open_float                  , 'Show the diagnostics in the floating window'        },
    { 'n'       ,'L'               , vim.diagnostic.setloclist                  , 'List all diagnostics'                               },
}

M.plugins = {
    { 'n'       ,'<leader>st'      , '<cmd> Telescope colorscheme enable_preview=true<CR>', '[S]witch [T]heme'                         },
    { 'n'       ,'<leader>/'       , '<cmd> Telescope current_buffer_fuzzy_find <CR>'     , '[/] Fuzzily search in current buffer'     },
    { 'n'       ,'<leader>?'       , '<cmd> Telescope oldfiles    <CR>'                   , '[?] Find recently opened files'           },
    { 'n'       ,'<leader><space>' , '<cmd> Telescope buffers     <CR>'                   , '[ ] Find existing buffers'                },
    { 'n'       ,'<leader>sf'      , '<cmd> Telescope find_files  <CR>'                   , '[S]earch [F]iles'                         },
    { 'n'       ,'<leader>sh'      , '<cmd> Telescope help_tags   <CR>'                   , '[S]earch [H]elp'                          },
    { 'n'       ,'<leader>sw'      , '<cmd> Telescope grep_string <CR>'                   , '[S]earch current [W]ord'                  },
    { 'n'       ,'<leader>sg'      , '<cmd> Telescope live_grep   <CR>'                   , '[S]earch by [G]rep'                       },
    { 'n'       ,'<leader>sd'      , '<cmd> Telescope diagnostics <CR>'                   , '[S]earch [D]iagnostics'                   },
    { 'n'       ,'<leader>sk'      , '<cmd> Telescope keymaps     <CR>'                   , '[S]how [K]eymaps'                         },
    { 'n'       ,'<leader>gc'      , '<cmd> Telescope git_commits <CR>'                   , '[G]it [C]ommits'                          },
    { 'n'       ,'<leader>gs'      , '<cmd> Telescope git_status  <CR>'                   , '[G]it [S]tatus'                           },
    { 'n'       ,'<leader>:'       , '<cmd> Telescope commands    <CR>'                   , '[:] Lists available plugin/user commands' },
    -- colorizer
    { 'n'       , '<leader>h'      , '<cmd> ColorizerToggle<CR>'                          , '[C]olorizer'                              },
    -- oil
    { 'n'       , '-'              , '<cmd> Oil --float<CR>'                              , '[O]il file explorer'                      },
    -- markdownpreview
    { 'n'       , '<leader>mp'     , '<cmd> MarkdownPreviewToggle<CR>'                    , '[M]arkdown [P]review'                     },
    -- cmake
    { 'n'       , '<leader>gg'     , '<cmd> CMakeGenerate<CR>'                            , '[G]enerate build system'                  },
    { 'n'       , '<leader>bb'     , '<cmd> CMakeBuild<CR>'                               , '[B]uild a project'                        },
    { 'n'       , '<leader>cx'     , '<cmd> CMakeClose<CR>'                               , '[C]lose Cmake console window'             },
    -- dap
    { 'n'       , '<A-Left>'       , '<cmd> DapContinue<CR>'                              , ' DAP: Start/Continue'                    },
    { 'n'       , '<A-Right>'      , '<cmd> DapStepOver<CR>'                              , ' DAP: Step Over'                         },
    { 'n'       , '<A-Down>'       , '<cmd> DapStepInto<CR>'                              , ' DAP: Step Into'                         },
    { 'n'       , '<A-Up>'         , '<cmd> DapStepOut<CR>'                               , ' DAP: Step Out'                          },
    { 'n'       , '<leader>db'     , '<cmd> DapToggleBreakpoint<CR>'                      , ' DAP: Breakpoint Toggle'                 },
    { 'n'       , '<leader>dx'     , '<cmd> DapTerminate<CR>'                             , ' DAP: Terminate'                         },
    { 'n'       , '<leader>dr'     , '<cmd> DapToggleRepl<CR>'                            , ' DAP: Opens the REPL'                    },
    { 'n'       , '<leader>du'     , '<cmd> lua require"dapui".toggle()<CR>'              , ' DAP: UI Toggle'                         },
    { 'n'       , '<leader>dl'     , '<cmd> lua require"dap".run_last()<CR>'              , ' DAP: Re-runs the last debug adapter'    },
}

M.gitsigns = {
    { 'n'       , ']c',
        function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() require("gitsigns").next_hunk() end)
            return "<Ignore>"
        end ,
        'Jump to next hunk',
        opts = { expr = true },
    },
    { 'n'       , '[c',
        function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() require("gitsigns").prev_hunk() end)
            return "<Ignore>"
        end ,
        'Jump to prev hunk',
        opts = { expr = true },
    },
}

M.lspconfig = {
    { 'n', 'K'         , vim.lsp.buf.hover,                                                       'LSP: Hover Documentation'           },
    { 'n', '<C-k>'     , vim.lsp.buf.signature_help,                                              'LSP: Signature Documentation'       },
    { 'n', 'gd'        , vim.lsp.buf.definition,                                                  'LSP: [G]oto [D]efinition'           },
    { 'n', 'gD'        , vim.lsp.buf.declaration,                                                 'LSP: [G]oto [D]eclaration'          },
    { 'n', 'gr'        , '<cmd> Telescope lsp_references<CR>',                                    'LSP: [G]oto [R]eferences'           },
    -- { 'n', 'gr'        , vim.lsp.buf.references,                                                  'LSP: [G]oto [R]eferences'           },
    { 'n', 'gI'        , vim.lsp.buf.implementation,                                              'LSP: [G]oto [I]mplementation'       },
    { 'n', '<leader>rn', vim.lsp.buf.rename,                                                      'LSP: [R]e[n]ame'                    },
    { 'n', '<leader>ca', vim.lsp.buf.code_action,                                                 'LSP: [C]ode [A]ction'               },
    { 'n', '<leader>rn', vim.lsp.buf.rename,                                                      'LSP: [R]e[n]ame'                    },
    { 'n', '<leader>ca', vim.lsp.buf.code_action,                                                 'LSP: [C]ode [A]ction'               },
    { 'n', '<leader>D' , vim.lsp.buf.type_definition,                                             'LSP: Type [D]efinition'             },
    { 'n', '<leader>ds', '<cmd> Telescope lsp_document_symbols<CR>',                              'LSP: [D]ocument [S]ymbols'          },
    { 'n', '<leader>ws', '<cmd> Telescope lsp_dynamic_workspace_symbols<CR>',                     'LSP: [W]orkspace [S]ymbols'         },
    { 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder,                                        'LSP: [W]orkspace [A]dd Folder'      },
    { 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,                                     'LSP: [W]orkspace [R]emove Folder'   },
    { 'n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'LSP: [W]orkspace [L]ist Folders'    },
}

-- M.luasnip = {
--     { { 'i', 's' }, '<C-a>', function()
--         local ok, ls = pcall(require, "luasnip")
--         if ok then
--             if ls.choice_active() then
--                 ls.change_choice(1)
--             end
--         end
--     end, 'LuaSnip: Change choice' },
-- }

return M

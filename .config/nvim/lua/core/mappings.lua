local M = {}

M.load_mappings = function(section, mapping_opt)
    vim.schedule(function()
        local mappings = require("core.mappings")
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
--  "n" = normal
--  "i" = insert
--  "v" = visual & select
--  "x" = visual
--  "s" = select
--  "o" = operator
--  "t" = term
--  "c" = command
-- Usage:
-- local opts = { silent = true, noremap = true }
-- { 'mode' , 'key', function, 'desciption', opts = opts },
-- { {mode} , 'key', function, 'desciption', opts = {} },
M.general = {
    -- { {'n', 'v'},'<Space>'         , '<Nop>'                                                                                      },
    { 'n'          ,'<leader>e'       , '<cmd> e $MYVIMRC <CR>'                              , '[E]dit init.lua'                     },
    { 'n'          ,'<leader>ll'      , '<cmd> set list! <CR>'                               , '[S]how [L]istchars'                  },
    { 'n'          ,'<F4>'            , '<cmd> setlocal spell! spelllang=en_us<CR>'          , '暈Built-in spell-checker'            },
    { 'n'          ,'<leader><F4>'    , '<cmd> normal! mz1z=`z <CR>'                         , ' Auto-fix misspelled word'          },
    { 'v'          ,'<C-r>'           , '"hy:%s/<C-r>h//gc<left><left><left>'                , '﯒ Find & replace selected words'     },
    { 'v'          ,'<S-p>'           , '"_dP'                                               , 'Replace text & do not copy'          },
    { 'v'          ,'<'               , '<gv-gv'                                             , 'Manually indent (left)'              },
    { 'v'          ,'>'               , '>gv-gv'                                             , 'Manually indent (right)'             },
    { 'v'          ,'<C-j>'           , ":move '>+1<CR>gv-gv"                                , ' Move current line/block down'      },
    { 'v'          ,'<C-k>'           , ":move '<-2<CR>gv-gv"                                , ' Move current line/block up'        },
    { {'n','t','i'},'<A-h>'           , '<cmd> wincmd h <CR>'                                , ' Window  Left'                     },
    { {'n','t','i'},'<A-j>'           , '<cmd> wincmd j <CR>'                                , ' Window  Down'                     },
    { {'n','t','i'},'<A-k>'           , '<cmd> wincmd k <CR>'                                , ' Window  Up'                       },
    { {'n','t','i'},'<A-l>'           , '<cmd> wincmd l <CR>'                                , ' Window  Right'                    },
    { 'n'          ,'<C-Up>'          , '<cmd> resize -2 <CR>'                               , ' Resize horizontally'               },
    { 'n'          ,'<C-Down>'        , '<cmd> resize +2 <CR>'                               , ' Resize horizontally'               },
    { 'n'          ,'<C-Left>'        , '<cmd> vertical resize -2 <CR>'                      , ' Resize vertically'                 },
    { 'n'          ,'<C-Right>'       , '<cmd> vertical resize +2 <CR>'                      , ' Resize vertically'                 },
    { 'i'          ,'<C-h>'           , '<Left>'                                             , ' Move cursor Left'                  },
    { 'i'          ,'<C-j>'           , '<Down>'                                             , ' Move cursor Down'                  },
    { 'i'          ,'<C-k>'           , '<Up>'                                               , ' Move cursor Up'                    },
    { 'i'          ,'<C-l>'           , '<Right>'                                            , ' Move cursor Right'                 },
    { 'n'          ,'<leader>th'      , '<C-w>t<C-w>H'                                       , 'Switch to horizontal split'          },
    { 'n'          ,'<leader>tk'      , '<C-w>t<C-w>K'                                       , 'Switch to vertical split'            },
    { 'n'          ,'<A-t>'           , '<cmd> split|term <CR>'                              , 'Terminal in horiz split'             },
    { 'n'          ,'<leader>bf'      , '<cmd> split|term compiler %<CR>'                    , 'Compile file from terminal'          },
    { 't'          ,'<esc><esc>'      , '<c-\\><c-n>'                                        , 'Enter Normal mode'                   },
    { 'n'          ,'<C-x>'           , '<cmd> bdelete! <CR>'                                , 'Delete Buffer'                       },
    { 'n'          ,'<C-h>'           , '<cmd> bprev <CR>'                                   , 'Previous Buffer'                     },
    { 'n'          ,'<C-l>'           , '<cmd> bnext <CR>'                                   , 'Next Buffer'                         },
    { 'n'          ,'<leader><leader>', '<cmd> nohlsearch <CR>'                              , 'Turn off highlighting'               },
    { 'n'          ,'[d'              , vim.diagnostic.goto_prev                             , 'Previous diagnostic'                 },
    { 'n'          ,']d'              , vim.diagnostic.goto_next                             , 'Next diagnostic'                     },
    { 'n'          ,'F'               , vim.diagnostic.open_float                            , 'Show diagnostics'                    },
    { 'n'          ,'L'               , vim.diagnostic.setloclist                            , 'List all diagnostics'                },
}

M.plugins = {
    { 'n'          ,'<leader>/'       , '<cmd> Telescope current_buffer_fuzzy_find <CR>'     , '[/] Find in current buffer'          },
    { 'n'          ,'<leader>?'       , '<cmd> Telescope oldfiles    <CR>'                   , '[?] Find recently files'             },
    { 'n'          ,'<leader><space>' , '<cmd> Telescope buffers     <CR>'                   , '[ ] Find buffers'                    },
    { 'n'          ,'<leader>ff'      , '<cmd> Telescope find_files  <CR>'                   , '[F]ind [F]iles'                      },
    { 'n'          ,'<leader>fa'      ,
        '<cmd> Telescope find_files hidden=true no_ignore=true <CR>'                         , '[F]ind [A]ll files'                  },
    { 'n'          ,'<leader>fh'      , '<cmd> Telescope help_tags   <CR>'                   , '[F]ind [H]elp'                       },
    { 'n'          ,'<leader>fw'      , '<cmd> Telescope grep_string <CR>'                   , '[F]ind current [W]ord'               },
    { 'n'          ,'<leader>fg'      , '<cmd> Telescope live_grep   <CR>'                   , '[F]ind by [G]rep'                    },
    { 'n'          ,'<leader>fd'      , '<cmd> Telescope diagnostics <CR>'                   , '[F]ind [D]iagnostics'                },
    { 'n'          ,'<leader>fk'      , '<cmd> Telescope keymaps     <CR>'                   , '[F]ind [K]eymaps'                    },
    { 'n'          ,'<leader>ft'      , '<cmd> Telescope colorscheme enable_preview=true<CR>', '[F]ind [T]heme'                      },
    { 'n'          ,'<leader>gc'      , '<cmd> Telescope git_commits <CR>'                   , '[G]it [C]ommits'                     },
    { 'n'          ,'<leader>gs'      , '<cmd> Telescope git_status  <CR>'                   , '[G]it [S]tatus'                      },
    { 'n'          ,'<leader>:'       , '<cmd> Telescope commands    <CR>'                   , '[:] Lists all commands'              },
    -- trouble
    { 'n'          ,'<leader>xx'      , '<cmd> TroubleToggle document_diagnostics <CR>'      , 'Trouble: Document Diagnostics'       },
    { 'n'          ,'<leader>xz'      , '<cmd> TroubleToggle workspace_diagnostics <CR>'     , 'Trouble: Workspace Diagnostics'      },
    { 'n'          ,'<leader>xl'      , '<cmd> TroubleToggle loclist <CR>'                   , 'Trouble: Location List'              },
    { 'n'          ,'<leader>xq'      , '<cmd> TroubleToggle quickfix <CR>'                  , 'Trouble: Quickfix List'              },
    -- notify
    { 'n'          ,'<backspace>'     , '<cmd> lua require("notify").dismiss() <CR>'         , 'Dismiss all Notifications'           },
    -- colorizer
    { 'n'          ,'<leader>h'       , '<cmd> ColorizerToggle <CR>'                         , '[C]olorizer'                         },
    -- oil
    { 'n'          ,'-'               , '<cmd> Oil --float <CR>'                             , '[O]il file explorer'                 },
    -- markdownpreview
    { 'n'          ,'<leader>mp'      , '<cmd> MarkdownPreviewToggle <CR>'                   , '[M]arkdown [P]review'                },
    -- cmake
    { 'n'          ,'<leader>bg'      , '<cmd> CMakeGenerate <CR>'                           , '[G]enerate build system'             },
    { 'n'          ,'<leader>bb'      , '<cmd> CMakeBuild    <CR>'                           , '[B]uild a project'                   },
    { 'n'          ,'<leader>bc'      , '<cmd> CMakeClose    <CR>'                           , '[C]lose Cmake window'                },
    -- dap
    { 'n'          ,'<A-Left>'        , '<cmd> DapContinue <CR>'                             , ' DAP: Start/Continue'               },
    { 'n'          ,'<A-Right>'       , '<cmd> DapStepOver <CR>'                             , ' DAP: Step Over'                    },
    { 'n'          ,'<A-Down>'        , '<cmd> DapStepInto <CR>'                             , ' DAP: Step Into'                    },
    { 'n'          ,'<A-Up>'          , '<cmd> DapStepOut <CR>'                              , ' DAP: Step Out'                     },
    { 'n'          ,'<leader>db'      , '<cmd> DapToggleBreakpoint <CR>'                     , ' DAP: Breakpoint Toggle'            },
    { 'n'          ,'<leader>dx'      , '<cmd> DapTerminate <CR>'                            , ' DAP: Terminate'                    },
    { 'n'          ,'<leader>dr'      , '<cmd> DapToggleRepl <CR>'                           , ' DAP: Opens the REPL'               },
    { 'n'          ,'<leader>du'      , '<cmd> lua require"dapui".toggle() <CR>'             , ' DAP: UI Toggle'                    },
    { 'n'          ,'<leader>dl'      , '<cmd> lua require"dap".run_last() <CR>'             , ' DAP: Rerun the last db adapter'    },
    -- leap
    { {'n','v','o'}, '<space>'        ,
        '<cmd> lua require("leap").leap{target_windows={vim.fn.win_getid()}}<CR>'            , '󰷺 Leap: current window'              },
    { {'n','x','o'}, 'm'              , '<Plug>(leap-forward-to)'                            , '󰷺 Leap: forward to'                  },
    { {'n','x','o'}, 'M'              , '<Plug>(leap-backward-to)'                           , '󰷺 Leap: backward to'                 },
    { {    'x','o'}, 'n'              , '<Plug>(leap-forward-till)'                          , '󰷺 Leap: forward till'                },
    { {    'x','o'}, 'N'              , '<Plug>(leap-backward-till)'                         , '󰷺 Leap: backward till'               },
    { {'n','v','o'}, 'g<space>'       , '<Plug>(leap-from-window)'                           , '󰷺 Leap: from window'                 },
}

M.gitsigns = {
    { 'n', ']c',
        function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() require("gitsigns").next_hunk() end)
            return "<Ignore>"
        end,
        'Jump to next hunk',
        opts = { expr = true },
    },
    { 'n', '[c',
        function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() require("gitsigns").prev_hunk() end)
            return "<Ignore>"
        end,
        'Jump to prev hunk',
        opts = { expr = true },
    },
}

M.lspconfig = {
    { 'n', 'K'         , vim.lsp.buf.hover,                                                       'LSP: Hover Documentation'         },
    { 'n', '<C-k>'     , vim.lsp.buf.signature_help,                                              'LSP: Signature Documentation'     },
    { 'n', 'gd'        , "<cmd>Telescope lsp_definitions<CR>",                                    'LSP: [G]oto [D]efinition'         },
    -- { 'n', 'gd'        , vim.lsp.buf.definition,                                                  'LSP: [G]oto [D]efinition'         },
    { 'n', 'gD'        , vim.lsp.buf.declaration,                                                 'LSP: [G]oto [D]eclaration'        },
    { 'n', 'gr'        , '<cmd> Telescope lsp_references <CR>',                                   'LSP: [G]oto [R]eferences'         },
    -- { 'n', 'gr'        , vim.lsp.buf.references,                                                  'LSP: [G]oto [R]eferences'         },
    { 'n', 'gI'        , vim.lsp.buf.implementation,                                              'LSP: [G]oto [I]mplementation'     },
    { 'n', '<leader>rn', vim.lsp.buf.rename,                                                      'LSP: [R]e[n]ame'                  },
    { 'n', '<leader>ca', vim.lsp.buf.code_action,                                                 'LSP: [C]ode [A]ction'             },
    { 'n', '<leader>D' , vim.lsp.buf.type_definition,                                             'LSP: Type [D]efinition'           },
    { 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder,                                        'LSP: [W]orkspace [A]dd Folder'    },
    { 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,                                     'LSP: [W]orkspace [R]emove Folder' },
    { 'n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'LSP: [W]orkspace [L]ist Folders'  },
}

return M

local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

--Remap space as leader key
vim.g.mapleader = ","

keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-------------
-- General --
-------------
keymap('n', '<F4>'        , ":setlocal spell! spelllang=en_us<CR>", { desc = '暈Built-in spell-checker'} , opts)
keymap('n', '<leader><F4>', ":normal! mz1z=`z<CR>"                , { desc = ' Automatically fix misspelled word with the first suggestion'} , opts)

keymap('v', '<C-r>'       , "\"hy:%s/<C-r>h//gc<left><left><left>", { desc = '﯒ Find and replace words like the one under the cursor in visual mode'} , opts)
keymap('v', '<S-p>'       , "\"_dP",                                { desc = 'Replace by the content in clipboard but not update clipboard'} , opts)

keymap('v', '<'           , "<gv-gv",                               { desc = 'Move the lines to the left'} , opts)
keymap('v', '>'           , ">gv-gv",                               { desc = 'Move the lines to the right'} , opts)

keymap('v'         , '<C-j>'       , ":move '>+1<CR>gv-gv",         { desc = ' Move the contents of the lines down' } , opts)
keymap('v'         , '<C-k>'       , ":move '<-2<CR>gv-gv",         { desc = ' Move the contents of the lines upwards' } , opts)

keymap({ 't', 'i' }, '<A-h>'       , "<C-\\><C-N><C-w>h",           { desc = ' Window  Left' } , opts)
keymap({ 't', 'i' }, '<A-j>'       , "<C-\\><C-N><C-w>j",           { desc = ' Window  Down' } , opts)
keymap({ 't', 'i' }, '<A-k>'       , "<C-\\><C-N><C-w>k",           { desc = ' Window  Up'   } , opts)
keymap({ 't', 'i' }, '<A-l>'       , "<C-\\><C-N><C-w>l",           { desc = ' Window  Right'} , opts)
keymap('n'         , '<A-h>'       , "<C-w>h",                      { desc = ' Window  Left' } , opts)
keymap('n'         , '<A-j>'       , "<C-w>j",                      { desc = ' Window  Down' } , opts)
keymap('n'         , '<A-k>'       , "<C-w>k",                      { desc = ' Window  Up'   } , opts)
keymap('n'         , '<A-l>'       , "<C-w>l",                      { desc = ' Window  Right'} , opts)

keymap("n"         , "<C-Up>"      , ":resize -2<CR>"         ,     { desc = ' Resize horizontally'} , opts)
keymap("n"         , "<C-Down>"    , ":resize +2<CR>"         ,     { desc = ' Resize horizontally'} , opts)
keymap("n"         , "<C-Left>"    , ":vertical resize -2<CR>",     { desc = ' Resize vertically'} , opts)
keymap("n"         , "<C-Right>"   , ":vertical resize +2<CR>",     { desc = ' Resize vertically'} , opts)

keymap('i'         , '<C-h>'       , "<Left>" ,                     { desc = ' Move Left' } , opts)
keymap('i'         , '<C-j>'       , "<Down>" ,                     { desc = ' Move Down' } , opts)
keymap('i'         , '<C-k>'       , "<Up>"   ,                     { desc = ' Move Up'   } , opts)
keymap('i'         , '<C-l>'       , "<Right>",                     { desc = ' Move Right'} , opts)

keymap('n'         , '<leader>th'  , "<C-w>t<C-w>H",                { desc = 'Switch to horizontal split' } , opts)
keymap('n'         , '<leader>tk'  , "<C-w>t<C-w>K",                { desc = 'Switch to vertical split'   } , opts)

keymap('n'         , '<leader>tt'  , ":vnew term://zsh<CR>",        { desc = 'Open terminal in vertically split window (zsh)' } , opts)

keymap('n'         , '<C-x>'       , ":bdelete!<CR>",               { desc = 'Delete Buffer' } , opts)
keymap('n'         , '<C-h>'       , ":bprev<CR>",                  { desc = 'Delete Buffer' } , opts)
keymap('n'         , '<C-l>'       , ":bnext<CR>",                  { desc = 'Delete Buffer' } , opts)

keymap('n'         , '<leader><leader>', ":nohlsearch<CR>",         { desc = 'Turn off highlighting' } , opts)

-------------
-- Plugins --
-------------

-- Telescope

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local function textsearch()
    builtin.current_buffer_fuzzy_find( themes.get_dropdown { previewer = false, })
end
local function builtin_colorscheme()
    builtin.colorscheme( themes.get_dropdown { previewer = false, })
end
keymap('n', '<leader>/'      , textsearch,            { desc = '[/] Fuzzily search in current buffer]' })
keymap('n', '<leader>?'      , builtin.oldfiles,      { desc = '[?] Find recently opened files' })
keymap('n', '<leader><space>', builtin.buffers,       { desc = '[ ] Find existing buffers' })
keymap('n', '<leader>sf'     , builtin.find_files,    { desc = '[S]earch [F]iles' })
keymap('n', '<leader>sh'     , builtin.help_tags,     { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sw'     , builtin.grep_string,   { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg'     , builtin.live_grep,     { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>sd'     , builtin.diagnostics,   { desc = '[S]earch [D]iagnostics' })
keymap('n', '<leader>sk'     , builtin.keymaps,       { desc = '[S]how [K]eymaps' })
keymap('n', '<leader>st'     , builtin_colorscheme,   { desc = '[S]witch [T]heme' })
keymap('n', '<leader>gc'     , builtin.git_commits,   { desc = '[G]it [C]ommits' })
keymap('n', '<leader>gs'     , builtin.git_status,    { desc = '[G]it [S]tatus' })

-- Diagnostic keymaps
keymap('n', '[d'        , vim.diagnostic.goto_prev,  { desc = 'Go to the previous diagnostic' })
keymap('n', ']d'        , vim.diagnostic.goto_next,  { desc = 'Go to the next diagnostic' })
keymap('n', '<leader>e' , vim.diagnostic.open_float, { desc = 'Display the diagnostics in the floating window' })
keymap('n', '<leader>q' , vim.diagnostic.setloclist, { desc = 'List all diagnostics' })

-- NvimTree
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", { desc = '[N]vimTree' }, opts)

-- MarkdownPreview
keymap("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", { desc = '[M]arkdown Preview' }, opts)

-- Cmake
keymap('n', '<leader>gg', ":CMakeGenerate<CR>",   { desc = '[G]enerate build system' })
keymap('n', '<leader>bb', ":CMakeBuild<CR>",      { desc = '[B]uild a project' })
keymap('n', '<leader>cx', ":CMakeClose<CR>",      { desc = '[C]lose Cmake console window' })

-- Vimspector
-- keymap("n", "<leader>db"  , "<Plug>VimspectorToggleBreakpoint", { desc = ' Debug: Breakpoint Toggle' }, opts)
-- keymap("n", "<F9>"        , "<Plug>VimspectorContinue",         { desc = ' Debug: Start/Continue' }, opts)
-- keymap("n", "<leader><F5>", "<Plug>VimspectorRestart",          { desc = ' Debug: Restart' }, opts)
-- keymap("n", "<F5>"        , "<Plug>VimspectorStepOver",         { desc = ' Debug: Step Over' }, opts)
-- keymap("n", "<F6>"        , "<Plug>VimspectorStepInto",         { desc = ' Debug: Step Into' }, opts)
-- keymap("n", "<F7>"        , "<Plug>VimspectorStepOut",          { desc = ' Debug: Step Out' }, opts)
-- keymap("n", "<F8>"        , "<Plug>VimspectorPause",            { desc = ' Debug: Pause' }, opts)
-- keymap("n", "<leader><F8>", "<Plug>VimspectorStop",             { desc = ' Debug: Stop' }, opts)
--
-- keymap("n", "<leader>dx"  , ":VimspectorReset<CR>",             { desc = 'Debug: Reset' }, opts)
-- keymap("n", "<leader>de"  , ":VimspectorEval",                  { desc = 'Debug: Eval' }, opts)
-- keymap("n", "<leader>dw"  , ":VimspectorWatch",                 { desc = 'Debug: Watch' }, opts)
-- keymap("n", "<leader>do"  , ":VimspectorShowOutput",            { desc = 'Debug: Show Output' }, opts)

-- DAP
keymap("n", "<F9>"      , "<cmd>lua require'dap'.continue()<cr>" ,         { desc = ' DAP: Start/Continue' }, opts)
keymap("n", "<F5>"      , "<cmd>lua require'dap'.step_over()<cr>",         { desc = ' DAP: Step Over' }, opts)
keymap("n", "<F6>"      , "<cmd>lua require'dap'.step_into()<cr>",         { desc = ' DAP: Step Into' }, opts)
keymap("n", "<F7>"      , "<cmd>lua require'dap'.step_out()<cr>" ,         { desc = ' DAP: Step Out' }, opts)
keymap("n", "<F8>"      , "<cmd>lua require'dapui'.toggle()<cr>" ,         { desc = ' DAP: UI Toggle' }, opts)
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = ' DAP: Breakpoint Toggle' }, opts)
keymap("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>",         { desc = ' DAP: Terminate' }, opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",       { desc = ' DAP: Opens the REPL' }, opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>",          { desc = ' DAP: Re-runs the last debug adapter' }, opts)

---------
-- LSP --
---------

local M = {}

function M.lsp_keymaps(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename,                                         '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action,                                    '[C]ode [A]ction')
    nmap('gd'        , vim.lsp.buf.definition,                                     '[G]oto [D]efinition')
    nmap('gr'        , require('telescope.builtin').lsp_references,                '[G]oto [R]eferences')
    nmap('gI'        , vim.lsp.buf.implementation,                                 '[G]oto [I]mplementation')
    nmap('<leader>D' , vim.lsp.buf.type_definition,                                'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols,          '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    nmap('K'         , vim.lsp.buf.hover,          'Hover Documentation')
    nmap('<C-k>'     , vim.lsp.buf.signature_help, 'Signature Documentation')

    nmap('gD'        , vim.lsp.buf.declaration,             '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder,    '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, '[W]orkspace [L]ist Folders')
end

return M

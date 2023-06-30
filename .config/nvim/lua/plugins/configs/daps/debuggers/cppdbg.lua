local M = {}

local cppdbg_exe = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"

M.dap_info = {
    name_adapter = "cppdbg",
    name_configuration = { "c", "cpp", "rust" },
}

M.config = {
    adapters = {
        id = 'cppdbg',
        type = "executable",
        command = cppdbg_exe,
    },
    configurations = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            miDebuggerPath = "/usr/bin/gdb",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = true,
            setupCommands = {
                {
                    description =  'enable pretty printing',
                    text = '-enable-pretty-printing',
                    ignoreFailures = false
                },
            },
        },
        {
            name = "Attach process",
            type = "cppdbg",
            request = "attach",
            processId = require('dap.utils').pick_process,
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = "${workspaceFolder}",
            setupCommands = {
                {
                    description =  'enable pretty printing',
                    text = '-enable-pretty-printing',
                    ignoreFailures = false
                },
            },
        },
        {
            name = "Attach to gdbserver :1234",
            type = "cppdbg",
            request = "launch",
            MIMode = "gdb",
            miDebuggerServerAddress = "localhost:1234",
            miDebuggerPath = "/usr/bin/gdb",
            cwd = "${workspaceFolder}",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            setupCommands = {
                {
                    description =  'enable pretty printing',
                    text = '-enable-pretty-printing',
                    ignoreFailures = false
                },
            },
        },
    },
}

return M

local download_url  = "https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz"

local jdtls_path    = vim.fn.expand("$HOME/.local/share/jdtls")

local root_dir      = require('jdtls.setup').find_root({'gradlew', 'mvnw', '.git'} or vim.fn.getcwd())
local workspace_dir = vim.fn.expand("$HOME/.cache/jdtls/workspace/") .. vim.fn.fnamemodify(root_dir, ':p:h:t')

local path = {
    java11 = vim.fn.glob("/usr/lib/jvm/java-11-openjdk*/"),
    java17 = vim.fn.glob("/usr/lib/jvm/java-17-openjdk*/"),
}

local config = {
    on_attach = function(_, bufnr)
        require("core.mappings").load_mappings("lspconfig", { buffer = bufnr })
        vim.keymap.set('n', '<leader>jo', 'lua require("jdtls").organize_imports()    <CR>', 'jdtls: Organize imports', { buffer = bufnr })
        vim.keymap.set('n', '<leader>jv', 'lua require("jdtls").extract_variable()    <CR>', 'jdtls: Extract variable', { buffer = bufnr })
        vim.keymap.set('v', '<leader>jv', 'lua require("jdtls").extract_variable(true)<CR>', 'jdtls: Extract variable', { buffer = bufnr })
        vim.keymap.set('n', '<leader>jc', 'lua require("jdtls").extract_constant()    <CR>', 'jdtls: Extract constant', { buffer = bufnr })
        vim.keymap.set('v', '<leader>jc', 'lua require("jdtls").extract_constant(true)<CR>', 'jdtls: Extract constant', { buffer = bufnr })
        vim.keymap.set('v', '<leader>jm', 'lua require("jdtls").extract_method(true)  <CR>', 'jdtls: Extract method'  , { buffer = bufnr })

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end,

    cmd = {
        path.java17 .. '/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

        "-configuration", jdtls_path .. "/config_linux",

        '-data', workspace_dir,
    },

    root_dir = root_dir,

    settings = {
        java = {
            signatureHelp = { enabled = true },
            import = { enabled = true },
            rename = { enabled = true },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-11",
                        path = path.java17,
                    },
                    {
                        name = "JavaSE-17",
                        path = path.java17,
                    },
                }
            }
        }
    },

    init_options = {
        bundles = {}
    },
}

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = { "*.java" },
    callback = function()
        if vim.fn.empty(vim.fn.glob(jdtls_path.."/bin/jdtls")) > 0 then
            local text_on_screen = {
                "",
                "╭──────────────────────╮",
                "│ Java language server │",
                "╰──────────────────────╯",
                "",
                "  This configuration uses jdtls (Eclipse JDT Language Server) for Java.",
                "",
                "  You need to install jdtls to the path /home/nltt/ for it to work.",
                "",
                "  You can install it manually following this guide https://github.com/eclipse/eclipse.jdt.ls#installation",
                "",
                "  Or run this command:",
                "",
                "mkdir -p '"..jdtls_path.."' &&\\",
                "   wget -c '"..download_url.."' -O - |\\",
                "      tar -xz -C  '"..jdtls_path.."'",
                "",
            }
            vim.cmd("echo ''|redraw") -- clear cmdline
            vim.api.nvim_command("topleft new")

            -- buf only options
            vim.opt_local.readonly = true
            vim.opt_local.buflisted = false
            vim.opt_local.number = false
            vim.opt_local.list = false
            vim.opt_local.relativenumber = false
            vim.opt_local.wrap = false
            vim.opt_local.cul = false

            local buf = vim.api.nvim_get_current_buf() -- Collect the buffer's number.
            vim.api.nvim_buf_set_option(buf, "readonly", false) -- Make it temporarily writable so we don't have warnings.
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, text_on_screen) -- Append the text

            -- Adds a highlight to buffer.
            local javalspnote = vim.api.nvim_create_namespace("javalspnote")
            for i = 1, #text_on_screen do
                vim.api.nvim_buf_add_highlight(buf, javalspnote, "string", i, 0, -1)
            end

            vim.api.nvim_buf_set_option(buf, "readonly", false) -- Make readonly again.
            vim.api.nvim_buf_set_option(buf, "modified", false) -- Mark as not modified, otherwise you'll get an error when attempting to exit vim.
        end
    end,
})

require('jdtls').start_or_attach(config)

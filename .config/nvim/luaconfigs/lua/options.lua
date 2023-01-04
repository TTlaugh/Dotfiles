local autocmd = vim.api.nvim_create_autocmd

vim.o.completeopt = 'menuone,noselect'

vim.o.title = true

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

vim.o.showmode = false
vim.o.laststatus = 3

vim.o.ignorecase = true

vim.o.wrap = false
vim.o.breakindent = true

vim.o.smarttab = true
vim.o.cindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.signcolumn = 'yes'
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.termguicolors = true
vim.o.background = "dark"

vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"

autocmd({ "FileType" }, {
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
}) -- Don't auto commenting new lines

autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
    callback = function()
        vim.cmd([[
            nnoremap <silent> <buffer> q :close<CR>
            set nobuflisted
        ]])
    end,
})

autocmd({ "FileType" }, {
    pattern = { "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

autocmd({ "FileType" }, {
    pattern = { "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

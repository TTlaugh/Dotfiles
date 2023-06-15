vim.g.mapleader = ","

vim.opt.completeopt = 'menuone,noselect'

vim.opt.title = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.showmode = false
vim.opt.laststatus = 3

vim.opt.ignorecase = true

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.smarttab = true
vim.opt.cindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.listchars = {
    eol      = '↲',
    trail    = '',
    extends  = '',
    precedes = '',
}

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
}) -- Don't auto commenting new lines

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo" },
    callback = function()
        vim.cmd([[
            nnoremap <silent> <buffer> q :close<CR>
            set nobuflisted
        ]])
    end,
})


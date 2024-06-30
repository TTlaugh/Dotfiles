vim.g.mapleader = ","

vim.opt.title = true

vim.opt.completeopt = { "menuone", "noselect" }

vim.opt.timeoutlen = 500
vim.opt.updatetime = 300

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.confirm = true

vim.opt.showmode = false
vim.opt.laststatus = 3

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.listchars = {
    eol      = '↲',
    trail    = '',
    extends  = '',
    precedes = '',
}

-- Disable some default providers
for _, provider in ipairs {
    -- "node",
    -- "python3",
    "perl",
    "ruby",
} do vim.g["loaded_" .. provider .. "_provider"] = 0 end

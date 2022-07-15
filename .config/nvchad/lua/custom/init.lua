local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Options
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.relativenumber = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = false
opt.shortmess = vim.opt.shortmess + "c"

-- Auto commands
autocmd("FileType", {
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
}) -- Don't auto commenting new lines

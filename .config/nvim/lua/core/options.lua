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

local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("not_cmt_newline"),
    command = "set fo-=c fo-=r fo-=o",
}) -- Don't auto commenting new lines

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("rm_whitespace_onsave"),
    pattern = "*",
    command = [[%s/\s\+$//e]],
}) -- Remove trailing white space on save

vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
}) -- Resize splits if window got resized

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = augroup("term_no_numline"),
    command = "setlocal nonumber norelativenumber",
}) -- Don't show line number in terminal

-- vim.api.nvim_create_autocmd({ "TermClose" }, {
--     group = augroup("term_close"),
--     pattern = "term://*",
--     command = "bdelete! " .. vim.fn.expand('<abuf'),
-- }) -- Close terminal buffer on process exit

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
}) -- Wrap and check for spell in text filetypes

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "help",
        "lspinfo",
        "man",
        "qf",
        "startuptime",
        "checkhealth",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
}) -- Close some filetypes with <q>

-- Disable some default providers
for _, provider in ipairs {
    -- "node",
    -- "python3",
    "perl",
    "ruby",
} do vim.g["loaded_" .. provider .. "_provider"] = 0 end

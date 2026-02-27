vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.wrap = false
vim.opt.scrolloff = 20
vim.opt.updatetime = 100

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.inccommand = "split"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.shell = "pwsh.exe"
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.backspace = { "start", "eol", "indent" }

vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.swapfile = false

vim.opt.cursorline = true
vim.opt.guicursor = "n-v-c:block,i-ci:ver25-blinkwait500-blinkon250-blinkoff200,r-cr:hor20,o:hor50"
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#4E7F93" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#4E7F93" })

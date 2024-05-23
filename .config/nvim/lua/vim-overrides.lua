vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set autoread")
vim.cmd("set mouse=")

vim.g.mapleader = " "
vim.g.have_nerd_font = true

vim.opt.swapfile = false

vim.keymap.set("n", "<c-k>", ":wincmd k<CR>") 
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>") 
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>") 
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>") 

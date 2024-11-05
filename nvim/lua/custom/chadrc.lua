---@type ChadrcConfig
local M = {}
M.ui = {theme = "catppuccin"}
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

vim.cmd([[
    autocmd BufRead,BufNewFile *.tmpl set filetype=gotmpl
    autocmd BufRead,BufNewFile *.gotmpl set filetype=gotmpl
]])

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.o.termguicolors = true

-- python_host_prog = '/usr/bin/python2'
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.loaded_python3_provider = 1

vim.g.python_host_prog = '/usr/bin/python3'
vim.g.loaded_python_provider = 1

return M

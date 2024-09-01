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

return M

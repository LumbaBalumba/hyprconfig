---@type ChadrcConfig
local M = {}
M.ui = {theme = "catppuccin"}
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

vim.filetype.add({
    extension = {gotmpl = 'gotmpl'},
    pattern = {
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm"
    }
})

return M

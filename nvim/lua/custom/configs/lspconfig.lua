local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig.util"

lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"python"},
    before_init = function (params, config_)
        local Path = require "plenary.path"
        local venv = Path:new((config_.root_dir:gsub("/", Path.path.sep)), ".venv")
        if venv:joinpath("bin"):is_dir() then
          config_.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
        else
          config_.settings.python.pythonPath = tostring(venv:joinpath("Scripts", "python.exe"))
        end
    end
})

lspconfig.clangd.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureProvider = false
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    cmd = {"clangd", "--offset-encoding=utf-16"}
})

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)}
    }
    vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {preferences = {disableSuggestions = true}},
    commands = {
        OrganizeImports = {organize_imports, description = "Organize Imports"}
    }
})

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"gopls"},
    filetypes = {"go", "gomod", "gowork", "gotmpl"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {unusedparams = true}
    }

}

lspconfig.neocmake.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"neocmakelsp", "--stdio"},
    filetypes = {"cmake", "txt"},
    -- root_dir = root_pattern('.git', 'cmake'),
    single_file_support = true
}

-- lspconfig.asm_lsp.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     command = "asm-lsp",
--     filetypes = {"asm", "s", "S"}
-- }

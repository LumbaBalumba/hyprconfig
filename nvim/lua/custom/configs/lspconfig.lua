local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig.util"
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

lspconfig.clangd.setup({
  on_attach = function (client, bufnr)
    client.server_capabilities.signatureProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = {"clangd", "--offset-encoding=utf-16", "-std=c++23"}
})

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      preferences = {
        disableSuggestions = true,
      }
    },
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports",
      }
    }
})

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"gopls"},
    filetypes = { "go" , "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
            unusedparams = true,
        }
    }

}

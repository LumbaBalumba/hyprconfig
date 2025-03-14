local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local opts = {
    sources = {
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.black, null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.code_actions.impl, null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.asmfmt,
        null_ls.builtins.formatting.lua_format,
        null_ls.builtins.diagnostics.curlylint,
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.latexindent,
        null_ls.builtins.formatting.cmake_format,
        null_ls.builtins.formatting.taplo, null_ls.builtins.formatting.yamlfix,
        null_ls.builtins.formatting.nginx_beautifier
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({bufnr = bufnr})
                end
            })
        end
    end
}

return opts

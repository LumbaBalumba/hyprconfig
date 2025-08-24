require("conform").setup {
  formatters_by_ft = {
    python = { "black" }, -- run isort then black:contentReference[oaicite:20]{index=20}:contentReference[oaicite:21]{index=21}
    go = { "gofumpt", "goimports", "goimports-reviser", "golines" }, -- multiple Go formatters
    c = { "clang_format" },
    cpp = { "clang_format" },
    lua = { "stylua" }, -- (Conform has Stylua for Lua)
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    sh = { "shfmt" },
    yaml = { "yamlfix" },
    toml = { "taplo" },
    nginx = { "nginxfmt" },
    asm = { "asmfmt" },
    cmake = { "cmake_format" },
    tex = { "latexindent" },
    proto = { "buf" },
    -- etc. for all languages needed...
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true, -- use LSP formatter if no external one is set:contentReference[oaicite:22]{index=22}:contentReference[oaicite:23]{index=23}
  },
}

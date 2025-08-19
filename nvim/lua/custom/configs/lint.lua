require("lint").linters_by_ft = {
  javascript = { "eslint" },
  typescript = { "eslint" },
  python = { "ruff" },
  go = { "impl" },
  html = { "curlylint" }, -- lint HTML templates via Curlylint:contentReference[oaicite:42]{index=42}
  sh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("Lint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})

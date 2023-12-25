local plugins = {
    {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {
          "pyright",
          "ruff",
          "mypy",
          "black",
          "debugpy",
          "rust-analyzer",
          "clangd",
          "codelldb",
          "typescript-language-server",
          "eslint-lsp",
          "prettier",
          "gopls"
        },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "rust-lang/rust.vim",
    event = "VeryLazy",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      return require("rust-tools").setup(opts)
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function (_, _)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function (_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "mfussenegger/nvim-lint",
      config = function ()
        require "custom.configs.lint"
      end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
      end
      dap.listeners.before.event_initialized["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end
  },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function ()
        return require "custom.configs.formatter"
    end
  },
  {
    "dinhhuy258/git.nvim"
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    ft = {"python", "go"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "Civitasv/cmake-tools.nvim",
    require "custom.configs.cmake-tools",
  },
 }

return plugins

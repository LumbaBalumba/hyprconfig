local plugins = {
    {"christoomey/vim-tmux-navigator", lazy = false}, {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {
            ensure_installed = {
                "pyright", "ruff", "black", "debugpy", "rust-analyzer",
                "clangd", "codelldb", "typescript-language-server", "elixir-ls",
                "eslint-lsp", "prettier", "gopls", "neocmakelsp", "cmakelint",
                "asm-lsp", "asmfmt", "luaformatter"
            }
        }
    }, {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end
    }, {
        "rust-lang/rust.vim",
        lazy = false,
        ft = "rust",
        init = function() vim.g.rustfmt_autosave = 1 end
    }, {
        lazy = false,
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = "neovim/nvim-lspconfig",
        opts = function() return require "custom.configs.rust-tools" end,
        config = function(_, opts)
            return require("rust-tools").setup(opts)
        end
    }, {
        lazy = false,
        "mfussenegger/nvim-dap",
        config = function(_, _)
            require("core.utils").load_mappings("dap")
        end
    }, {
        lazy = false,
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {"mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui"},
        config = function(_, opts)
            local path =
                "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
            require("core.utils").load_mappings("dap_python")
        end
    }, {
        lazy = false,
        "dreamsofcode-io/nvim-dap-go",
        ft = "go",
        dependencies = "mfussenegger/nvim-dap",
        config = function(_, opts)
            require("dap-go").setup(opts)
            require("core.utils").load_mappings("dap_go")
        end
    }, {
        lazy = false,
        "mfussenegger/nvim-lint",
        config = function() require "custom.configs.lint" end
    }, {
        lazy = false,
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
        opts = {handlers = {}}
    }, {
        lazy = false,
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_initialized["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    }, {
        lazy = false,
        "mhartington/formatter.nvim",
        opts = function() return require "custom.configs.formatter" end
    }, {lazy = false, "dinhhuy258/git.nvim"}, {
        lazy = false,
        "jose-elias-alvarez/null-ls.nvim",
        ft = {"python", "go"},
        opts = function() return require "custom.configs.null-ls" end
    }, {
        "Civitasv/cmake-tools.nvim",
        lazy = false,
        dependencies = {"nvim-lua/plenary.nvim", "stevearc/overseer.nvim"},
        config = function() require "custom.configs.cmake-tools" end
    }, {"tpope/vim-dadbod", lazy = false},
    {"kristijanhusak/vim-dadbod-ui", lazy = false}, {
        lazy = false,
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = {
            "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        opts = function()
            return require "custom.configs.telescope_media_files"
        end
    }, {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "html", "css", "bash", "c", "cpp", "nasm", "python",
                "javascript", "typescript", "go", "rust", "elixir", "eex",
                "heex", "java"
            }
        }
    },
    {
        "Ramilito/kubectl.nvim",
        config = function() require("kubectl").setup() end

    }
}

return plugins

local plugins = {
    {"christoomey/vim-tmux-navigator", lazy = false}, {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {
            ensure_installed = {
                "pyright", "ruff", "black", "debugpy", "rust-analyzer",
                "clangd", "codelldb", "typescript-language-server", "elixir-ls",
                "eslint-lsp", "prettier", "gopls", "neocmakelsp", "cmakelint",
                "asm-lsp", "asmfmt", "luaformatter", "impl", "buf", "curlylint",
                "goimports", "actionlint", "shfmt"
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
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
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
        "jose-elias-alvarez/null-ls.nvim",
        lazy = false,
        ft = {
            "python", "go", "elixir", "javascript", "typescript", "html", "css"
        },
        opts = function() return require "custom.configs.null-ls" end
    }, {
        "Civitasv/cmake-tools.nvim",
        lazy = false,
        dependencies = {"nvim-lua/plenary.nvim", "stevearc/overseer.nvim"},
        config = function() require "custom.configs.cmake-tools" end
    }, {"tpope/vim-dadbod", lazy = false},
    {"kristijanhusak/vim-dadbod-ui", lazy = false}, {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "html", "css", "bash", "c", "cpp", "nasm", "python",
                "javascript", "typescript", "go", "rust", "elixir", "eex",
                "heex", "java", "csv", "dart", "gitignore", "gitcommit",
                "gomod", "gosum", "graphql", "html", "htmldjango", "http",
                "hyprlang", "latex", "make", "nasm", "prisma", "proto", "scss",
                "sql", "vim", "vue", "xml", "yaml", "zig", "gotmpl", "glimmer"
            }
        }
    }, {
        "Ramilito/kubectl.nvim",
        config = function() require("kubectl").setup() end,
        lazy = true
    }, {
        "ldelossa/gh.nvim",
        lazy = false,
        dependencies = {
            {
                "ldelossa/litee.nvim",
                config = function() require("litee.lib").setup() end
            }
        },
        config = function() require("litee.gh").setup() end
    }, {
        "elixir-tools/elixir-tools.nvim",
        lazy = false,
        version = "*",
        config = function()
            local elixir = require("elixir")
            local elixirls = require("elixir.elixirls")

            elixir.setup {
                nextls = {enable = true},
                elixirls = {
                    enable = true,
                    settings = elixirls.settings {
                        dialyzerEnabled = false,
                        enableTestLenses = false
                    },
                    on_attach = function(client, bufnr)
                        vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>",
                                       {buffer = true, noremap = true})
                        vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>",
                                       {buffer = true, noremap = true})
                    end
                },
                projectionist = {enable = true}
            }
        end,
        dependencies = {"nvim-lua/plenary.nvim"}
    }, {'mustache/vim-mustache-handlebars', ft = {'html', 'hbs', 'handlebars'}},
    {"cespare/vim-go-templates", ft = {"go", "tmpl"}, config = function() end},
    {"burnettk/vim-jenkins"}, {"nvim-java/nvim-java"}, {
        "3rd/image.nvim",
        lazy = false,
        config = function()
            require('image').setup {
                backend = "kitty",
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = {"markdown", "vimwiki"} -- markdown extensions (ie. quarto) can go here
                    },
                    neorg = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = {"norg"}
                    },
                    html = {enabled = false},
                    css = {enabled = false}
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = {"cmp_menu", "cmp_docs", ""},
                editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = {
                    "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif"
                } -- render image files as images when opened

            }
        end
    }
}

return plugins

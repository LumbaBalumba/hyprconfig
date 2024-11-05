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
    }, {"tpope/vim-dadbod", lazy = false}, {
        "kristijanhusak/vim-dadbod-ui",
        lazy = false
        -- dependencies = {
        --     {
        --         'kristijanhusak/vim-dadbod-completion',
        --         -- ft = {'sql', 'mysql', 'plsql'},
        --         lazy = false
        --     }
        -- }
    }, {
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
    }, {
        "rbong/vim-flog",
        lazy = false,
        cmd = {"Flog", "Flogsplit", "Floggit"},
        dependencies = {"tpope/vim-fugitive"}
    }, {
        "dubrayn/molten-nvim", -- fork of "benlubas/molten-nvim" - REPL
        version = "^1.0.0",
        dependencies = {"3rd/image.nvim"},
        build = ":UpdateRemotePlugins",
        lazy = false,
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_auto_init_behavior = "init"
            vim.g.molten_enter_output_behavior = "open_and_enter"
            vim.g.molten_auto_image_popup = false
            vim.g.molten_auto_open_output = false
            vim.g.molten_output_crop_border = false
            vim.g.molten_output_virt_lines = true
            vim.g.molten_output_win_max_height = 50
            vim.g.molten_output_win_style = "minimal"
            vim.g.molten_output_win_hide_on_leave = false
            vim.g.molten_virt_text_output = true
            vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_virt_text_max_lines = 10000
            vim.g.molten_cover_empty_lines = false
            vim.g.molten_copy_output = true
            vim.g.molten_output_show_exec_time = false
        end
    }, {
        "chrisgrieser/nvim-various-textobjs", -- additional text objects
        lazy = false,
        opts = {useDefaultKeymaps = true}
    }, {
        "preservim/vim-markdown" -- conceal markdown links
    }, {
        "iamcco/markdown-preview.nvim", -- live preview markdown in browser
        cmd = {
            "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"
        },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = {"markdown"}
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 0
        end,
        ft = {"markdown"}
    }, {
        "tadmccorkle/markdown.nvim", -- follow links (C-Enter)
        ft = "markdown",
        opts = {mappings = {link_follow = "<C-Enter>"}}
    },

    -- ###########################################################################

    {
        'MeanderingProgrammer/render-markdown.nvim', -- another markdown beautifier
        main = "render-markdown",
        opts = {
            render_modes = {'n', 'v', 'i', 'c', 't', 'x'},
            anti_conceal = {enabled = true},
            checkbox = {enabled = false},
            win_options = {conceallevel = {default = 2, rendered = 2}},
            bullet = {
                enabled = true,
                -- Replaces '-'|'+'|'*' of 'list_item'
                -- How deeply nested the list is determines the 'level'
                -- The 'level' is used to index into the array using a cycle
                -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
                icons = {'●', '○', '◆', '◇'},
                -- Padding to add to the left of bullet point
                left_pad = 1,
                -- Padding to add to the right of bullet point
                right_pad = 0,
                -- Highlight for the bullet icon
                highlight = 'RenderMarkdownBullet'
            },
            link = {enabled = false},
            heading = {
                -- Turn on / off heading icon & background rendering
                enabled = true,
                -- Turn on / off any sign column related rendering
                sign = false,
                -- Replaces '#+' of 'atx_h._marker'
                -- The number of '#' in the heading determines the 'level'
                -- The 'level' is used to index into the array using a cycle
                -- The result is left padded with spaces to hide any additional '#'
                icons = {'󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 '},
                -- Added to the sign column if enabled
                -- The 'level' is used to index into the array using a cycle
                signs = {'󰫎 '},
                -- Width of the heading background:
                --  block: width of the heading text
                --  full: full width of the window
                width = 'block',
                left_pad = 0,
                right_pad = 1,
                backgrounds = {
                    'RenderMarkdownH1Bg', 'RenderMarkdownH2Bg',
                    'RenderMarkdownH3Bg', 'RenderMarkdownH4Bg',
                    'RenderMarkdownH5Bg', 'RenderMarkdownH6Bg'
                },
                foregrounds = {
                    'RenderMarkdownH1', 'RenderMarkdownH2', 'RenderMarkdownH3',
                    'RenderMarkdownH4', 'RenderMarkdownH5', 'RenderMarkdownH6'
                }
            },

            code = {
                -- Turn on / off code block & inline code rendering
                enabled = true,
                -- Turn on / off any sign column related rendering
                sign = false,
                -- Determines how code blocks & inline code are rendered:
                --  none: disables all rendering
                --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
                --  language: adds language icon to sign column if enabled and icon + name above code blocks
                --  full: normal + language
                style = 'full',
                -- Amount of padding to add to the left of code blocks
                left_pad = 1,
                -- Amount of padding to add to the right of code blocks when width is 'block'
                right_pad = 1,
                -- Width of the code block background:
                --  block: width of the code block
                --  full: full width of the window
                width = 'block',
                -- Determins how the top / bottom of code block are rendered:
                --  thick: use the same highlight as the code body
                --  thin: when lines are empty overlay the above & below icons
                border = 'thin',
                -- Used above code blocks for thin border
                -- above = '▄',
                above = '-',
                -- Used below code blocks for thin border
                -- below = '▀',
                below = '-',
                -- Highlight for code blocks & inline code
                highlight = 'RenderMarkdownCode',
                highlight_inline = 'RenderMarkdownCodeInline'
            },
            callout = {
                note = {
                    raw = '[!NOTE]',
                    rendered = '󰋽 Note',
                    highlight = 'RenderMarkdownInfo'
                },
                tip = {
                    raw = '[!TIP]',
                    rendered = '󰌶 Tip',
                    highlight = 'RenderMarkdownSuccess'
                },
                important = {
                    raw = '[!IMPORTANT]',
                    rendered = '󰅾 Important',
                    highlight = 'RenderMarkdownHint'
                },
                warning = {
                    raw = '[!WARNING]',
                    rendered = '󰀪 Warning',
                    highlight = 'RenderMarkdownWarn'
                },
                caution = {
                    raw = '[!CAUTION]',
                    rendered = '󰳦 Caution',
                    highlight = 'RenderMarkdownError'
                },
                -- Obsidian: https://help.a.md/Editing+and+formatting/Callouts
                abstract = {
                    raw = '[!ABSTRACT]',
                    rendered = '󰨸 Abstract',
                    highlight = 'RenderMarkdownInfo'
                },
                todo = {
                    raw = '[!TODO]',
                    rendered = '󰗡 Todo',
                    highlight = 'RenderMarkdownInfo'
                },
                success = {
                    raw = '[!SUCCESS]',
                    rendered = '󰄬 Success',
                    highlight = 'RenderMarkdownSuccess'
                },
                question = {
                    raw = '[!QUESTION]',
                    rendered = '󰘥 Question',
                    highlight = 'RenderMarkdownWarn'
                },
                failure = {
                    raw = '[!FAILURE]',
                    rendered = '󰅖 Failure',
                    highlight = 'RenderMarkdownError'
                },
                danger = {
                    raw = '[!DANGER]',
                    rendered = '󱐌 Danger',
                    highlight = 'RenderMarkdownError'
                },
                bug = {
                    raw = '[!BUG]',
                    rendered = '󰨰 Bug',
                    highlight = 'RenderMarkdownError'
                },
                example = {
                    raw = '[!EXAMPLE]',
                    rendered = '󰉹 Example',
                    highlight = 'RenderMarkdownHint'
                },
                quote = {
                    raw = '[!QUOTE]',
                    rendered = '󱆨 Quote',
                    highlight = 'RenderMarkdownQuote'
                }
            },
            latex = {enabled = false}
        },

        name = 'render-markdown',
        dependencies = {
            'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim'
        }
    }
}

return plugins

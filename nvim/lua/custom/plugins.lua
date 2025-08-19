local home = vim.fn.expand "$HOME"
local plugins = {
  { "christoomey/vim-tmux-navigator", lazy = false },
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "black",
        "debugpy",
        "rust-analyzer",
        "clangd",
        "codelldb",
        "typescript-language-server",
        "elixir-ls",
        "eslint-lsp",
        "prettier",
        "gopls",
        "neocmakelsp",
        "cmakelint",
        "asm-lsp",
        "asmfmt",
        "luaformatter",
        "impl",
        "buf",
        "curlylint",
        "goimports",
        "actionlint",
        "shfmt",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "rust-lang/rust.vim",
    lazy = false,
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    lazy = false,
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      return require("rust-tools").setup(opts)
    end,
  },
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^6", -- Recommended
  --   lazy = false, -- This plugin is already lazy
  -- },
  {
    lazy = false,
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings "dap"
    end,
  },
  {
    lazy = false,
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings "dap_python"
    end,
  },
  {
    lazy = false,
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings "dap_go"
    end,
  },
  {
    lazy = false,
    "mfussenegger/nvim-lint",
    config = function()
      require "custom.configs.lint"
    end,
  },
  {
    lazy = false,
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = { handlers = {} },
  },
  {
    lazy = false,
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
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
    end,
  },
  {
    lazy = false,
    "mhartington/formatter.nvim",
    opts = function()
      return require "custom.configs.formatter"
    end,
  },
  { lazy = false, "dinhhuy258/git.nvim" },
  {
    "Civitasv/cmake-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/overseer.nvim" },
    config = function()
      require "custom.configs.cmake-tools"
    end,
  },
  { "tpope/vim-dadbod", lazy = false },
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = false,
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = false,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "css",
        "bash",
        "c",
        "cpp",
        "nasm",
        "python",
        "javascript",
        "typescript",
        "go",
        "rust",
        "elixir",
        "eex",
        "heex",
        "java",
        "csv",
        "dart",
        "gitignore",
        "gitcommit",
        "gomod",
        "gosum",
        "graphql",
        "html",
        "htmldjango",
        "http",
        "hyprlang",
        "latex",
        "make",
        "nasm",
        "prisma",
        "proto",
        "scss",
        "sql",
        "vim",
        "vue",
        "xml",
        "yaml",
        "zig",
        "gotmpl",
        "glimmer",
        "cuda",
        "gitcommit",
        "gitignore",
        "glimmer",
        "markdown",
        "markdown_inline",
        "nasm",
        "nginx",
      },
    },
  },
  {
    "Ramilito/kubectl.nvim",
    config = function()
      require("kubectl").setup()
    end,
    lazy = true,
  },
  {
    "ldelossa/gh.nvim",
    lazy = false,
    dependencies = {
      {
        "ldelossa/litee.nvim",
        config = function()
          require("litee.lib").setup()
        end,
      },
    },
    config = function()
      require("litee.gh").setup()
    end,
  },
  {
    "elixir-tools/elixir-tools.nvim",
    lazy = false,
    version = "*",
    config = function()
      local elixir = require "elixir"
      local elixirls = require "elixir.elixirls"

      elixir.setup {
        nextls = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          end,
        },
        projectionist = { enable = true },
      }
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "mustache/vim-mustache-handlebars", ft = { "html", "hbs", "handlebars" } },
  { "cespare/vim-go-templates", ft = { "go", "tmpl" }, config = function() end },
  { "burnettk/vim-jenkins" },
  { "nvim-java/nvim-java" },
  {
    "3rd/image.nvim",
    lazy = false,
    config = function()
      require("image").setup {
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
          html = { enabled = false },
          css = { enabled = false },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = {
          "*.png",
          "*.jpg",
          "*.jpeg",
          "*.gif",
          "*.webp",
          "*.avif",
        }, -- render image files as images when opened
      }
    end,
  },
  {
    "rbong/vim-flog",
    lazy = false,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = { "tpope/vim-fugitive" },
  },
  {
    "chrisgrieser/nvim-various-textobjs", -- additional text objects
    lazy = false,
    opts = { keymaps = { useDefault = true } },
  },
  {
    "preservim/vim-markdown", -- conceal markdown links
  },
  {
    "iamcco/markdown-preview.nvim", -- live preview markdown in browser
    cmd = {
      "MarkdownPreviewToggle",
      "MarkdownPreview",
      "MarkdownPreviewStop",
    },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
    end,
    ft = { "markdown" },
  },
  {
    "tadmccorkle/markdown.nvim", -- follow links (C-Enter)
    ft = "markdown",
    opts = { mappings = { link_follow = "<C-Enter>" } },
  },

  -- ###########################################################################

  {
    "MeanderingProgrammer/render-markdown.nvim", -- another markdown beautifier
    main = "render-markdown",
    opts = {
      render_modes = { "n", "v", "i", "c", "t", "x" },
      anti_conceal = { enabled = true },
      checkbox = { enabled = false },
      win_options = { conceallevel = { default = 2, rendered = 2 } },
      bullet = {
        enabled = true,
        -- Replaces '-'|'+'|'*' of 'list_item'
        -- How deeply nested the list is determines the 'level'
        -- The 'level' is used to index into the array using a cycle
        -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
        icons = { "●", "○", "◆", "◇" },
        -- Padding to add to the left of bullet point
        left_pad = 1,
        -- Padding to add to the right of bullet point
        right_pad = 0,
        -- Highlight for the bullet icon
        highlight = "RenderMarkdownBullet",
      },
      link = { enabled = false },
      heading = {
        -- Turn on / off heading icon & background rendering
        enabled = true,
        -- Turn on / off any sign column related rendering
        sign = false,
        -- Replaces '#+' of 'atx_h._marker'
        -- The number of '#' in the heading determines the 'level'
        -- The 'level' is used to index into the array using a cycle
        -- The result is left padded with spaces to hide any additional '#'
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- Added to the sign column if enabled
        -- The 'level' is used to index into the array using a cycle
        signs = { "󰫎 " },
        -- Width of the heading background:
        --  block: width of the heading text
        --  full: full width of the window
        width = "block",
        left_pad = 0,
        right_pad = 1,
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
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
        style = "full",
        -- Amount of padding to add to the left of code blocks
        left_pad = 1,
        -- Amount of padding to add to the right of code blocks when width is 'block'
        right_pad = 1,
        -- Width of the code block background:
        --  block: width of the code block
        --  full: full width of the window
        width = "block",
        -- Determins how the top / bottom of code block are rendered:
        --  thick: use the same highlight as the code body
        --  thin: when lines are empty overlay the above & below icons
        border = "thin",
        -- Used above code blocks for thin border
        -- above = '▄',
        above = "-",
        -- Used below code blocks for thin border
        -- below = '▀',
        below = "-",
        -- Highlight for code blocks & inline code
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",
      },
      callout = {
        note = {
          raw = "[!NOTE]",
          rendered = "󰋽 Note",
          highlight = "RenderMarkdownInfo",
        },
        tip = {
          raw = "[!TIP]",
          rendered = "󰌶 Tip",
          highlight = "RenderMarkdownSuccess",
        },
        important = {
          raw = "[!IMPORTANT]",
          rendered = "󰅾 Important",
          highlight = "RenderMarkdownHint",
        },
        warning = {
          raw = "[!WARNING]",
          rendered = "󰀪 Warning",
          highlight = "RenderMarkdownWarn",
        },
        caution = {
          raw = "[!CAUTION]",
          rendered = "󰳦 Caution",
          highlight = "RenderMarkdownError",
        },
        -- Obsidian: https://help.a.md/Editing+and+formatting/Callouts
        abstract = {
          raw = "[!ABSTRACT]",
          rendered = "󰨸 Abstract",
          highlight = "RenderMarkdownInfo",
        },
        todo = {
          raw = "[!TODO]",
          rendered = "󰗡 Todo",
          highlight = "RenderMarkdownInfo",
        },
        success = {
          raw = "[!SUCCESS]",
          rendered = "󰄬 Success",
          highlight = "RenderMarkdownSuccess",
        },
        question = {
          raw = "[!QUESTION]",
          rendered = "󰘥 Question",
          highlight = "RenderMarkdownWarn",
        },
        failure = {
          raw = "[!FAILURE]",
          rendered = "󰅖 Failure",
          highlight = "RenderMarkdownError",
        },
        danger = {
          raw = "[!DANGER]",
          rendered = "󱐌 Danger",
          highlight = "RenderMarkdownError",
        },
        bug = {
          raw = "[!BUG]",
          rendered = "󰨰 Bug",
          highlight = "RenderMarkdownError",
        },
        example = {
          raw = "[!EXAMPLE]",
          rendered = "󰉹 Example",
          highlight = "RenderMarkdownHint",
        },
        quote = {
          raw = "[!QUOTE]",
          rendered = "󱆨 Quote",
          highlight = "RenderMarkdownQuote",
        },
      },
      latex = { enabled = false },
    },

    name = "render-markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup {
        openai_params = {
          model = "gpt-4o",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        },
        api_key_cmd = "gpg -q -d " .. home .. "/openai_api_key.gpg",
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = {
    -- 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim'
    -- }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    lazy = false,
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,
    },
    lazy = false,
  },
  {
    "karb94/neoscroll.nvim",
    opts = {
      mappings = { -- Keys to be mapped to their corresponding default scrolling animation
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
    },
    lazy = false,
  },
  {
    "yetone/avante.nvim",
    opts = {
      provider = "gemini",
      providers = {
        ollama = {
          endpoint = "http://localhost:11434",
          model = "qwen2.5-coder:0.5b",
        },
        gemini = {
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
          -- Pick a fast, low-latency model for interactive coding
          -- (you can swap to "gemini-2.5-pro" for deeper edits; requires quota)
          model = "gemini-2.5-flash",
          timeout = 30000, -- ms
          context_window = 1048576, -- Avante default for Gemini in its config
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "stevearc/dressing.nvim", -- for input provider dressing
        "folke/snacks.nvim", -- for input provider snacks
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          "MeanderingProgrammer/render-markdown.nvim",
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
      hints = { enabled = true },
      mappings = {
        suggestion = {
          accept = "<Enter>",
          next = "<Tab>",
          prev = "<S-Tab>",
          dismiss = "<C-]>",
        },
      },
      windows = {
        --- prefer floating chat/edit panes; adjust to taste
        -- width = 0.45,
      },
    },
    lazy = false,
  },
  {
    "goerz/jupytext.nvim",
    version = "0.2.0", -- use a specific release version
    opts = {
      -- Use Markdown format for notebooks (so we see markdown and code fences)
      format = "md:myst", -- "md" uses Jupytext Markdown (MyST) format:contentReference[oaicite:10]{index=10}
      autosync = true, -- auto-sync .ipynb on save
      -- You could alternatively use format = "py:percent" to edit as a .py file
      -- with '# %%' cell markers, but "md" is recommended for a notebook-like view:contentReference[oaicite:11]{index=11}.
      update = true,
    },
    lazy = false,
  },
  {
    "benlubas/molten-nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Molten uses plenary under the hood
      "3rd/image.nvim", -- for inline images
    },
    build = ":UpdateRemotePlugins", -- register the remote plugin (for Neovim to find Python code)
    opts = {
      -- Molten has many settings (see :help molten or README), but defaults are fine.
      -- We'll rely on quarto-nvim to interface with Molten, so no custom opts needed here.
    },
    lazy = false,
    init = function()
      vim.g.molten_image_provider = "image.nvim"
    end,
    config = function() end,
    -- Molten doesn't set keymaps by default; we'll add keymaps in quarto-nvim config below.
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim", -- provides language server support for R, python, etc.
      "neovim/nvim-lspconfig", -- ensure LSP is available
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- 4a. Set up quarto-nvim
      require("quarto").setup {
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          languages = { "python" }, -- enable LSP for Python chunks (add others if needed):contentReference[oaicite:15]{index=15}
          -- Using Pyright via LSP for autocompletion/diagnostics in code cells.
          -- (Make sure Pyright or another Python LSP is installed in Mason/system)
        },
        codeRunner = {
          enabled = true,
          -- Use Molten for running code cells
          default_method = "molten", -- global default: send all code to Molten.nvim:contentReference[oaicite:16]{index=16}:contentReference[oaicite:17]{index=17}
          -- Alternatively, could do ft_runners = { python = "molten" } to only use Molten for Python:contentReference[oaicite:18]{index=18}.
        },
      }

      -- 4b. Keybindings for interactive use (assuming <LocalLeader> is set, e.g. "\\" by default)
      local runner = require "quarto.runner"
      vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "Run current cell", silent = true })
      vim.keymap.set("n", "<leader>ra", runner.run_all, { desc = "Run all cells", silent = true })
      vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "Run current line", silent = true })
      vim.keymap.set("n", "<leader>mi", "<Cmd>MoltenInit<CR>", { desc = "Start/attach Jupyter kernel", silent = true })
      -- (Here we map <LocalLeader>mi to MoltenInit: this starts a new kernel or attaches to one.
      -- By default it will start a Python3 kernel; you can also do `:MoltenInit kernel_name` if multiple kernels.)
    end,
    lazy = false,
  },
  {
    "stevearc/conform.nvim",
    lazy = false,
    config = function()
      require "custom.configs.conform"
    end,
  },
}
return plugins

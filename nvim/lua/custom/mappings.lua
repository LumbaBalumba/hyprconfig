local M = {}

M.general = {
    n = {
        ["<C-h>"] = {"<cmd> TmuxNavigateLeft<CR>", "window left"},
        ["<C-l>"] = {"<cmd> TmuxNavigateRight<CR>", "window right"},
        ["<C-j>"] = {"<cmd> TmuxNavigateDown<CR>", "window down"},
        ["<C-k>"] = {"<cmd> TmuxNavigateUp<CR>", "window up"}
    }
}

M.dap = {
    plugin = true,
    n = {
        ["<leader>db"] = {
            "<cmd> DapToggleBreakpoint <CR>", "Add breakpoint at line"
        },
        ["<leader>dr"] = {
            "<cmd> DapContinue <CR>", "Start or continue the debugger"
        },
        ["<leader>dus"] = {
            function()
                local widgets = require('dap.ui.widgets');
                local sidebar = widgets.sidebar(widgets.scopes);
                sidebar.open();
            end, "Open debugging sidebar"
        }
    }
}

M.dap_python = {
    plugin = true,
    n = {
        ["<leader>dpr"] = {
            function() require("dap-python").test_method() end, "Debug Python"
        }
    }
}

M.dap_go = {
    plugin = true,
    n = {
        ["<leader>dgt"] = {
            function() require('dap-go').debug_test() end, "Debug go test"
        },
        ["<leader>dgl"] = {
            function() require('dap-go').debug_last() end, "Debug last go test"
        }
    }
}

M.cmake_tools = {
    n = {
        ["<leader>Cg"] = {
            "<cmd> CMakeGenerate <CR>", "Generate CMake environment"
        },
        ["<leader>Cb"] = {"<cmd> CMakeBuild <CR>", "Build CMake project"},
        ["<leader>Cr"] = {"<cmd> CMakeRun  <CR>", "Run CMake project"},
        ["<leader>Cd"] = {"<cmd> CMakeDebug <CR>", "Debug CMake project"},
        ["<leader>Cs"] = {
            "<cmd> CMakeSelectBuildTarget <CR>", "Select CMake target"
        }

    }
}

M.move_lines = {
    n = {
        ["<A-Down>"] = {"<cmd> m .+1 <CR>", "Move line down"},
        ["<A-Up>"] = {"<cmd> :m .-2 <CR>", "Move line up"}
    }
}

M.dadbod = {n = {["<leader>DB"] = {"<cmd> DBUIToggle <CR>", "Toggle dadbod"}}}

M.python = {
    n = {
        ["<leader>Pr"] = {
            "<cmd> PyrightSetPythonPath .venv/bin/python <CR>",
            "Set pyright Python path"
        }
    }
}

-- M.ai = {n = {["<leader>ch"] = {"<cmd> <CR>", "Open AI chat"}}}

return M

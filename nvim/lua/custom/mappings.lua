local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    },
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function ()
        require("dap-python").test_method()
      end,
      "Debug Python"
    }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function ()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function ()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}


M.cmake_tools = {
  --plugin = true,
  n = {["<leader>Cg"] = {
        "<cmd> CMakeGenerate <CR>",
        "Generate CMake environment"
    },
    ["<leader>Cb"] = {
        "<cmd> CMakeBuild <CR>",
        "Build CMake project"
    },
    ["<leader>Cr"] = {
        "<cmd> CMakeRun  <CR>",
        "Run CMake project"
    },
    ["<leader>Cd"] = {
        "<cmd> CMakeDebug <CR>",
        "Debug CMake project"
    }

    }
}

return M

require("luatil")

require("dap-python").setup("~/code/nvim_debugger/.venv/bin/python3")
require("dapui").setup()
require("nvim-dap-virtual-text").setup()


vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--   dapui.close()
-- end

dap.adapters.gdb = {
    id = 'gdb',
    type = 'executable',
    command = 'gdb',
    args = { '--quiet', '--interpreter=dap' },
}

-- local pgagroal_cli = "./pgagroal-cli"
local pgagroal = "./pgagroal"
local pgagroal_args = "-c pgagroal.conf -a pgagroal_hba.conf"
-- local pgagroal_args = "--usage"

dap.configurations.c = {
    -- {
    --     name = 'run cli',
    --     type = 'gdb',
    --     request = 'launch',
    --     program = pgagroal_cli,
    -- },
    {
        name = 'run pgagroal',
        type = 'gdb',
        request = 'launch',
        program = pgagroal,
        args = pgagroal_args
    }
}

-- dap.configurations.c = {
--     {
--         name = 'Run executable (GDB)',
--         type = 'gdb',
--         request = 'launch',
--         -- This requires special handling of 'run_last', see
--         -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
--         program = function()
--             local path = vim.fn.input({
--                 prompt = 'Another Path to executable: ',
--                 default = vim.fn.getcwd() .. '/',
--                 completion = 'file',
--             })
-- 
--             return (path and path ~= '') and path or dap.ABORT
--         end,
--     },
--     {
--         name = 'Run executable with arguments (GDB)',
--         type = 'gdb',
--         request = 'launch',
--         -- This requires special handling of 'run_last', see
--         -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
--         program = function()
--             local path = vim.fn.input({
--                 prompt = 'Another Path to executable: ',
--                 default = vim.fn.getcwd() .. '/',
--                 completion = 'file',
--             })
-- 
--             return (path and path ~= '') and path or dap.ABORT
--         end,
--         args = function()
--             local args_str = vim.fn.input({
--                 prompt = 'Arguments: ',
--             })
--             return vim.split(args_str, ' +')
--         end,
--     },
--     {
--         name = 'Attach to process (GDB)',
--         type = 'gdb',
--         request = 'attach',
--         processId = require('dap.utils').pick_process,
--     }
-- }

local elixir_ls_debugger_path = "/home/luatil/.local/share/nvim/mason/packages/elixir-ls/debug_adapter.sh"
dap.adapters.mix_task = {
    type = "executable",
    command = elixir_ls_debugger_path,
    args = {}
}

dap.configurations.elixir = {
    {
        type = "mix_task",
        name = "mix test",
        task = 'test',
        taskArgs = { "--trace" },
        request = "launch",
        startApps = true, -- for Phoenix projects
        projectDir = "${workspaceFolder}",
        requireFiles = {
            "test/**/test_helper.exs",
            "test/**/*_test.exs"
        }
    },
}

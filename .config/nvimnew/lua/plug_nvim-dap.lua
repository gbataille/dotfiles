local dap = require('dap')

-- Do not show the dap-repl buffer
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dap-repl',
  command = 'set nobuflisted'
})

local dap_breakpoint = {
  error = {
    text = "🛑",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  rejected = {
    text = "🐛",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "🌟",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

-- ############### GO #################
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
    options = {
      initialize_timeout_sec = 30,
    },
  }
}

local function union ( a, b )
    local result = {}
    for _,v in pairs ( a ) do
        table.insert( result, v )
    end
    for _,v in pairs ( b ) do
         table.insert( result, v )
    end
    return result
end

local function get_arguments()
  local co = coroutine.running()
  if co then
    return coroutine.create(function()
      local args = {}
      vim.ui.input({ prompt = 'Args: ' }, function(input)
        args = vim.split(input or "", " ")
      end)
      coroutine.resume(co, args)
    end)
  else
    local args = {}
    vim.ui.input({ prompt = 'Args: ' }, function(input)
      args = vim.split(input or "", " ")
    end)
    return args
  end
end

local function get_start()
  local co = coroutine.running()
  if co then
    return coroutine.create(function()
      local args = {}
      vim.ui.input({ prompt = 'Args: ' }, function(input)
        args = union({"start"}, vim.split(input or "", " "))
      end)
      coroutine.resume(co, args)
    end)
  else
    local args = {}
    vim.ui.input({ prompt = 'Args: ' }, function(input)
      args = union({"start"}, vim.split(input or "", " "))
    end)
    return args
  end
end

local function get_test_filter()
  local co = coroutine.running()
  if co then
    return coroutine.create(function()
      local args = {}
      vim.ui.input({ prompt = 'Test regex + Args: ' }, function(input)
        args = union({"-test.run"}, vim.split(input or "", " "))
      end)
      coroutine.resume(co, args)
    end)
  else
    local args = {}
    vim.ui.input({ prompt = 'Test regex + Args: ' }, function(input)
      args = union({"-test.run"}, vim.split(input or "", " "))
    end)
    return args
  end
end

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "1_blocksd",
    request = "launch",
    program = "./cmd/tg-blocksd",
    args = get_start,
    showLog = true,
    trace = "log"
  },
  {
    type = "delve",
    name = "2_validatord",
    request = "launch",
    mode = "debug",
    program = "./cmd/tg-validatord",
    args = get_start,
    showLog = true,
    trace = "log"
  },
  {
    type = "delve",
    name = "3_go-single-test-crdb",
    request = "launch",
    program = "${fileDirname}",
    cwd = "${fileDirname}",
    args = get_test_filter,
    buildFlags = "-tags=integration,acceptance",
    env = {
      TG_DB_HOST = "localhost",
      TG_DB_PORT = "26257",
      TG_DB_USER = "root",
      TG_DB_PASSWORD = "root",
      TG_DB_DRIVER = "cockroach"
    },
    mode = "test",
    showLog = true,
    trace = "log"
  },
  {
    type = "delve",
    name = "4_go-single-test-sqlserver",
    request = "launch",
    program = "${fileDirname}",
    cwd = "${fileDirname}",
    args = get_test_filter,
    buildFlags = "-tags=integration,acceptance",
    env = {
      TG_DB_HOST = "localhost",
      TG_DB_PORT = "1433",
      TG_DB_USER = "sa",
      TG_DB_PASSWORD = "MyPass@word0",
      TG_DB_DRIVER = "sqlserver"
    },
    mode = "test",
    showLog = true,
    trace = "log"
  },
  {
    type = "delve",
    name = "5_go-all-test-crdb",
    request = "launch",
    program = "${fileDirname}",
    cwd = "${fileDirname}",
    args = get_arguments,
    buildFlags = "-tags=integration,acceptance",
    env = {
      TG_DB_HOST = "localhost",
      TG_DB_PORT = "26257",
      TG_DB_USER = "root",
      TG_DB_PASSWORD = "root",
      TG_DB_DRIVER = "cockroach"
    },
    mode = "test",
    showLog = true,
    trace = "log"
  },
  {
    type = "delve",
    name = "6_go-all-test-sqlserver",
    request = "launch",
    program = "${fileDirname}",
    cwd = "${fileDirname}",
    args = get_arguments,
    buildFlags = "-tags=integration,acceptance",
    env = {
      TG_DB_HOST = "localhost",
      TG_DB_PORT = "1433",
      TG_DB_USER = "sa",
      TG_DB_PASSWORD = "MyPass@word0",
      TG_DB_DRIVER = "sqlserver"
    },
    mode = "test",
    showLog = true,
    trace = "log"
  },
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug (Arguments)",
    request = "launch",
    program = "${file}",
    args = get_arguments,
  },
  {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
}

require('nvim-test').setup {
  run = true,                 -- run tests (using for debug)
  commands_create = true,     -- create commands (TestFile, TestLast, ...)
  filename_modifier = ":.",   -- modify filenames before tests run(:h filename-modifiers)
  silent = false,             -- less notifications
  term = "terminal",          -- a terminal to run ("terminal"|"toggleterm")
  termOpts = {
    direction = "horizontal", -- terminal's direction ("horizontal"|"vertical"|"float")
    width = 96,               -- terminal's width (for vertical|float)
    height = 30,              -- terminal's height (for horizontal|float)
    go_back = false,          -- return focus to original window after executing
    stopinsert = false,       -- exit from insert mode (true|false|"auto")
    keep_one = true,          -- keep only one terminal for testing
  },
  runners = {                 -- setup tests runners
    cs = "nvim-test.runners.dotnet",
    go = "nvim-test.runners.go-test",
    haskell = "nvim-test.runners.hspec",
    javacriptreact = "nvim-test.runners.jest",
    javascript = "nvim-test.runners.jest",
    lua = "nvim-test.runners.busted",
    python = "nvim-test.runners.pytest",
    ruby = "nvim-test.runners.rspec",
    rust = "nvim-test.runners.cargo-test",
    typescript = "nvim-test.runners.jest",
    typescriptreact = "nvim-test.runners.jest",
  }
}

require('nvim-test.runners.cargo-test'):setup {
  command = "cargo", -- a command to run the test runner
  args = { "test" }, -- default arguments
  package = true,
}

local defaultGoTest = function()
  require('nvim-test.runners.go-test'):setup {
    command = "grc",
    args = { "go", "test", "-v" },
    file_pattern = "\\v([^.]+_test)\\.go$", -- determine whether a file is a testfile
    find_files = { "{name}_test.go" },      -- find testfile for a file
  }
end

-- See mappings.lua
local runWithTagsAndEnv = function(tags, env)
  local test = require("nvim-test")

  require('nvim-test.runners.go-test'):setup {
    command = "grc",
    args = { "go", "test", "-v", "-tags", tags, "-count", "1" },
    file_pattern = "\\v([^.]+_test)\\.go$", -- determine whether a file is a testfile
    find_files = { "{name}_test.go" },      -- find testfile for a file
    env = env,
  }

  test.run('nearest')

  defaultGoTest()
end

defaultGoTest() -- init go test with grc for colors

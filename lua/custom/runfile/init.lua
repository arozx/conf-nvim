local M = {}

function M.run_file()
  vim.cmd 'write'
  local file = vim.fn.expand '%:p'
  local ext = vim.fn.expand '%:e'

  if ext == 'py' then
    vim.cmd('split | terminal python3 ' .. file)
  elseif ext == 'c' then
    local out = vim.fn.expand '%:r'
    vim.cmd('split | terminal gcc ' .. file .. ' -o ' .. out .. ' && ' .. vim.fn.fnamemodify(out, ':p'))
  elseif ext == 'lua' then
    vim.cmd('split | terminal lua ' .. file)
  elseif ext == 'java' then
    local test_class = vim.fn.expand '%:t:r'
    -- Check if the filename matches the pattern 'AutoTestLevel' followed by a number
    if test_class:match '^AutoTestLevel%d+$' then
      -- It's a test file, run our python script
      local cwd = vim.fn.expand '%:h'
      vim.cmd('split | terminal cd ' .. cwd .. ' && python3 run_java_tests.py ' .. test_class)
    else
      -- It's a regular java file, keep the original behavior
      vim.cmd('split | terminal java ' .. file)
    end
  else
    print('No run command for .' .. ext)
  end
end

function M.run_tests()
  local cwd = vim.fn.expand '%:h'
  local ext = vim.fn.expand '%:e'

  if ext == 'py' then
    -- Run pytest in the current directory
    vim.cmd('split | terminal cd ' .. cwd .. ' && python3 -m pytest')
  elseif ext == 'java' then
    -- Run all Java tests in the current directory
    vim.cmd('split | terminal cd ' .. cwd .. ' && python3 run_java_tests.py')
  elseif ext == 'c' then
    -- Run tests in the current directory (assuming a test binary exists)
    vim.cmd('split | terminal cd ' .. cwd .. ' && make test')
  else
    print('No test command for .' .. ext)
  end
end

return M

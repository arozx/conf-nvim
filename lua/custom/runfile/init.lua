local M = {}

function M.run_file()
  local file = vim.fn.fnamemodify(vim.fn.expand '%:p', ':p')
  local ext = vim.fn.expand '%:e'

  if ext == 'py' then
    vim.cmd('split | terminal python3 ' .. file)
  elseif ext == 'c' then
    local out = vim.fn.expand '%:r'
    vim.cmd('split | terminal gcc ' .. file .. ' -o ' .. out .. ' && ' .. vim.fn.fnamemodify(out, ':p'))
  elseif ext == 'lua' then
    vim.cmd('split | terminal lua ' .. file)
  else
    print('No run command for .' .. ext)
  end
end

return M

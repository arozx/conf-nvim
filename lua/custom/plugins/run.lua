return {
  'custom/runfile', -- local module
  dir = vim.fn.stdpath 'config' .. '/lua/custom/runfile',
  dependencies = { 'folke/which-key.nvim' },
  config = function()
    vim.keymap.set('n', '<leader>r', function() end, { desc = 'Run / Refactor' })
    vim.keymap.set('n', '<leader>rf', function()
      require('custom.runfile').run_file()
    end, { desc = 'Run file' })
  end,
}

return {
  'custom/runfile', -- local module
  dir = vim.fn.stdpath 'config' .. '/lua/custom/runfile',
  dependencies = { 'folke/which-key.nvim' },
  config = function()
    vim.keymap.set('n', '<leader>r', function() end, { desc = 'Run / Refactor' })
    -- This keymap now calls the run_file function
    vim.keymap.set('n', '<leader>rf', function()
      require('custom.runfile').run_file()
    end, { desc = 'Run current file' })
    vim.keymap.set('n', '<leader>rt', function()
      require('custom.runfile').run_tests()
    end, { desc = 'Run tests in directory' })
    vim.keymap.set('n', '<leader>rc', function()
      local file_path = vim.fn.expand '%:p'
      local checkstyle_dir = '/home/glitch/checkstyle/'
      local xml_files = vim.fn.glob(checkstyle_dir .. '**/*.xml', true, true)

      if vim.tbl_isempty(xml_files) then
        vim.notify('No checkstyle XML files found in ' .. checkstyle_dir, vim.log.levels.ERROR)
        return
      end

      vim.ui.select(xml_files, {
        prompt = 'Select checkstyle rules:',
        format_item = function(item)
          return vim.fn.fnamemodify(item, ':t')
        end,
      }, function(choice)
        if not choice then
          return
        end
        local cmd = 'checkstyle ' .. file_path .. ' -c ' .. choice
        vim.cmd('vsplit | term ' .. cmd)
      end)
    end, { desc = 'Run checkstyle on file' })

    vim.keymap.set('n', '<leader>rg', function()
      local file_path = vim.fn.expand '%:p'
      local cmd = 'google-java-format -i ' .. file_path
      vim.fn.jobstart(cmd, {
        on_exit = function()
          vim.notify('Formatted ' .. vim.fn.fnamemodify(file_path, ':t'))
          vim.cmd 'e'
        end,
      })
    end, { desc = 'Fix style of current file' })
  end,
}


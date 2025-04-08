return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy', -- Only loads the plugin when a org file is opened
  ft = { 'org' },
  config = function()
    -- Treesitter grammar for org
    -- require('orgmode').setup_ts_grammar()

    require('orgmode').setup {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',

      org_todo_keywords = { 'TODO', 'WAITING', '|', 'DONE', 'CANCELLED' },

      org_capture_templates = {
        t = {
          description = 'Task',
          template = '* TODO %?\n  %u',
          target = '~/orgfiles/refile.org',
        },
        j = {
          description = 'Journal',
          template = '* %<%Y-%m-%d> %?\nEntered on %U',
          target = '~/orgfiles/journal.org',
        },
      },
    }

    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require('nvim-treesitter.configs').setup({
    --   ensure_installed = 'all',
    --   ignore_install = { 'org' },
    -- })
  end,
}

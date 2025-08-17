return {
  -- Gitsigns for git integration
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      -- Setup custom Git age feature
      require('config.git_age').setup()
    end,
    keys = {
      { '<leader>ga', '<cmd>GitAgeToggle<cr>', desc = 'Toggle Git Age Markers' },
      { ']rd', function() require('config.git_age').next_day() end, desc = 'Next change (<=1 day)' },
      { '[rd', function() require('config.git_age').prev_day() end, desc = 'Prev change (<=1 day)' },
      { ']rw', function() require('config.git_age').next_week() end, desc = 'Next change (<=1 week)' },
      { '[rw', function() require('config.git_age').prev_week() end, desc = 'Prev change (<=1 week)' },
      { ']rm', function() require('config.git_age').next_month() end, desc = 'Next change (<=1 month)' },
      { '[rm', function() require('config.git_age').prev_month() end, desc = 'Prev change (<=1 month)' },
      -- Per-file hunk navigation (working tree vs index)
      { ']h', function() require('gitsigns').nav_hunk('next') end, desc = 'Next hunk (file)' },
      { '[h', function() require('gitsigns').nav_hunk('prev') end, desc = 'Prev hunk (file)' },
      -- Project-wide changes navigation using quickfix
      { ']g', function() require('config.git_changes').next() end, desc = 'Next project change' },
      { '[g', function() require('config.git_changes').prev() end, desc = 'Prev project change' },
      { '<leader>gq', function() require('config.git_changes').open_qf() end, desc = 'Open project changes (QF)' },
    },
  },
}
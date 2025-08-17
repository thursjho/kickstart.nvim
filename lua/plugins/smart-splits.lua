return {
  -- Window and pane management
  {
    'mrjones2014/smart-splits.nvim',
    keys = {
      { '<A-h>', function() require('smart-splits').resize_left() end, desc = 'Resize Left' },
      { '<A-j>', function() require('smart-splits').resize_down() end, desc = 'Resize Down' },
      { '<A-k>', function() require('smart-splits').resize_up() end, desc = 'Resize Up' },
      { '<A-l>', function() require('smart-splits').resize_right() end, desc = 'Resize Right' },
      { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = 'Move cursor left' },
      { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = 'Move cursor down' },
      { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = 'Move cursor up' },
      { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = 'Move cursor right' },
      { '<leader><leader>h', function() require('smart-splits').swap_buf_left() end, desc = 'Swap buffer left' },
      { '<leader><leader>j', function() require('smart-splits').swap_buf_down() end, desc = 'Swap buffer down' },
      { '<leader><leader>k', function() require('smart-splits').swap_buf_up() end, desc = 'Swap buffer up' },
      { '<leader><leader>l', function() require('smart-splits').swap_buf_right() end, desc = 'Swap buffer right' },
    },
    opts = {
      ignored_filetypes = { 'nofile', 'quickfix', 'prompt' },
      ignored_buftypes = { 'NvimTree' },
    }
  },
}
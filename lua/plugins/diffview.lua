return {
  -- Diffview for git diffs
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    config = function()
      require('diffview').setup()
    end,
    keys = {
      -- TODO: fix conflict
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Diffview Close' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = 'Diffview File History' },
      { '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview Current File History' },
    },
  },
}
return {
  -- Neogit for git interface
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('neogit').setup {
        integrations = {
          diffview = true
        }
      }
    end,
    keys = {
      { '<leader>gn', '<cmd>Neogit<cr>', desc = 'Neogit' },
      { '<leader>gc', '<cmd>Neogit commit<cr>', desc = 'Neogit Commit' },
    },
  },
}
return {
  -- Octo for GitHub integration
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup({
        enable_builtin = true,
        default_merge_method = 'squash',
        picker = 'snacks',
      })
    end,
    keys = {
      { '<leader>oi', '<cmd>Octo issue list<cr>', desc = 'Octo Issues' },
      { '<leader>op', '<cmd>Octo pr list<cr>', desc = 'Octo Pull Requests' },
      { '<leader>or', '<cmd>Octo repo list<cr>', desc = 'Octo Repositories' },
      { '<leader>os', '<cmd>Octo search<cr>', desc = 'Octo Search' },
    },
  }
}

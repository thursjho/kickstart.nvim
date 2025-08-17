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
        picker = 'fzf-lua',
      })
    end,
    keys = {
      { '<leader>goi', '<cmd>Octo issue list<cr>', desc = 'Octo Issues' },
      { '<leader>gop', '<cmd>Octo pr list<cr>', desc = 'Octo Pull Requests' },
      { '<leader>gor', '<cmd>Octo repo list<cr>', desc = 'Octo Repositories' },
      { '<leader>gos', '<cmd>Octo search<cr>', desc = 'Octo Search' },
    },
  }
}
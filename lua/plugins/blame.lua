return {
  -- Git blame plugins
  {
    'FabijanZulj/blame.nvim',
    keys = {
      { '<leader>gB', '<cmd>BlameToggle<cr>', desc = 'Git Blame Toggle' },
    },
    opts = {}
  },

  {
    'f-person/git-blame.nvim',
    enabled = false, -- Disabled in favor of blame.nvim
    config = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_message_template = '<summary> • <date> • <author>'
      vim.g.gitblame_highlight_group = 'LineNr'
      vim.g.gitblame_delay = 1000
    end,
    keys = {
      { '<leader>gbt', '<cmd>GitBlameToggle<cr>', desc = 'Git Blame Toggle' },
    },
  },
}
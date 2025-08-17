return {
  -- Ranger file manager integration
  {
    'kelly-lin/ranger.nvim',
    cmd = { 'Ranger' },
    keys = {
      { '<leader>fR', '<cmd>Ranger<cr>', desc = 'Open Ranger (file manager)' },
    },
    config = function()
      pcall(function()
        require('ranger-nvim').setup({})
      end)
    end,
  },
}
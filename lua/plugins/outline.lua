return {
  -- Code outline sidebar for LSP symbols
  {
    'hedyhli/outline.nvim',
    cmd = { 'Outline', 'OutlineOpen', 'OutlineClose', 'OutlineFocus' },
    keys = {
      { '<leader>co', '<cmd>Outline<CR>', desc = 'Code Outline (Symbols)' },
    },
    config = function()
      require('outline').setup()
    end,
  },
}
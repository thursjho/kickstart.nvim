return {
  -- Oil.nvim: simple file explorer that replaces netrw
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = false,
      },
      skip_confirm_for_simple_edits = true,
    },
    keys = {
      { '-', '<cmd>Oil<CR>', desc = 'Open parent directory (Oil)' },
      {
        '<leader>e',
        function()
          require('oil').toggle_float()
        end,
        desc = 'Oil File Explorer',
      },
    },
  },
}
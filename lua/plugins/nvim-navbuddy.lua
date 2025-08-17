return {
  -- Navbuddy: interactive LSP symbol navigator
  {
    'hasansujon786/nvim-navbuddy',
    dependencies = {
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      {
        '<leader>cb',
        function()
          require('nvim-navbuddy').open()
        end,
        desc = 'Code Browser (Navbuddy)'
      },
    },
    opts = {
      window = { border = 'rounded' },
      lsp = { auto_attach = true },
    },
    config = function(_, opts)
      require('nvim-navbuddy').setup(opts)
    end,
  },
}
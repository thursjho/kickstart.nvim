return {
  -- headlines.nvim: for code-folding and code-highlighting
  {
    'lukas-reineke/headlines.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('headlines').setup()
    end,
  },
}
return {
  -- Tailwind CSS tools
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      document_color = {
        enabled = true,
        kind = 'inline',
        inline_symbol = '󰝤 ',
        debounce = 200,
      },
      conceal = {
        enabled = false,
        min_length = nil,
        symbol = '󱏿',
        highlight = {
          fg = '#38BDF8',
        },
      },
      cmp = {
        highlight = 'foreground',
      },
    },
  },
}
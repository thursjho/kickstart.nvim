return {
  -- Trouble for diagnostics and quickfix
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
      {
        ']t',
        function()
          require('trouble').next { skip_groups = true, jump = true }
        end,
        desc = 'Next trouble/diagnostic',
      },
      {
        '[t',
        function()
          require('trouble').prev { skip_groups = true, jump = true }
        end,
        desc = 'Previous trouble/diagnostic',
      },
    },
    config = function(_, opts)
      require('trouble').setup(opts)

      -- Automatically open trouble when there are diagnostics
      vim.api.nvim_create_autocmd('DiagnosticChanged', {
        callback = function()
          local trouble = require('trouble')
          if trouble.is_open() then
            trouble.refresh()
          end
        end,
      })
    end,
  },
}
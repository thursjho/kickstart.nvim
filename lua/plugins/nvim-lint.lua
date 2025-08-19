return {
  -- Linting with nvim-lint
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        -- Web Development
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        vue = { 'eslint_d' },
        svelte = { 'eslint_d' },
        css = { 'stylelint' },
        scss = { 'stylelint' },
        less = { 'stylelint' },
        html = { 'htmlhint' },

        -- Python Development
        python = { 'ruff', 'mypy' },

        -- Configuration & Markup
        json = { 'jsonlint' },
        yaml = { 'yamllint' },
        markdown = { 'markdownlint', 'alex' },

        -- Shell Scripts
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        zsh = { 'shellcheck' },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}

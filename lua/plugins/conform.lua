return {
  -- Formatting with conform.nvim
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'format buffer',
      },
      {
        '<leader>cl',
        function()
          require('lint').try_lint()
        end,
        desc = 'lint current buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        -- Web Development
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        vue = { 'prettierd', 'prettier', stop_after_first = true },
        svelte = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        less = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        jsonc = { 'prettierd', 'prettier', stop_after_first = true },

        -- Python Development
        python = { 'ruff_format', 'ruff_organize_imports' },

        -- Configuration Files
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        toml = { 'taplo' },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },

        -- Other Languages
        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
        sql = { 'sql-formatter' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },

        -- Fallback for any filetype
        ['*'] = { 'codespell' },
        -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured
        ['_'] = { 'trim_whitespace' },
      },
      formatters = {
        stylua = {
          args = { '--column-width', '200' },
        },
      },
    },
  },
}
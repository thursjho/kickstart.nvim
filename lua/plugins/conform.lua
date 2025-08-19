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
        lua = { 'stylua' },
        markdown = { 'prettier' },
        go = { "goimports", "gofmt" },
        sql = { "sql_formatter" },
        python = { "ruff_format", "isort" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        ["*"] = { "injected" },
      },
    },
  },
}
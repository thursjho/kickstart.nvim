return {
  -- bullets.vim: better Markdown and text list editing
  {
    'bullets-vim/bullets.vim',
    ft = { 'markdown', 'text', 'gitcommit' },
    init = function()
      -- Enable default mappings and restrict to common text filetypes
      vim.g.bullets_set_mappings = 1
      vim.g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit' }
      -- Optional: treat checkboxes like bullets as well
      -- vim.g.bullets_checkbox_markers = ' xX-'
    end,
  },
}
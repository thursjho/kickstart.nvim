-- UI and theming plugins
return {
  -- Kanagawa colorscheme
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    init = function()
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'kanagawa'
      
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        return {}
      end,
      theme = 'wave',
      background = {
        dark = 'wave',
        light = 'lotus'
      },
    }
  },

  -- Todo comments highlighting
  { 
    'folke/todo-comments.nvim', 
    event = 'VimEnter', 
    dependencies = { 'nvim-lua/plenary.nvim' }, 
    opts = { signs = false } 
  }
}
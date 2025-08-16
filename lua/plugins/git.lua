-- Git-related plugins
return {
  -- Gitsigns for git integration
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      -- Setup custom Git age feature
      require('config.git_age').setup()
    end,
    keys = {
      { '<leader>uga', '<cmd>GitAgeToggle<cr>', desc = 'Toggle Git Age Markers' },
    },
  },

  -- Git blame plugins
  {
    'FabijanZulj/blame.nvim',
    keys = {
      { '<leader>gB', '<cmd>BlameToggle<cr>', desc = 'Git Blame Toggle' },
    },
    opts = {}
  },

  {
    'f-person/git-blame.nvim',
    enabled = false, -- Disabled in favor of blame.nvim
    config = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_message_template = '<summary> • <date> • <author>'
      vim.g.gitblame_highlight_group = 'LineNr'
      vim.g.gitblame_delay = 1000
    end,
    keys = {
      { '<leader>gbt', '<cmd>GitBlameToggle<cr>', desc = 'Git Blame Toggle' },
    },
  },

  -- Diffview for git diffs
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    config = function()
      require('diffview').setup()
    end,
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Diffview Close' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = 'Diffview File History' },
      { '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview Current File History' },
    },
  },

  -- Neogit for git interface
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('neogit').setup {
        integrations = {
          diffview = true
        }
      }
    end,
    keys = {
      { '<leader>gn', '<cmd>Neogit<cr>', desc = 'Neogit' },
      { '<leader>gc', '<cmd>Neogit commit<cr>', desc = 'Neogit Commit' },
    },
  },

  -- Advanced git search
  {
    'aaronhallaert/advanced-git-search.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('advanced_git_search').setup()
    end,
    keys = {
      { '<leader>gas', function() require('advanced_git_search').search_log_content() end, desc = 'Git Search Log Content' },
      { '<leader>gac', function() require('advanced_git_search').search_log_content_file() end, desc = 'Git Search Log Content File' },
      { '<leader>gad', function() require('advanced_git_search').diff_commit_file() end, desc = 'Git Diff Commit File' },
      { '<leader>gal', function() require('advanced_git_search').diff_commit_line() end, desc = 'Git Diff Commit Line' },
      { '<leader>gab', function() require('advanced_git_search').diff_branch_file() end, desc = 'Git Diff Branch File' },
    },
  },

  -- Octo for GitHub integration
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup({
        enable_builtin = true,
        default_merge_method = 'squash',
        picker = 'fzf-lua',
      })
    end,
    keys = {
      { '<leader>goi', '<cmd>Octo issue list<cr>', desc = 'Octo Issues' },
      { '<leader>gop', '<cmd>Octo pr list<cr>', desc = 'Octo Pull Requests' },
      { '<leader>gor', '<cmd>Octo repo list<cr>', desc = 'Octo Repositories' },
      { '<leader>gos', '<cmd>Octo search<cr>', desc = 'Octo Search' },
    },
  }
}

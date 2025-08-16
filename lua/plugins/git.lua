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
      { '<leader>ga', '<cmd>GitAgeToggle<cr>', desc = 'Toggle Git Age Markers' },
      { ']rd', function() require('config.git_age').next_day() end, desc = 'Next change (<=1 day)' },
      { '[rd', function() require('config.git_age').prev_day() end, desc = 'Prev change (<=1 day)' },
      { ']rw', function() require('config.git_age').next_week() end, desc = 'Next change (<=1 week)' },
      { '[rw', function() require('config.git_age').prev_week() end, desc = 'Prev change (<=1 week)' },
      { ']rm', function() require('config.git_age').next_month() end, desc = 'Next change (<=1 month)' },
      { '[rm', function() require('config.git_age').prev_month() end, desc = 'Prev change (<=1 month)' },
      -- Per-file hunk navigation (working tree vs index)
      { ']h', function() require('gitsigns').nav_hunk('next') end, desc = 'Next hunk (file)' },
      { '[h', function() require('gitsigns').nav_hunk('prev') end, desc = 'Prev hunk (file)' },
      -- Project-wide changes navigation using quickfix
      { ']g', function() require('config.git_changes').next() end, desc = 'Next project change' },
      { '[g', function() require('config.git_changes').prev() end, desc = 'Prev project change' },
      { '<leader>gq', function() require('config.git_changes').open_qf() end, desc = 'Open project changes (QF)' },
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

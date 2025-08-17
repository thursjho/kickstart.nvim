return {
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
}
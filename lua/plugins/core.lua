-- Core functionality plugins
return {
  -- Guess indentation automatically
  {
    'NMAC427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {
        filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
          'netrw',
          'tutor',
        },
        buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
          'help',
          'nofile',
          'terminal',
          'prompt',
        },
      }
    end,
  },

  -- Snacks.nvim - Collection of useful utilities
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true } -- Wrap notifications
        }
      },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --porcelain -b",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
      input = {},
      picker = {},
      terminal = {},
    },
    keys = {
      -- Top Pickers (LazyVim style)
      { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
      { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
      { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { '<leader>n', function() 
        if Snacks.config.picker and Snacks.config.picker.enabled then
          Snacks.picker.notifications()
        else
          Snacks.notifier.show_history()
        end
      end, desc = 'Notification History' },
      
      -- File operations
      { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
      { '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Git Files' },
      { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent Files' },
      { '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Find Config Files' },
      { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      
      -- Search operations
      { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
      { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Current Word' },
      { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
      { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Open Buffers' },
      { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
      { '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
      { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = 'Search History' },
      { '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
      { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
      { '<leader>sD', function() Snacks.picker.diagnostics { buffer = 0 } end, desc = 'Buffer Diagnostics' },
      { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
      { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlight Groups' },
      { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons' },
      { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
      { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
      { '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
      { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
      { '<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages' },
      { '<leader>sp', function() Snacks.picker.pickers() end, desc = 'Pickers' },
      { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
      { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
      { '<leader>su', function() Snacks.picker.undo() end, desc = 'Undo History' },
      
      -- Tmux sessions (using <leader>sx to avoid conflict with todo-comments)
      { '<leader>sx', function()
        -- Check if tmux is available
        if vim.fn.executable('tmux') == 0 then
          vim.notify('tmux not found', vim.log.levels.ERROR)
          return
        end

        -- Get tmux sessions
        local handle = io.popen('tmux list-sessions -F "#{session_name} (#{session_windows} windows) #{?session_attached,[attached],[detached]}" 2>/dev/null')
        if not handle then
          vim.notify('Failed to get tmux sessions', vim.log.levels.ERROR)
          return
        end

        local sessions = {}
        for line in handle:lines() do
          local session_name = line:match('^([^%s]+)')
          if session_name then
            table.insert(sessions, {
              text = line,
              session = session_name
            })
          end
        end
        handle:close()

        if #sessions == 0 then
          vim.notify('No tmux sessions found', vim.log.levels.WARN)
          return
        end

        Snacks.picker.pick({
          source = 'tmux_sessions',
          title = 'Tmux Sessions',
          items = sessions,
          preview = false,
          actions = {
            open = function(item)
              local cmd
              if vim.env.TMUX then
                cmd = string.format('tmux switch-client -t "%s"', item.session)
              else
                cmd = string.format('tmux attach-session -t "%s"', item.session)
              end
              vim.fn.system(cmd)
              if vim.v.shell_error ~= 0 then
                vim.notify('Failed to switch to tmux session: ' .. item.session, vim.log.levels.ERROR)
              else
                vim.notify('Switched to tmux session: ' .. item.session, vim.log.levels.INFO)
              end
            end
          }
        })
      end, desc = 'Tmux Sessions' },
      
      -- Git operations
      { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
      { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
      { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log (Current Line)' },
      { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
      { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
      { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
      { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log (Current File)' },
      
      -- LazyVim specific
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
      { '<leader>gw', function() Snacks.gitbrowse() end, desc = 'Git Browse' },
      
      -- Notifications
      { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
      
      -- Buffer operations
      { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
      
      -- File operations
      { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
      
      -- Terminal
      { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
      { '<c-_>', function() Snacks.terminal() end, desc = 'Toggle Terminal (which-key)' },
      
      -- Words navigation
      { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
      { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
      
      -- Neovim News
      {
        '<leader>N',
        desc = 'Neovim News',
        function() 
          Snacks.win { 
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1], 
            width = 0.6,
            height = 0.6, 
            wo = { 
              spell = false, 
              wrap = false, 
              signcolumn = 'yes', 
              statuscolumn = ' ', 
              conceallevel = 3, 
            } 
          } 
        end,
      },
      
      -- UI toggles (via picker)
      { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorscheme' },
      -- Recent edits (JetBrains-style)
      { '<leader>re', function() require('config.recent_edits').pick() end, desc = 'Recently Edited Locations' },
      { ']e', function() require('config.recent_edits').next() end, desc = 'Next recent edit' },
      { '[e', function() require('config.recent_edits').prev() end, desc = 'Prev recent edit' },
    },
    init = function()
      -- Track recent edit locations
      pcall(function() require('config.recent_edits').setup() end)
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'relative number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'dark background' }):map '<leader>ub'
          if vim.lsp.inlay_hint then
            Snacks.toggle.inlay_hints():map '<leader>uh'
          end
        end,
      })
    end,
  },

  -- Which-key for keybinding hints
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts_extend = { 'spec' },
    opts = {
      preset = 'helix',
      defaults = {},
      spec = {
        {
          mode = { 'n', 'v' },
          { '<leader><tab>', group = 'tabs' },
          { '<leader>c', group = 'code' },
          { '<leader>f', group = 'file/find' },
          { '<leader>g', group = 'git' },
          { '<leader>gh', group = 'hunks' },
          { '<leader>o', group = 'obsidian' },
          { '<leader>p', group = 'paste/yank' },
          { '<leader>q', group = 'quit/session' },
          { '<leader>s', group = 'search' },
          { '<leader>t', group = 'test' },
          { '<leader>u', group = 'ui', icon = { icon = '󰙵 ', color = 'cyan' } },
          { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
          { '[', group = 'prev' },
          { ']', group = 'next' },
          { 'g', group = 'goto' },
          { 'gs', group = 'surround' },
          { 'z', group = 'fold' },
          {
            '<leader>b',
            group = 'buffer',
            expand = function()
              return require('which-key.extras').expand.buf()
            end,
          },
          {
            '<leader>w',
            group = 'windows',
            proxy = '<c-w>',
            expand = function()
              return require('which-key.extras').expand.win()
            end,
          },
        },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Keymaps (which-key)',
      },
      {
        '<c-w><space>',
        function()
          require('which-key').show { keys = '<c-w>', loop = true }
        end,
        desc = 'Window Hydra Mode (which-key)',
      },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        wk.register(opts.defaults)
      end
    end,
  },

  -- Window and pane management
  {
    'mrjones2014/smart-splits.nvim',
    keys = {
      { '<A-h>', function() require('smart-splits').resize_left() end, desc = 'Resize Left' },
      { '<A-j>', function() require('smart-splits').resize_down() end, desc = 'Resize Down' },
      { '<A-k>', function() require('smart-splits').resize_up() end, desc = 'Resize Up' },
      { '<A-l>', function() require('smart-splits').resize_right() end, desc = 'Resize Right' },
      { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = 'Move cursor left' },
      { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = 'Move cursor down' },
      { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = 'Move cursor up' },
      { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = 'Move cursor right' },
      { '<leader><leader>h', function() require('smart-splits').swap_buf_left() end, desc = 'Swap buffer left' },
      { '<leader><leader>j', function() require('smart-splits').swap_buf_down() end, desc = 'Swap buffer down' },
      { '<leader><leader>k', function() require('smart-splits').swap_buf_up() end, desc = 'Swap buffer up' },
      { '<leader><leader>l', function() require('smart-splits').swap_buf_right() end, desc = 'Swap buffer right' },
    },
    opts = {
      ignored_filetypes = { 'nofile', 'quickfix', 'prompt' },
      ignored_buftypes = { 'NvimTree' },
    }
  },

  -- Workspaces for project management
  {
    'natecraddock/workspaces.nvim',
    config = function()
      require('workspaces').setup {
        hooks = {
          open_pre = {
            -- If recording, save current session state and stop recording
            'SessionSave',
            -- delete all buffers (does not save changes)
            'silent %bdelete!',
          },
          open = function()
            require('workspaces.util').telescope(require('workspaces').get())
          end,
        }
      }
      
      -- Custom picker integration with snacks
      vim.keymap.set('n', '<leader>fw', function()
        local workspaces = require('workspaces').get()
        local items = {}
        for _, workspace in ipairs(workspaces) do
          table.insert(items, {
            text = workspace.name .. ' (' .. workspace.path .. ')',
            file = workspace.path,
            data = workspace
          })
        end
        
        Snacks.picker.pick({
          source = 'workspaces',
          title = 'Workspaces',
          items = items,
          preview = { type = 'file' },
          actions = {
            open = function(item)
              require('workspaces').open(item.data.name)
            end
          }
        })
      end, { desc = 'Find Workspaces' })
    end,
  }
}

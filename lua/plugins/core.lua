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
      
      -- Todo comments
      { '<leader>st', function()
        -- Custom todo comments picker using grep
        local cwd = vim.fn.getcwd()
        local cmd = 'grep -rn --include="*.lua" --include="*.js" --include="*.ts" --include="*.jsx" --include="*.tsx" --include="*.py" --include="*.md" "\\(TODO\\|FIXME\\|HACK\\|WARN\\|PERF\\|NOTE\\)" ' .. vim.fn.shellescape(cwd)
        local output = vim.fn.system(cmd)
        
        if vim.v.shell_error ~= 0 or output == "" then
          vim.notify("No todo comments found", vim.log.levels.INFO)
          return
        end

        local items = {}
        for line in output:gmatch("[^\r\n]+") do
          local file, lnum, text = line:match("([^:]+):(%d+):(.*)")
          if file and lnum and text then
            table.insert(items, {
              text = string.format("%s:%s:%s", vim.fn.fnamemodify(file, ":."), lnum, text:gsub("^%s*", "")),
              file = file,
              lnum = tonumber(lnum),
              col = 1
            })
          end
        end

        if #items == 0 then
          vim.notify("No todo comments found", vim.log.levels.INFO)
          return
        end

        Snacks.picker.pick({
          source = 'todo_comments',
          title = 'Todo Comments',
          items = items,
          preview = { type = 'file' },
          actions = {
            open = function(item)
              vim.cmd('edit ' .. vim.fn.fnameescape(item.file))
              vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
            end
          }
        })
      end, desc = 'Todo Comments' },
      
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
      { '<leader>bD', function() Snacks.bufdelete.other() end, desc = 'Delete Other Buffers' },
      { '<leader>bl', function() Snacks.bufdelete.all() end, desc = 'Delete All Buffers' },
      { '<leader>bo', function() Snacks.bufdelete.other() end, desc = 'Delete Other Buffers' },
      { '<leader>bp', '<cmd>bprevious<cr>', desc = 'Prev Buffer' },
      { '<leader>bn', '<cmd>bnext<cr>', desc = 'Next Buffer' },
      { '<leader>br', '<cmd>e!<cr>', desc = 'Reload Buffer' },
      { '<leader>bs', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
      { '<leader>bS', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
      
      -- Code operations (LazyVim style)
      { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action' },
      { '<leader>cA', function()
        vim.lsp.buf.code_action({
          context = {
            only = { "source" },
            diagnostics = {},
          },
        })
      end, desc = 'Source Action' },
      { '<leader>cd', vim.diagnostic.open_float, desc = 'Line Diagnostics' },
      { '<leader>cf', function() require('conform').format({ lsp_fallback = true }) end, desc = 'Format Document' },
      { '<leader>cF', function() require('conform').format({ formatters = { "injected" }, lsp_fallback = true }) end, desc = 'Format Injected Langs' },
      { '<leader>cl', function() require('lint').try_lint() end, desc = 'Lint Buffer' },
      { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename' },
      { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
      { '<leader>cs', function() Snacks.picker.lsp_document_symbols() end, desc = 'Document Symbols' },
      { '<leader>cS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'Workspace Symbols' },
      
      -- LSP Info
      { "<leader>L", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
      -- { '<leader>L', '<cmd>LspInfo<cr>', desc = 'LSP Info' },
      
      -- Debug operations (DAP)
      { '<leader>da', function() require('dap').continue() end, desc = 'Run with Args' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition' },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Continue' },
      { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
      { '<leader>dd', function() require('dap').disconnect() end, desc = 'Disconnect' },
      { '<leader>dg', function() require('dap').session() end, desc = 'Get Session' },
      { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
      { '<leader>dj', function() require('dap').down() end, desc = 'Down' },
      { '<leader>dk', function() require('dap').up() end, desc = 'Up' },
      { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
      { '<leader>do', function() require('dap').step_over() end, desc = 'Step Over' },
      { '<leader>dO', function() require('dap').step_out() end, desc = 'Step Out' },
      { '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
      { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
      { '<leader>ds', function() require('dap').session() end, desc = 'Session' },
      { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
      { '<leader>du', function() require('dapui').toggle({}) end, desc = 'Dap UI' },
      { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Widgets' },

      -- Save and quit keymaps
      { '<C-s>', '<cmd>w<cr><esc>', desc = 'Save Buffer', mode = { 'i', 'x', 'n', 's' } },
      { '<leader>w', '<cmd>w<cr>', desc = 'Save Buffer' },
      { '<leader>W', '<cmd>wa<cr>', desc = 'Save All Buffers' },
      { '<leader>q', '<cmd>q<cr>', desc = 'Quit' },
      { '<leader>Q', '<cmd>qa<cr>', desc = 'Quit All' },

      -- Lazy
      { '<leader>l', '<cmd>Lazy<cr>', desc = 'Lazy' },
      
      -- Terminal
      { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
      { '<c-_>', function() Snacks.terminal() end, desc = 'Toggle Terminal (which-key)' },
      
      -- Words navigation
      { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
      { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
      
      -- Buffer local keymaps (LazyVim style)
      { '<leader>?', function()
        local function get_buffer_keymaps()
          local buf = vim.api.nvim_get_current_buf()
          local ft = vim.bo[buf].filetype
          local keymaps = {}
          
          -- Get all buffer-local keymaps
          local buf_keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
          for _, keymap in ipairs(buf_keymaps) do
            if keymap.lhs and keymap.desc then
              table.insert(keymaps, {
                key = keymap.lhs,
                desc = keymap.desc,
                mode = 'n'
              })
            end
          end
          
          -- Add LSP keymaps if LSP is attached
          local clients = vim.lsp.get_clients({ bufnr = buf })
          if #clients > 0 then
            local lsp_keymaps = {
              { 'gd', 'Goto Definition' },
              { 'gD', 'Goto Declaration' },
              { 'gr', 'References' },
              { 'gI', 'Goto Implementation' },
              { 'gy', 'Goto T[y]pe Definition' },
              { 'K', 'Hover' },
              { 'gK', 'Signature Help' },
              { '<leader>ca', 'Code Action' },
              { '<leader>cA', 'Source Action' },
              { '<leader>cr', 'Rename' },
              { '<leader>cf', 'Format Document' },
              { '<leader>cl', 'Lint Buffer' },
              { '<leader>cd', 'Line Diagnostics' },
              { ']d', 'Next Diagnostic' },
              { '[d', 'Prev Diagnostic' },
              { ']e', 'Next Error' },
              { '[e', 'Prev Error' },
              { ']w', 'Next Warning' },
              { '[w', 'Prev Warning' },
            }
            for _, lsp_keymap in ipairs(lsp_keymaps) do
              table.insert(keymaps, {
                key = lsp_keymap[1],
                desc = lsp_keymap[2] .. ' (LSP)',
                mode = 'n'
              })
            end
          end
          
          -- Add DAP keymaps if available
          if pcall(require, 'dap') then
            local dap_keymaps = {
              { '<leader>db', 'Toggle Breakpoint' },
              { '<leader>dB', 'Breakpoint Condition' },
              { '<leader>dc', 'Continue' },
              { '<leader>dC', 'Run to Cursor' },
              { '<leader>di', 'Step Into' },
              { '<leader>do', 'Step Over' },
              { '<leader>dO', 'Step Out' },
              { '<leader>dr', 'Toggle REPL' },
              { '<leader>dt', 'Terminate' },
              { '<leader>du', 'Dap UI' },
            }
            for _, dap_keymap in ipairs(dap_keymaps) do
              table.insert(keymaps, {
                key = dap_keymap[1],
                desc = dap_keymap[2] .. ' (DAP)',
                mode = 'n'
              })
            end
          end
          
          -- Add common buffer keymaps
          local common_keymaps = {
            { '<leader>bd', 'Delete Buffer' },
            { '<leader>bn', 'Next Buffer' },
            { '<leader>bp', 'Prev Buffer' },
            { '<leader>br', 'Reload Buffer' },
            { '<leader>bs', 'Scratch Buffer' },
            { '<leader>bS', 'Select Scratch Buffer' },
            { '<C-s>', 'Save Buffer' },
            { '<leader>w', 'Save Buffer' },
            { '<leader>W', 'Save All Buffers' },
            { '<leader>q', 'Quit' },
            { '<leader>Q', 'Quit All' },
            { '<C-h>', 'Move to Left Window' },
            { '<C-j>', 'Move to Down Window' },
            { '<C-k>', 'Move to Up Window' },
            { '<C-l>', 'Move to Right Window' },
            { '<A-h>', 'Resize Left' },
            { '<A-j>', 'Resize Down' },
            { '<A-k>', 'Resize Up' },
            { '<A-l>', 'Resize Right' },
            { '<C-/>', 'Toggle Terminal' },
            { 's', 'Flash Jump' },
            { 'S', 'Flash Treesitter' },
            { ']h', 'Next Git Hunk' },
            { '[h', 'Prev Git Hunk' },
            { ']t', 'Next Trouble' },
            { '[t', 'Prev Trouble' },
            { ']]', 'Next Reference' },
            { '[[', 'Prev Reference' },
            { ']y', 'Next Yank in Ring' },
            { '[y', 'Prev Yank in Ring' },
            { 'p', 'Enhanced Put After (Yanky)' },
            { 'P', 'Enhanced Put Before (Yanky)' },
            { 'gp', 'Put After (keep cursor)' },
            { 'gP', 'Put Before (keep cursor)' },
          }
          for _, common_keymap in ipairs(common_keymaps) do
            table.insert(keymaps, {
              key = common_keymap[1],
              desc = common_keymap[2],
              mode = 'n'
            })
          end
          
          -- Add filetype-specific keymaps
          if ft == 'lua' then
            table.insert(keymaps, { key = '<leader>R', desc = 'Reload Config', mode = 'n' })
          elseif ft == 'markdown' then
            table.insert(keymaps, { key = '<leader>st', desc = 'Todo Comments', mode = 'n' })
          elseif ft == 'git' then
            table.insert(keymaps, { key = '<leader>gg', desc = 'Lazygit', mode = 'n' })
          end
          
          return keymaps
        end
        
        local keymaps = get_buffer_keymaps()
        if #keymaps == 0 then
          vim.notify("No buffer keymaps found", vim.log.levels.INFO)
          return
        end
        
        -- Format and display using Snacks picker
        local items = {}
        for _, keymap in ipairs(keymaps) do
          table.insert(items, {
            text = string.format("%-20s %s", keymap.key, keymap.desc),
            key = keymap.key,
            desc = keymap.desc,
            mode = keymap.mode
          })
        end
        
        Snacks.picker.pick({
          source = 'buffer_keymaps',
          title = 'Buffer Keymaps (' .. vim.bo.filetype .. ')',
          items = items,
          preview = false,
          actions = {
            open = function(item)
              -- Execute the keymap
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(item.key, true, false, true), 'n', false)
            end
          }
        })
      end, desc = 'Buffer Local Keymaps' },
      
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

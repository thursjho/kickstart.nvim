return {
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
      { '<C-p>', function() Snacks.picker.commands() end, desc = 'Commands' },
      { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
      { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { '<leader>N', function() 
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
      { "<leader>Lc", function() Snacks.picker.lsp_config() end, desc = "Lsp Config" },
      { "<leader>Li", '<cmd>LspInfo<cr>', desc = "Lsp Info" },
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

      -- Lazy.nvim commands (LazyVim style)
      { '<leader>l', '<cmd>Lazy<cr>', desc = 'Lazy Home' },
      { '<leader>li', '<cmd>Lazy install<cr>', desc = 'Lazy Install' },
      { '<leader>ls', '<cmd>Lazy sync<cr>', desc = 'Lazy Sync' },
      { '<leader>lu', '<cmd>Lazy update<cr>', desc = 'Lazy Update' },
      { '<leader>lc', '<cmd>Lazy clean<cr>', desc = 'Lazy Clean' },
      { '<leader>lC', '<cmd>Lazy check<cr>', desc = 'Lazy Check' },
      { '<leader>ll', '<cmd>Lazy log<cr>', desc = 'Lazy Log' },
      { '<leader>lr', '<cmd>Lazy restore<cr>', desc = 'Lazy Restore' },
      { '<leader>lx', '<cmd>Lazy clear<cr>', desc = 'Lazy Clear' },
      { '<leader>lp', '<cmd>Lazy profile<cr>', desc = 'Lazy Profile' },
      { '<leader>ld', '<cmd>Lazy debug<cr>', desc = 'Lazy Debug' },
      
      -- Terminal
      { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
      { '<c-_>', function() Snacks.terminal() end, desc = 'Toggle Terminal (which-key)' },
      
      -- Words navigation
      { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
      { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
      
      -- UI toggles (via picker)
      { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorscheme' },
      -- Recent edits (JetBrains-style)
      { '<leader>re', function() require('config.recent_edits').pick() end, desc = 'Recently Edited Locations' },

      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
  },
}

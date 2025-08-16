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
  },

  -- NvCheatsheet for easy keymap viewing
  {
    'smartinellimarco/nvcheatsheet.nvim',
    event = 'VeryLazy',
    opts = {
      header = {
        "██╗  ██╗██╗ ██████╗██╗  ██╗███████╗████████╗ █████╗ ██████╗ ████████╗",
        "██║ ██╔╝██║██╔════╝██║ ██╔╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝",
        "█████╔╝ ██║██║     █████╔╝ ███████╗   ██║   ███████║██████╔╝   ██║   ",
        "██╔═██╗ ██║██║     ██╔═██╗ ╚════██║   ██║   ██╔══██║██╔══██╗   ██║   ",
        "██║  ██╗██║╚██████╗██║  ██╗███████║   ██║   ██║  ██║██║  ██║   ██║   ",
        "╚═╝  ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ",
        "",
        "                     Neovim Kickstart Configuration",
        "",
      },
      keymaps = {
        ['Leader Key'] = {
          { 'Leader key = Space', '<Space>' },
        },
        ['File Operations'] = {
          { 'Smart Find Files', '<leader><space>' },
          { 'Find Files', '<leader>ff' },
          { 'Git Files', '<leader>fg' },
          { 'Recent Files', '<leader>fr' },
          { 'Find Config Files', '<leader>fc' },
          { 'Buffers', '<leader>fb' },
          { 'Delete Buffer', '<leader>bd' },
          { 'Rename File', '<leader>cR' },
        },
        ['Search Operations'] = {
          { 'Grep', '<leader>sg' },
          { 'Current Word', '<leader>sw' },
          { 'Buffer Lines', '<leader>sb' },
          { 'Open Buffers', '<leader>sB' },
          { 'Command History', '<leader>sc' },
          { 'Commands', '<leader>sC' },
          { 'Registers', '<leader>s"' },
          { 'Autocmds', '<leader>sa' },
          { 'Diagnostics', '<leader>sd' },
          { 'Buffer Diagnostics', '<leader>sD' },
          { 'Help Pages', '<leader>sh' },
          { 'Highlight Groups', '<leader>sH' },
          { 'Icons', '<leader>si' },
          { 'Jumps', '<leader>sj' },
          { 'Keymaps', '<leader>sk' },
          { 'Location List', '<leader>sl' },
          { 'Marks', '<leader>sm' },
          { 'Man Pages', '<leader>sM' },
          { 'Pickers', '<leader>sp' },
          { 'Quickfix List', '<leader>sq' },
          { 'Resume', '<leader>sR' },
          { 'Tmux Sessions', '<leader>st' },
          { 'Undo History', '<leader>su' },
        },
        ['Git Operations'] = {
          { 'Lazygit', '<leader>gg' },
          { 'Git Browse', '<leader>gw' },
          { 'Git Branches', '<leader>gb' },
          { 'Git Log', '<leader>gl' },
          { 'Git Log (Current Line)', '<leader>gL' },
          { 'Git Status', '<leader>gs' },
          { 'Git Stash', '<leader>gS' },
          { 'Git Diff (Hunks)', '<leader>gd' },
          { 'Git Log (Current File)', '<leader>gf' },
        },
        ['LSP Operations'] = {
          { 'Goto Definition', 'gd' },
          { 'Goto Declaration', 'gD' },
          { 'Goto References', 'gr' },
          { 'Goto Implementation', 'gI' },
          { 'Type Definition', '<leader>D' },
          { 'Document Symbols', '<leader>ds' },
          { 'Workspace Symbols', '<leader>ws' },
          { 'Rename', '<leader>rn' },
          { 'Code Action', '<leader>ca' },
          { 'Toggle Inlay Hints', '<leader>th' },
        },
        ['Formatting & Linting'] = {
          { 'Format Buffer', '<leader>f' },
          { 'Lint Buffer', '<leader>l' },
        },
        ['Diagnostics (Trouble)'] = {
          { 'Project Diagnostics', '<leader>xx' },
          { 'Buffer Diagnostics', '<leader>xX' },
          { 'Location List', '<leader>xL' },
          { 'Quickfix List', '<leader>xQ' },
          { 'Symbols', '<leader>cs' },
          { 'LSP References', '<leader>cl' },
          { 'Next Trouble', ']t' },
          { 'Prev Trouble', '[t' },
        },
        ['Flash Navigation'] = {
          { 'Flash Jump', 's' },
          { 'Flash Treesitter', 'S' },
          { 'Remote Flash', 'r' },
          { 'Treesitter Search', 'R' },
          { 'Toggle Flash in Search', '<C-s>' },
        },
        ['Testing (Neotest)'] = {
          { 'Run Nearest Test', '<leader>tr' },
          { 'Run File Tests', '<leader>tt' },
          { 'Run All Tests', '<leader>tT' },
          { 'Run Last Test', '<leader>tl' },
          { 'Test Summary', '<leader>ts' },
          { 'Test Output', '<leader>to' },
          { 'Test Output Panel', '<leader>tO' },
          { 'Stop Tests', '<leader>tS' },
          { 'Watch Tests', '<leader>tw' },
        },
        ['Debugging (DAP)'] = {
          { 'Start/Continue Debug', '<F5>' },
          { 'Step Into', '<F1>' },
          { 'Step Over', '<F2>' },
          { 'Step Out', '<F3>' },
          { 'Toggle Breakpoint', '<leader>b' },
          { 'Conditional Breakpoint', '<leader>B' },
          { 'Debug UI Toggle', '<F7>' },
        },
        ['Window Management'] = {
          { 'Resize Left', '<A-h>' },
          { 'Resize Down', '<A-j>' },
          { 'Resize Up', '<A-k>' },
          { 'Resize Right', '<A-l>' },
          { 'Move Cursor Left', '<C-h>' },
          { 'Move Cursor Down', '<C-j>' },
          { 'Move Cursor Up', '<C-k>' },
          { 'Move Cursor Right', '<C-l>' },
          { 'Window Hydra Mode', '<C-w><space>' },
        },
        ['Terminal'] = {
          { 'Toggle Terminal', '<C-/>' },
          { 'Toggle Terminal (alt)', '<C-_>' },
          { 'Exit Terminal Mode', '<Esc><Esc>' },
        },
        ['UI Toggles'] = {
          { 'Spelling', '<leader>us' },
          { 'Line Wrap', '<leader>uw' },
          { 'Line Numbers', '<leader>ul' },
          { 'Relative Numbers', '<leader>uL' },
          { 'Diagnostics', '<leader>ud' },
          { 'Dark/Light Background', '<leader>ub' },
          { 'Inlay Hints', '<leader>uh' },
          { 'Colorscheme', '<leader>uC' },
          { 'Dismiss Notifications', '<leader>un' },
        },
        ['Obsidian Notes'] = {
          { 'Open Note', '<leader>on' },
          { 'New Note', '<leader>oN' },
          { 'Open in Obsidian App', '<leader>oo' },
          { 'Today Note', '<leader>ot' },
          { 'Search Notes', '<leader>os' },
          { 'Quick Switch', '<leader>oq' },
          { 'Backlinks', '<leader>ob' },
          { 'Note Links', '<leader>ol' },
          { 'Tags', '<leader>oT' },
          { 'Rename Note', '<leader>or' },
          { 'Toggle Checkbox', '<leader>ch' },
          { 'Follow Link', 'gf' },
          { 'Smart Action', '<CR>' },
        },
        ['Workspaces'] = {
          { 'Find Workspaces', '<leader>fw' },
          { 'Add Workspace', '<leader>wa' },
          { 'Remove Workspace', '<leader>wr' },
        },
        ['Misc'] = {
          { 'Command History', '<leader>:' },
          { 'Notification History', '<leader>n' },
          { 'Neovim News', '<leader>N' },
          { 'Buffer Keymaps', '<leader>?' },
          { 'Next Reference', ']]' },
          { 'Prev Reference', '[[' },
          { 'Reload Config', '<leader>R' },
        },
      },
    },
    config = function(_, opts)
      local nvcheatsheet = require('nvcheatsheet')
      nvcheatsheet.setup(opts)
      
      -- Set up toggle keybinding
      vim.keymap.set('n', '<leader>?c', function()
        nvcheatsheet.toggle()
      end, { desc = 'Toggle Cheatsheet' })
      
      -- Also bind to F1 for quick access
      vim.keymap.set('n', '<F1>', function()
        nvcheatsheet.toggle()
      end, { desc = 'Toggle Cheatsheet' })
    end,
  },
}
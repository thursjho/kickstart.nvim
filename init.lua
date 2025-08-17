-- Modular Neovim Configuration
-- This configuration has been split into logical modules for better organization

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Load core configuration modules
require('config.options')
require('config.keymaps')
require('config.autocmds')

-- [[ Bootstrap lazy.nvim ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
-- Auto-import all plugin files from plugins directory
local function get_plugin_specs()
  local plugins_dir = vim.fn.stdpath('config') .. '/lua/plugins'
  local plugin_files = vim.fn.glob(plugins_dir .. '/*.lua', false, true)
  local specs = {}

  for _, file_path in ipairs(plugin_files) do
    local filename = vim.fn.fnamemodify(file_path, ':t:r')
    -- Skip init.lua if it exists in plugins directory
    if filename ~= 'init' then
      table.insert(specs, { import = 'plugins.' .. filename })
    end
  end

  return specs
end

require('lazy').setup(get_plugin_specs(), {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
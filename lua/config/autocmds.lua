-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-configure PATH with deduplication
local function add_to_path(dir)
  if vim.fn.isdirectory(dir) == 1 then
    vim.env.PATH = dir .. ':' .. vim.env.PATH
  end
end

-- Function to deduplicate PATH
local function dedupe_path()
  local path = vim.env.PATH or ''
  local seen = {}
  local result = {}
  
  for dir in path:gmatch('[^:]+') do
    if not seen[dir] then
      seen[dir] = true
      table.insert(result, dir)
    end
  end
  
  vim.env.PATH = table.concat(result, ':')
end

-- Set up PATH on startup
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Configure PATH with deduplication',
  group = vim.api.nvim_create_augroup('kickstart-path-config', { clear = true }),
  callback = function()
    -- Add VSCode to PATH if it exists
    add_to_path('/Applications/Visual Studio Code.app/Contents/Resources/app/bin')
    
    -- Deduplicate PATH
    dedupe_path()
  end,
})
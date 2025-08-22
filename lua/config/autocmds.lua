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

-- Remember cursor position in buffers
-- vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
--   desc = 'Remember cursor position in buffers',
--   group = vim.api.nvim_create_augroup('kickstart-remember-cursor', { clear = true }),
--   callback = function()
--     if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line('$') then
--       vim.fn.setpos('.', vim.fn.getpos("'\""))
--     end
--   end,
-- })

-- 커서 위치 복원을 위한 autocmd 그룹 설정
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursorPosition", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype
    -- 'gitcommit' 같은 특정 파일타입은 제외할 수 있음
    if ft == "gitcommit" or ft == "gitrebase" then return end

    -- 이전 커서 위치 가져오기 (" 마크)
    local mark = vim.api.nvim_buf_get_mark(bufnr, '"')
    local line, col = mark[1], mark[2]
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    -- 유효한 위치인지 확인 후 커서 이동
    if line > 0 and line <= line_count then
      vim.api.nvim_win_set_cursor(0, { line, col })
      -- 현재 줄을 화면 중앙으로
      vim.cmd("normal! zvzz")
    end
  end,
  desc = "파일 재오픈 시 마지막 커서 위치로 이동",
})

-- Ensure Obsidian UI features work: set conceallevel for Markdown
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('kickstart-markdown-conceal', { clear = true }),
  pattern = { 'markdown' },
  callback = function()
    -- Obsidian.nvim requires conceallevel 1 or 2 for UI enhancements
    vim.wo.conceallevel = 2
    -- Conceal in normal/command modes, reveal while inserting
    vim.wo.concealcursor = 'nc'
  end,
})

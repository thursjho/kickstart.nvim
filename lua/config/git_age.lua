local M = {}

local ns = vim.api.nvim_create_namespace('git_age_ns')
local enabled_buffers = {}
local ages_by_buf = {}

local signs = {
  day = { name = 'GitAgeDay', char = '▏', hl = 'GitAgeDay' },
  week = { name = 'GitAgeWeek', char = '▏', hl = 'GitAgeWeek' },
  month = { name = 'GitAgeMonth', char = '▏', hl = 'GitAgeMonth' },
}

local thresholds = {
  day = 24 * 60 * 60,
  week = 7 * 24 * 60 * 60,
  month = 30 * 24 * 60 * 60,
}

local function ensure_hl()
  -- Use subtle yet visible colors; adapt if a colorscheme overrides
  if vim.fn.hlexists(signs.day.hl) == 0 then
    vim.api.nvim_set_hl(0, signs.day.hl, { fg = '#e06c75' }) -- red-ish (<= 1 day)
  end
  if vim.fn.hlexists(signs.week.hl) == 0 then
    vim.api.nvim_set_hl(0, signs.week.hl, { fg = '#e5c07b' }) -- yellow-ish (<= 1 week)
  end
  if vim.fn.hlexists(signs.month.hl) == 0 then
    vim.api.nvim_set_hl(0, signs.month.hl, { fg = '#61afef' }) -- blue-ish (<= 1 month)
  end
end

local function git_root(cwd)
  local res = vim.system({ 'git', '-C', cwd, 'rev-parse', '--show-toplevel' }, { text = true }):wait()
  if res.code ~= 0 then
    return nil
  end
  local out = (res.stdout or ''):gsub('\n', '')
  if out == '' then return nil end
  return out
end

local function blame_file(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == '' then return nil, 'No file' end
  local cwd = vim.fn.fnamemodify(filename, ':h')
  local root = git_root(cwd)
  if not root then return nil, 'Not a git repo' end

  local rel = filename
  if vim.startswith(filename, root .. '/') then
    rel = filename:sub(#root + 2)
  end
  local res = vim.system({ 'git', '-C', root, 'blame', '--line-porcelain', rel }, { text = true, cwd = root }):wait()
  if res.code ~= 0 then
    return nil, 'git blame failed'
  end
  local lines = {}
  local current_time
  for line in (res.stdout or ''):gmatch('([^\n]*)\n') do
    if vim.startswith(line, 'author-time ') then
      local ts = tonumber(line:sub(13))
      current_time = ts
    elseif line == '' then
      -- header/body separator; next line will be the blamed content line
    elseif current_time ~= nil then
      table.insert(lines, current_time)
      current_time = nil
    end
  end
  return lines
end

local function clear_marks(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
end

local function place_mark(bufnr, lnum, hl)
  -- Place a thin bar at the window's first column for the given line
  -- Use virt_text_win_col so it appears near the sign column without occupying it
  vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, 0, {
    virt_text = { { signs.day.char, hl } },
    virt_text_win_col = 0,
    priority = 10,
  })
end

local function apply_for_buffer(bufnr)
  ensure_hl()
  clear_marks(bufnr)
  local blames, err = blame_file(bufnr)
  if not blames then
    vim.schedule(function()
      vim.notify('Git age: ' .. err, vim.log.levels.WARN)
    end)
    return
  end
  local now = os.time()
  local last = vim.api.nvim_buf_line_count(bufnr)
  ages_by_buf[bufnr] = {}
  for i = 1, math.min(#blames, last) do
    local age = now - (blames[i] or now)
    ages_by_buf[bufnr][i] = age
    if age <= thresholds.day then
      place_mark(bufnr, i, signs.day.hl)
    elseif age <= thresholds.week then
      place_mark(bufnr, i, signs.week.hl)
    elseif age <= thresholds.month then
      place_mark(bufnr, i, signs.month.hl)
    end
  end
end

function M.enable(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  enabled_buffers[bufnr] = true
  apply_for_buffer(bufnr)
end

function M.disable(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  enabled_buffers[bufnr] = nil
  clear_marks(bufnr)
end

function M.toggle(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if enabled_buffers[bufnr] then
    M.disable(bufnr)
  else
    M.enable(bufnr)
  end
end

function M.setup()
  ensure_hl()
  vim.api.nvim_create_user_command('GitAgeToggle', function()
    M.toggle(0)
  end, { desc = 'Toggle Git age markers for this buffer' })

  -- Refresh marks on write or when reopening window, if enabled
  vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufWinEnter' }, {
    group = vim.api.nvim_create_augroup('git-age-refresh', { clear = true }),
    callback = function(args)
      if enabled_buffers[args.buf] then
        vim.schedule(function()
          apply_for_buffer(args.buf)
        end)
      end
    end,
  })
end

local function ensure_data(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not ages_by_buf[bufnr] or vim.tbl_isempty(ages_by_buf[bufnr]) then
    apply_for_buffer(bufnr)
  end
  return ages_by_buf[bufnr]
end

local function jump(bufnr, dir, max_age)
  local ages = ensure_data(bufnr)
  if not ages then return end
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local cur = vim.api.nvim_win_get_cursor(0)[1]
  local start = cur
  for _ = 1, line_count do
    cur = cur + dir
    if cur < 1 then cur = line_count end
    if cur > line_count then cur = 1 end
    local a = ages[cur]
    if a and a <= max_age then
      vim.api.nvim_win_set_cursor(0, { cur, 0 })
      return
    end
  end
end

function M.next_day(bufnr)
  jump(bufnr or 0, 1, thresholds.day)
end
function M.prev_day(bufnr)
  jump(bufnr or 0, -1, thresholds.day)
end
function M.next_week(bufnr)
  jump(bufnr or 0, 1, thresholds.week)
end
function M.prev_week(bufnr)
  jump(bufnr or 0, -1, thresholds.week)
end
function M.next_month(bufnr)
  jump(bufnr or 0, 1, thresholds.month)
end
function M.prev_month(bufnr)
  jump(bufnr or 0, -1, thresholds.month)
end

-- Commands for navigation
vim.api.nvim_create_user_command('GitAgeNextDay', function()
  M.next_day(0)
end, { desc = 'Next line edited within 1 day' })
vim.api.nvim_create_user_command('GitAgePrevDay', function()
  M.prev_day(0)
end, { desc = 'Prev line edited within 1 day' })
vim.api.nvim_create_user_command('GitAgeNextWeek', function()
  M.next_week(0)
end, { desc = 'Next line edited within 1 week' })
vim.api.nvim_create_user_command('GitAgePrevWeek', function()
  M.prev_week(0)
end, { desc = 'Prev line edited within 1 week' })
vim.api.nvim_create_user_command('GitAgeNextMonth', function()
  M.next_month(0)
end, { desc = 'Next line edited within 1 month' })
vim.api.nvim_create_user_command('GitAgePrevMonth', function()
  M.prev_month(0)
end, { desc = 'Prev line edited within 1 month' })

return M

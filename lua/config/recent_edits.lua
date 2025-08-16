local M = {}

local history = {}
local max_items = 300
local last_by_buf = {}
local current_root = nil
local save_scheduled = false
local filepath

local function state_dir()
  return (vim.fn.stdpath('state') or vim.fn.stdpath('data')) .. '/recent_edits'
end

local function sanitize(path)
  return (path or 'root'):gsub('[^%w%._%-/]', '_'):gsub('/', '∕')
end

local function git_root(cwd)
  local res = vim.system({ 'git', '-C', cwd, 'rev-parse', '--show-toplevel' }, { text = true }):wait()
  if res.code ~= 0 then return nil end
  local out = (res.stdout or ''):gsub('\n', '')
  return out ~= '' and out or nil
end

local function project_root_for_buf(buf)
  local file = filepath(buf)
  local dir = file and vim.fn.fnamemodify(file, ':h') or (vim.uv.cwd() or vim.fn.getcwd())
  return git_root(dir) or dir
end

local function db_path(root)
  local dir = state_dir()
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
  return dir .. '/' .. sanitize(root) .. '.json'
end

local function load_history(root)
  local path = db_path(root)
  local ok, data = pcall(vim.fn.readfile, path)
  if not ok or not data or #data == 0 then
    history = {}
    return
  end
  local decoded = nil
  pcall(function()
    decoded = vim.json and vim.json.decode(table.concat(data, '\n')) or vim.fn.json_decode(table.concat(data, '\n'))
  end)
  history = {}
  if type(decoded) == 'table' then
    for _, it in ipairs(decoded) do
      if it and it.file and vim.fn.filereadable(it.file) == 1 then
        table.insert(history, it)
      end
    end
  end
end

local function save_history()
  if not current_root then return end
  local items = {}
  for i, it in ipairs(history) do
    if i > max_items then break end
    if it.file and vim.startswith(it.file, current_root) then
      table.insert(items, { file = it.file, lnum = it.lnum, col = it.col, line = it.line, ts = it.ts })
    end
  end
  local json = (vim.json and vim.json.encode(items)) or vim.fn.json_encode(items)
  local path = db_path(current_root)
  pcall(vim.fn.writefile, { json }, path)
end

local function schedule_save()
  if save_scheduled then return end
  save_scheduled = true
  vim.defer_fn(function()
    save_history()
    save_scheduled = false
  end, 400)
end

filepath = function(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == '' then return nil end
  return vim.fn.fnamemodify(name, ':p')
end

local function add_entry(buf, lnum, col)
  local file = filepath(buf)
  if not file then return end
  local line = vim.api.nvim_buf_get_lines(buf, math.max(0, lnum - 1), lnum, false)[1] or ''
  local ts = vim.loop.now() -- ms
  -- De-dup by file+lnum
  for i = #history, 1, -1 do
    local it = history[i]
    if it.file == file and math.abs(it.lnum - lnum) <= 1 then
      table.remove(history, i)
      break
    end
  end
  table.insert(history, 1, { file = file, bufnr = buf, lnum = lnum, col = col, line = line, ts = ts })
  if #history > max_items then
    while #history > max_items do table.remove(history) end
  end
end

function M.record(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  -- Ensure current project root and load history if switching projects
  local root = project_root_for_buf(buf)
  if root and root ~= current_root then
    current_root = root
    load_history(current_root)
  end
  local pos = vim.api.nvim_win_get_cursor(0)
  local key = tostring(buf)
  local last = last_by_buf[key]
  -- Debounce per-buffer: only record if moved a few lines or 500ms passed
  local now = vim.loop.now()
  if last and math.abs((pos[1] or 0) - (last.lnum or 0)) < 2 and (now - (last.ts or 0)) < 500 then
    return
  end
  last_by_buf[key] = { lnum = pos[1], ts = now }
  add_entry(buf, pos[1], pos[2])
  schedule_save()
end

local function idx_of_current()
  local curfile = filepath(vim.api.nvim_get_current_buf())
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  if not curfile then return nil end
  for i, it in ipairs(history) do
    if it.file == curfile and math.abs(it.lnum - lnum) <= 1 then
      return i
    end
  end
  return nil
end

local function jump_to(it)
  if not it then return end
  if vim.fn.filereadable(it.file) ~= 1 then return end
  local curbuf = vim.api.nvim_get_current_buf()
  local curfile = filepath(curbuf)
  local target = vim.fn.fnameescape(it.file)
  if curfile == it.file then
    -- Same file; just move the cursor
  else
    if vim.bo.modified then
      -- Avoid E37 by opening target in a split, preserving modified buffer
      vim.cmd('vsplit ' .. target)
    else
      vim.cmd('edit ' .. target)
    end
  end
  pcall(vim.api.nvim_win_set_cursor, 0, { it.lnum, math.max(0, (it.col or 0)) })
end

function M.next()
  if #history == 0 then
    vim.notify('No recent edits in this session.', vim.log.levels.INFO)
    return
  end
  local idx = idx_of_current() or (#history + 1)
  idx = idx - 1
  if idx < 1 then idx = #history end
  jump_to(history[idx])
end

function M.prev()
  if #history == 0 then
    vim.notify('No recent edits in this session.', vim.log.levels.INFO)
    return
  end
  local idx = idx_of_current() or 0
  idx = idx + 1
  if idx > #history then idx = 1 end
  jump_to(history[idx])
end

function M.pick()
  if not pcall(require, 'snacks') then
    vim.notify('Snacks picker not available', vim.log.levels.ERROR)
    return
  end
  local items = {}
  for _, it in ipairs(history) do
    local text = string.format('%s:%d  %s', vim.fn.fnamemodify(it.file, ':.') , it.lnum, it.line:gsub('^%s+', ''))
    table.insert(items, { text = text, file = it.file, lnum = it.lnum })
  end
  require('snacks').picker.pick({
    source = 'recent_edits',
    title = 'Recently Edited Locations',
    items = items,
    preview = { type = 'file' },
    actions = {
      open = function(item)
        vim.cmd('edit ' .. vim.fn.fnameescape(item.file))
        vim.api.nvim_win_set_cursor(0, { item.lnum, 0 })
      end,
    },
  })
end

function M.setup()
  local grp = vim.api.nvim_create_augroup('recent-edits', { clear = true })
  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
    group = grp,
    callback = function(args)
      M.record(args.buf)
    end,
  })
  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    group = grp,
    callback = function(args)
      local root = project_root_for_buf(args.buf)
      if root and root ~= current_root then
        current_root = root
        load_history(current_root)
      end
    end,
  })
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = grp,
    callback = function()
      save_history()
    end,
  })
end

return M

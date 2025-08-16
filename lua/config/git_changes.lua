local M = {}

local function git_root(cwd)
  local res = vim.system({ 'git', '-C', cwd, 'rev-parse', '--show-toplevel' }, { text = true }):wait()
  if res.code ~= 0 then return nil end
  local out = (res.stdout or ''):gsub('\n', '')
  return out ~= '' and out or nil
end

local function run_git(args, cwd)
  local res = vim.system(vim.list_extend({ 'git' }, args), { text = true, cwd = cwd }):wait()
  if res.code ~= 0 then return nil, res.stderr end
  return res.stdout or '', nil
end

local function parse_diff_to_qf(diff_output, repo_root)
  local qf = {}
  local current_file
  for line in (diff_output .. '\n'):gmatch('([^\n]*)\n') do
    local a, b = line:match('^%-%-%- a/(.+)$'), nil
    if a then
      -- keep going until +++
    end
    local plus = line:match('^%+%+%+ b/(.+)$')
    if plus then
      current_file = plus
    end
    local L, S = line:match('^@@ %-%d+,%d+ %+(%d+),(%d+) @@')
    if not L then
      L = line:match('^@@ %-%d+ %+(%d+) @@')
      S = '1'
    end
    if current_file and L then
      table.insert(qf, {
        filename = repo_root .. '/' .. current_file,
        lnum = tonumber(L),
        col = 1,
        text = 'changed hunk',
      })
    end
  end
  return qf
end

local function untracked_files(repo_root)
  local out = run_git({ 'ls-files', '--others', '--exclude-standard' }, repo_root)
  local list = {}
  if type(out) == 'string' then
    for f in (out .. '\n'):gmatch('([^\n]*)\n') do
      if f ~= '' then
        table.insert(list, f)
      end
    end
  end
  return list
end

function M.populate_qf(opts)
  opts = opts or {}
  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  local root = git_root(cwd)
  if not root then
    vim.notify('Not a git repository', vim.log.levels.WARN)
    return 0
  end
  local diff_out, err = run_git({ 'diff', '--no-ext-diff', '--unified=0', '--no-color' }, root)
  if not diff_out then
    vim.notify('git diff failed: ' .. (err or ''), vim.log.levels.ERROR)
    return 0
  end
  local qf = parse_diff_to_qf(diff_out, root)
  if opts.include_untracked ~= false then
    for _, f in ipairs(untracked_files(root)) do
      table.insert(qf, { filename = root .. '/' .. f, lnum = 1, col = 1, text = 'untracked file' })
    end
  end
  vim.fn.setqflist({}, ' ', { title = 'Git Changes (worktree vs index)', items = qf })
  return #qf
end

local function ensure_qf()
  local info = vim.fn.getqflist({ title = 1, size = 1 })
  local size = (info and info.size) or 0
  local ok_title = info and info.title and tostring(info.title):match('Git Changes') ~= nil
  if size == 0 or not ok_title then
    size = M.populate_qf() or 0
  end
  return size
end

function M.next()
  local size = ensure_qf()
  if size == 0 then
    vim.notify('No pending changes (worktree vs index).', vim.log.levels.INFO)
    return
  end
  local ok, err = pcall(vim.cmd.cnext)
  if not ok then
    vim.notify('No next change: ' .. tostring(err), vim.log.levels.INFO)
  end
end

function M.prev()
  local size = ensure_qf()
  if size == 0 then
    vim.notify('No pending changes (worktree vs index).', vim.log.levels.INFO)
    return
  end
  local ok, err = pcall(vim.cmd.cprevious)
  if not ok then
    vim.notify('No previous change: ' .. tostring(err), vim.log.levels.INFO)
  end
end

function M.open_qf()
  local size = ensure_qf()
  if size == 0 then
    vim.notify('No pending changes (worktree vs index).', vim.log.levels.INFO)
    return
  end
  vim.cmd.copen()
end

return M

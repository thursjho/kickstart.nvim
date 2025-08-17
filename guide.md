# Neovim 설정 가이드

이 가이드는 Neovim을 Lua로 설정하는 방법에 대한 종합적인 안내서입니다.

## 목차

1. [기본 Lua 문법](#기본-lua-문법)
2. [Neovim Lua API 핵심 내용](#neovim-lua-api-핵심-내용)
3. [Lazy.nvim 패키지 관리](#lazynvim-패키지-관리)
4. [프로젝트 구조](#프로젝트-구조)
5. [자주 발생하는 문제와 해결책](#자주-발생하는-문제와-해결책)
6. [실용적인 팁들](#실용적인-팁들)

---

## 기본 Lua 문법

### 1. 변수와 타입

```lua
-- 변수 선언 (local 권장)
local name = "neovim"
local age = 5
local is_awesome = true
local config = nil

-- 테이블 (Lua의 핵심 자료구조)
local simple_table = { 1, 2, 3 }
local config_table = {
  name = "neovim",
  version = "0.10",
  plugins = { "telescope", "treesitter" }
}

-- 접근 방법
print(config_table.name)        -- "neovim"
print(config_table["version"])  -- "0.10"
```

### 2. 함수

```lua
-- 함수 정의
local function greet(name)
  return "Hello, " .. name
end

-- 익명 함수
local add = function(a, b)
  return a + b
end

-- 함수를 테이블에 저장
local utils = {
  double = function(x) return x * 2 end,
  square = function(x) return x * x end
}
```

### 3. 조건문과 반복문

```lua
-- 조건문
if vim.fn.has('nvim-0.10') == 1 then
  print("Neovim 0.10+")
elseif vim.fn.has('nvim-0.9') == 1 then
  print("Neovim 0.9")
else
  print("Old Neovim")
end

-- 반복문
local plugins = { "telescope", "treesitter", "lsp" }
for i, plugin in ipairs(plugins) do
  print(i, plugin)
end

-- 테이블 순회
local config = { theme = "dark", font = "fira" }
for key, value in pairs(config) do
  print(key, value)
end
```

### 4. 모듈 시스템

```lua
-- config/utils.lua
local M = {}

M.setup = function()
  print("Utils setup complete")
end

M.get_config = function()
  return { theme = "dark" }
end

return M

-- 사용하는 곳에서
local utils = require('config.utils')
utils.setup()
local config = utils.get_config()
```

---

## Neovim Lua API 핵심 내용

### 1. vim 네임스페이스

```lua
-- 옵션 설정
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- 글로벌 변수
vim.g.mapleader = ' '
vim.g.localleader = ','
vim.g.have_nerd_font = true

-- 환경 변수
if vim.env.TMUX then
  print("Running inside tmux")
end
```

### 2. 키맵 설정

```lua
-- 기본 형식: vim.keymap.set(mode, lhs, rhs, opts)
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save file' })
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- 여러 모드에서 동시에
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Copy to clipboard' })

-- 함수 사용
vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files()
end, { desc = 'Find files' })

-- 버퍼별 키맵
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { 
  buffer = 0, 
  desc = 'Go to definition' 
})
```

### 3. 자동명령 (Autocommands)

```lua
-- 기본 형식
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
  desc = 'Jump to last edit position'
})

-- 그룹으로 관리
local group = vim.api.nvim_create_augroup('MyConfig', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = 'lua',
  callback = function()
    vim.opt_local.shiftwidth = 2
  end,
})
```

### 4. 사용자 명령어

```lua
vim.api.nvim_create_user_command('ReloadConfig', function()
  dofile(vim.env.MYVIMRC)
  print('Config reloaded!')
end, { desc = 'Reload Neovim configuration' })

-- 인수가 있는 명령어
vim.api.nvim_create_user_command('Grep', function(opts)
  vim.cmd('silent grep! ' .. opts.args)
  vim.cmd('copen')
end, { 
  nargs = 1,
  desc = 'Grep and open quickfix'
})
```

---

## Lazy.nvim 패키지 관리

### 1. 기본 설정

```lua
-- init.lua 또는 lazy-bootstrap.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  ui = { border = "rounded" },
  change_detection = { notify = false },
})
```

### 2. 플러그인 명세 작성

```lua
-- plugins/example.lua
return {
  -- 가장 기본적인 형태
  'nvim-lua/plenary.nvim',
  
  -- 설정이 있는 플러그인
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',  -- lazy loading
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    },
    opts = {
      defaults = {
        layout_strategy = 'horizontal',
      }
    },
  },
  
  -- 복잡한 설정
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'python', 'javascript' },
        highlight = { enable = true },
      })
    end,
  },
}
```

### 3. Lazy Loading 전략

```lua
return {
  -- 명령어로 로딩
  { 'plugin/name', cmd = 'CommandName' },
  
  -- 키맵으로 로딩
  { 'plugin/name', keys = '<leader>x' },
  
  -- 이벤트로 로딩
  { 'plugin/name', event = 'BufRead' },
  
  -- 파일타입으로 로딩
  { 'plugin/name', ft = 'python' },
  
  -- 다른 플러그인 로딩 후
  { 'plugin/name', dependencies = 'other/plugin' },
  
  -- 조건부 로딩
  { 
    'plugin/name', 
    enabled = function()
      return vim.fn.executable('some-tool') == 1
    end
  },
}
```

---

## 프로젝트 구조

```
~/.config/nvim/
├── init.lua                    # 진입점
├── lua/
│   ├── config/
│   │   ├── options.lua         # vim.opt 설정들
│   │   ├── keymaps.lua         # 전역 키맵
│   │   ├── autocmds.lua        # 자동명령들
│   │   └── lazy-bootstrap.lua  # lazy.nvim 부트스트랩
│   ├── plugins/
│   │   ├── core.lua           # 핵심 기능 (snacks, which-key 등)
│   │   ├── editor.lua         # 편집 기능 (treesitter, flash 등)
│   │   ├── ui.lua             # UI 테마, 상태바 등
│   │   ├── lsp.lua            # LSP 설정
│   │   ├── completion.lua     # 자동완성
│   │   ├── git.lua            # Git 관련 플러그인
│   │   └── development.lua    # 개발도구 (DAP, testing 등)
│   └── custom/
│       ├── utils.lua          # 유틸리티 함수들
│       ├── recent_edits.lua   # 커스텀 기능
│       └── git_age.lua        # 커스텀 Git 기능
└── README.md                  # 프로젝트 설명
```

### 각 파일의 역할

#### init.lua
```lua
-- 기본 설정 로드
require('config.options')
require('config.keymaps')
require('config.autocmds')

-- 플러그인 관리자 초기화
require('config.lazy-bootstrap')
```

#### config/options.lua
```lua
-- 에디터 옵션
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

-- 검색 관련
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 들여쓰기
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- 리더 키 설정
vim.g.mapleader = ' '
vim.g.localleader = ','
```

#### plugins/*.lua
각 파일은 테이블을 반환하여 lazy.nvim이 로드할 수 있도록 합니다.

---

## 자주 발생하는 문제와 해결책

### 1. "module not found" 에러

**문제**: `attempt to call a nil value` 또는 `module 'xyz' not found`

**원인**: 
- 모듈 경로가 잘못됨
- 플러그인이 아직 로드되지 않음
- 타이핑 실수

**해결책**:
```lua
-- 안전한 require 사용
local ok, module = pcall(require, 'module_name')
if not ok then
  vim.notify('Module not found: module_name', vim.log.levels.ERROR)
  return
end

-- 또는 조건부 로딩
if pcall(require, 'telescope') then
  require('telescope').setup({})
end
```

### 2. 키맵 충돌

**문제**: 키맵이 예상대로 작동하지 않음

**해결책**:
```lua
-- 기존 키맵 확인
vim.keymap.set('n', '<leader>x', function()
  local maps = vim.api.nvim_get_keymap('n')
  for _, map in ipairs(maps) do
    if map.lhs == '<leader>x' then
      print('Conflict found:', vim.inspect(map))
    end
  end
end)

-- 우선순위 설정
vim.keymap.set('n', '<leader>x', my_function, { 
  desc = 'My function',
  nowait = true,  -- which-key 타이밍 회피
  silent = true 
})
```

### 3. Lazy Loading 문제

**문제**: 플러그인이 필요한 시점에 로드되지 않음

**해결책**:
```lua
return {
  'plugin/name',
  -- 너무 구체적인 이벤트는 피하기
  event = 'VeryLazy',  -- 대신 'BufReadPost' 같은 구체적 이벤트
  
  -- 함수 형태로 조건 확인
  config = function()
    if not package.loaded['plugin.name'] then
      vim.notify('Plugin not loaded properly')
      return
    end
    -- 설정 계속...
  end
}
```

### 4. LSP 설정 문제

**문제**: Language Server가 작동하지 않음

**해결책**:
```lua
-- LSP 상태 확인
vim.api.nvim_create_user_command('LspDebug', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print('No LSP clients attached')
  else
    for _, client in ipairs(clients) do
      print('Client:', client.name, 'Status:', client.is_stopped() and 'stopped' or 'running')
    end
  end
end, {})

-- 안전한 LSP 설정
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end
    
    -- 키맵 설정
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { 
      buffer = event.buf,
      desc = 'Go to definition'
    })
  end,
})
```

### 5. 성능 문제

**문제**: Neovim 시작이 느림

**해결책**:
```lua
-- 시작 시간 측정
vim.api.nvim_create_user_command('StartupTime', function()
  vim.cmd('profile start /tmp/nvim-startup.log')
  vim.cmd('profile func *')
  vim.cmd('profile file *')
end, {})

-- lazy loading 최적화
return {
  'heavy/plugin',
  event = 'VeryLazy',  -- 즉시 로딩 대신
  cmd = 'PluginCommand',  -- 명령어로만 로딩
}
```

### 6. 설정 파일 디버깅

```lua
-- 에러 추적을 위한 유틸리티
_G.P = function(...)
  local objects = {}
  for _, v in ipairs({...}) do
    table.insert(objects, vim.inspect(v))
  end
  print(table.concat(objects, '\n'))
  return ...
end

-- 설정 리로드
_G.R = function(name)
  package.loaded[name] = nil
  return require(name)
end
```

---

## 실용적인 팁들

### 1. 모듈화된 설정

```lua
-- config/utils.lua
local M = {}

M.safe_require = function(module_name)
  local ok, module = pcall(require, module_name)
  if not ok then
    vim.notify('Failed to load: ' .. module_name, vim.log.levels.ERROR)
    return nil
  end
  return module
end

M.keymap = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
```

### 2. 조건부 설정

```lua
-- 운영체제별 설정
if vim.fn.has('macunix') then
  vim.opt.clipboard = 'unnamedplus'
elseif vim.fn.has('unix') then
  vim.opt.clipboard = 'unnamedplus'
end

-- 터미널별 설정
if vim.env.TMUX then
  vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>')
end
```

### 3. 자동 설정 업데이트

```lua
-- 설정 파일 변경 시 자동 리로드
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*/nvim/**/*.lua',
  callback = function()
    vim.schedule(function()
      vim.cmd('source ' .. vim.env.MYVIMRC)
      vim.notify('Config reloaded', vim.log.levels.INFO)
    end)
  end,
})
```

### 4. 백업 및 복원

```bash
# 설정 백업
cd ~/.config
tar -czf nvim-backup-$(date +%Y%m%d).tar.gz nvim/

# Git으로 버전 관리
cd ~/.config/nvim
git init
git add .
git commit -m "Initial config"
```

### 5. 디버깅을 위한 명령어들

```lua
-- 유용한 디버깅 명령어들
vim.api.nvim_create_user_command('ConfigEdit', function()
  vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/init.lua')
end, {})

vim.api.nvim_create_user_command('ConfigReload', function()
  -- 모든 설정 모듈 언로드
  for name, _ in pairs(package.loaded) do
    if name:match('^config') or name:match('^plugins') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify('Configuration reloaded!', vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command('LazyHealth', function()
  vim.cmd('Lazy health')
end, {})
```

---

## 마무리

이 가이드를 참고하여 안정적이고 확장 가능한 Neovim 설정을 만들어보세요. 중요한 것은:

1. **점진적 구축**: 한 번에 모든 것을 설정하려 하지 말고 필요에 따라 점진적으로 추가
2. **모듈화**: 기능별로 파일을 분리하여 관리 용이성 확보
3. **에러 처리**: `pcall`을 활용한 안전한 모듈 로딩
4. **문서화**: 각 설정에 주석과 설명을 추가
5. **버전 관리**: Git을 통한 설정 변경사항 추적

문제가 발생하면 `:checkhealth`, `:Lazy health`, `:LspInfo` 같은 내장 진단 도구를 활용하세요.
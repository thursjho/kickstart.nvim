# Neovim Kickstart Configuration

이 설정은 Neovim Kickstart를 기반으로 한 완전한 개발 환경입니다. Frontend(JavaScript/TypeScript/React) 개발과 Python 개발에 최적화되어 있습니다.

## 📁 구조

### 파일 구조

```text
~/.config/nvim-kickstart/
├── init.lua                          # 메인 설정 파일 (자동 플러그인 로딩)
├── lua/
│   ├── config/                      # 핵심 설정 모듈
│   │   ├── options.lua              # Vim 옵션 설정
│   │   ├── keymaps.lua              # 기본 키매핑
│   │   ├── autocmds.lua             # 자동 명령어들
│   │   ├── git_age.lua              # Git age 마커 기능
│   │   ├── git_changes.lua          # Git 변경사항 네비게이션
│   │   └── recent_edits.lua         # 최근 편집 위치 추적
│   └── plugins/                     # 개별 플러그인 파일들
│       ├── snacks.lua               # 핵심 UI (picker, 알림, 터미널, 스크래치)
│       ├── neo-tree.lua             # 파일 탐색기 (트리 뷰)
│       ├── oil.lua                  # 파일 탐색기 (버퍼 스타일)
│       ├── which-key.lua            # 키맵 도움말
│       ├── nvcheatsheet.lua         # 키맵 치트시트
│       ├── kanagawa.lua             # 컬러 테마
│       ├── flash.lua                # 빠른 네비게이션
│       ├── treesitter.lua           # 구문 하이라이팅
│       ├── mini.lua                 # 미니 플러그인 모음
│       ├── nvim-lspconfig.lua       # LSP 설정
│       ├── blink.lua                # 자동완성 엔진
│       ├── conform.lua              # 코드 포맷터
│       ├── nvim-lint.lua            # 코드 린터
│       ├── trouble.lua              # 진단 관리
│       ├── nvim-dap.lua             # 디버거
│       ├── neotest.lua              # 테스트 프레임워크
│       ├── gitsigns.lua             # Git 변경사항 표시
│       ├── blame.lua                # Git blame 정보
│       ├── diffview.lua             # Git diff 뷰어
│       ├── neogit.lua               # Git 인터페이스
│       ├── advanced-git-search.lua  # Git 히스토리 검색
│       ├── octo.lua                 # GitHub 통합
│       ├── obsidian.lua             # Obsidian 노트 관리
│       ├── workspace.lua            # 워크스페이스 관리
│       ├── yanky.lua                # Yank 히스토리
│       ├── nvim-ts-autotag.lua      # HTML/JSX 자동 태그
│       ├── tailwind-tools.lua       # Tailwind CSS 도구
│       ├── todo-comments.lua        # TODO 하이라이팅
│       ├── headlines.lua            # 마크다운 헤드라인
│       ├── bullets.lua              # 마크다운 리스트
│       ├── smart-splits.lua         # 윈도우 관리
│       ├── guess-indent.lua         # 자동 indent 감지
│       ├── outline.lua              # 코드 아웃라인
│       ├── nvim-navbuddy.lua        # 코드 네비게이션
│       ├── ranger.lua               # Ranger 파일 매니저
│       ├── kulala.lua               # HTTP 클라이언트
│       └── lazydev.lua              # Lua 개발 도구
└── README.md                        # 이 파일
```

### 새로운 init.lua 특징

- **간결함**: 기존 3000줄 → 45줄로 대폭 축소
- **자동 로딩**: plugins 디렉토리의 모든 .lua 파일을 자동으로 import
- **모듈화**: 각 플러그인이 개별 파일로 완전 분리
- **유지보수성**: 각 기능을 독립적으로 관리 가능
- **확장성**: 새 플러그인 파일만 추가하면 자동 로딩

### 플러그인 조직 방식

- **개별 파일 구조**: 각 플러그인이 독립적인 .lua 파일로 완전 분리
- **자동 발견**: init.lua가 plugins/ 디렉토리를 스캔하여 모든 플러그인 자동 로드
- **37개 개별 플러그인**: 기능별로 세분화된 독립적 관리

#### 기능별 분류 (실제 파일 기준)

##### 🎯 핵심 UI (5개)

- snacks.lua, neo-tree.lua, oil.lua, which-key.lua, nvcheatsheet.lua

##### ✏️ 편집 도구 (7개)

- flash.lua, treesitter.lua, mini.lua, nvim-ts-autotag.lua, smart-splits.lua, guess-indent.lua, yanky.lua

##### 💻 개발 환경 (8개)

- nvim-lspconfig.lua, blink.lua, conform.lua, nvim-lint.lua, trouble.lua, nvim-dap.lua, neotest.lua, lazydev.lua

##### 🔧 Git 도구 (6개)

- gitsigns.lua, blame.lua, diffview.lua, neogit.lua, advanced-git-search.lua, octo.lua

##### 📝 콘텐츠 작성 (4개)

- obsidian.lua, headlines.lua, bullets.lua, todo-comments.lua

##### 🎨 테마 & 시각 (3개)

- kanagawa.lua, tailwind-tools.lua, outline.lua

##### 🛠️ 유틸리티 (4개)

- workspace.lua, ranger.lua, kulala.lua, nvim-navbuddy.lua

## 🎨 테마

- **Kanagawa** - 일본 전통 미술에서 영감을 받은 아름다운 테마
  - `kanagawa-wave` (기본 다크)
  - `kanagawa-dragon` (다른 다크 변형)
  - `kanagawa-lotus` (라이트 테마)

## 📝 Markdown 작성 향상

- **Headlines**: `headlines.nvim`으로 Markdown/Org 헤드라인과 인용/리스트의 가독성을 향상합니다.
- **Bullets**: `bullets.vim`으로 리스트 편집이 더 편리해집니다.
  - Enter / `o` / `O`: 현재 리스트 자동 이어쓰기
  - `>>` / `<<`: 들여쓰기/내어쓰기에 따라 번호 자동 재정렬
  - 백스페이스: 라인 맨 앞에서 불릿 제거
  - 적용 파일타입: `markdown`, `text`, `gitcommit`

## ⌨️ 주요 키바인딩

### 기본 편집

- `<leader>` = `<Space>`
- `<Esc>` - 검색 하이라이트 제거
- `<Esc><Esc>` - 터미널 모드에서 나가기
- `<leader>R` - Neovim 설정 리로드

#### Yank/Paste 향상 (yanky.nvim)
- `p` / `P` - Yanky 기반 붙여넣기 (히스토리와 연동)
- `gp` / `gP` - 붙여넣기 후 커서 위치 유지
- `]y` / `[y` - Yank 히스토리 순환(다음/이전)
- `<leader>yh` - Yank 히스토리 보기 (Telescope가 있으면 사용, 없으면 기본 UI)

### 파일 및 검색 (Snacks Picker)

#### 주요 파일 검색

- `<leader><space>` - Smart Find Files (스마트 파일 찾기)
- `<leader>,` - 버퍼 목록
- `<leader>/` - 전체 검색 (Grep)
- `<leader>:` - 명령 히스토리
- `<leader>e` - Neo-tree 파일 탐색기 토글
- `<leader>E` - Neo-tree 파일 탐색기 포커스
- `<leader>re` - 최근 수정 위치 목록

### 파일 탐색 (Neo-tree)

- `<leader>e` - Neo-tree 파일 탐색기 토글
- `<leader>E` - Neo-tree 파일 탐색기 포커스
- `<leader>fe` - Neo-tree 탐색기 (Root Dir)
- `<leader>fE` - Neo-tree 탐색기 (Current Working Dir)
- `<leader>ge` - Git 상태 탐색기
- `<leader>be` - 버퍼 탐색기

#### Neo-tree 내부 키맵

- `<Enter>` - 파일/폴더 열기
- `<Space>` - 파일 선택 (비활성화됨 - leader key 충돌 방지)
- `a` - 파일/폴더 추가
- `d` - 파일/폴더 삭제
- `r` - 파일/폴더 이름 변경
- `y` - 파일/폴더 복사
- `x` - 파일/폴더 잘라내기
- `p` - 붙여넣기
- `c` - 파일/폴더 복사 (경로 포함)
- `m` - 파일/폴더 이동
- `q` - Neo-tree 닫기
- `R` - 새로고침
- `?` - 도움말 보기
- `Y` - 파일 경로 클립보드 복사
- `O` - 시스템 앱으로 파일 열기
- `P` - 미리보기 토글

### 파일 탐색 (Oil.nvim)

- `-` - 현재 파일의 상위 디렉토리를 Oil로 열기
- `<leader>i` - Oil 열기
- `<leader>fR` - Ranger 파일 매니저 열기

#### 파일 관련 (f 그룹)

- `<leader>ff` - 파일 찾기
- `<leader>fg` - Git 파일 찾기
- `<leader>fr` - 최근 파일
- `<leader>fc` - 설정 파일 찾기
- `<leader>fb` - 버퍼 목록
- `<leader>fp` - 프로젝트 목록
- `<leader>fw` - 워크스페이스 전환

#### 검색 관련 (s 그룹)

- `<leader>sg` - 전체 검색 (Grep)
- `<leader>sw` - 현재 단어/선택영역 검색
- `<leader>sb` - 현재 버퍼 내 라인 검색
- `<leader>sB` - 열린 버퍼들에서 검색
- `<leader>sc` - 명령 히스토리
- `<leader>sC` - 사용가능한 명령어들
- `<leader>s"` - 레지스터 내용 (복사/붙여넣기 레지스터)
- `<leader>s/` - 검색 히스토리
- `<leader>sa` - 자동 명령어 (autocmds)
- `<leader>sd` - 진단 (Diagnostics)
- `<leader>sD` - 현재 버퍼 진단
- `<leader>sh` - 도움말 페이지
- `<leader>sH` - 하이라이트 그룹
- `<leader>si` - 아이콘 목록
- `<leader>sj` - 점프 목록
- `<leader>sk` - 키맵 목록
- `<leader>sl` - Location List
- `<leader>sm` - 마크 목록
- `<leader>sM` - Man 페이지
- `<leader>sp` - 플러그인 스펙 검색
- `<leader>sq` - Quickfix List
- `<leader>sR` - 마지막 검색 재개
- `<leader>st` - Tmux 세션 목록
- `<leader>su` - Undo 히스토리
- `<leader>p` - Yank 히스토리 (복사한 텍스트 목록)

### Git 관련 (Snacks Picker)

- `<leader>gb` - Git 브랜치
- `<leader>gl` - Git 로그
- `<leader>gL` - Git 로그 (현재 라인)
- `<leader>gs` - Git 상태
- `<leader>gS` - Git Stash
- `<leader>gd` - Git Diff (Hunks)
- `<leader>gf` - Git 로그 (현재 파일)
- `<leader>gg` - Lazygit 열기
- `<leader>gw` - Git Browse (GitHub/GitLab)

### 고급 Git 유틸리티

#### Git Age Markers (최근 변경 시각 표시)

- `<leader>ga` - 현재 버퍼에 최근 변경 시각 색 막대 토글
  - 1일 이내: 빨강 계열, 1주 이내: 노랑 계열, 1달 이내: 파랑 계열
- 이동 키맵(최근 변경 라인 간 점프)
  - `]rd` / `[rd` - 다음/이전 1일 이내 변경 라인
  - `]rw` / `[rw` - 다음/이전 1주 이내 변경 라인
  - `]rm` / `[rm` - 다음/이전 1달 이내 변경 라인
- 동작 방식: `git blame`을 사용해 각 라인의 마지막 커밋 시각을 계산하고, 텍스트 영역의 가장 왼쪽에 얇은 막대(▏)를 표시합니다. Gitsigns 사인 컬럼과 겹치지 않습니다.
- 팁: 대용량 파일/저장소에서 첫 토글 시 잠시 시간이 걸릴 수 있습니다.

#### Git Changes Navigator (작업트리 vs 인덱스)

- 파일 단위 헝크 이동: `]h` / `[h` (gitsigns)
- 프로젝트 전체 변경 이동: `]g` / `[g`
- 변경 목록 Quickfix 열기: `<leader>gq`
- 동작 방식: `git diff --unified=0` 결과와 미추적 파일을 모아 Quickfix를 구성하고, `]g/[g`로 이동합니다.
- 기능: 현재 워킹 디렉터리의 모든 변경사항(스테이지/언스테이지 포함)과 미추적 파일을 한 번에 탐색할 수 있습니다.

#### Recent Edits Tracker (최근 수정 위치 - JetBrains 스타일)

- 프로젝트별로 최근 수정 위치를 기록하고, 재시작 이후에도 유지됩니다.
- 키맵
  - `<leader>re` - 최근 수정 위치 목록 열기 (Snacks Picker, 미리보기 포함)
  - `]e` / `[e` - 다음/이전 최근 수정 위치로 점프
- 기능:
  - 프로젝트별 편집 히스토리 자동 저장 (최대 300개)
  - Git 루트 기준으로 독립적인 히스토리 관리
  - 텍스트 변경 시 실시간 위치 기록
  - 파일명, 라인 번호, 미리보기 텍스트 포함
- 참고: Git과 무관하며, 각 프로젝트(깃 루트 기준)별로 별도 저장됩니다.

### Git Blame (git-blame.nvim)

- `<leader>gW` - Git Blame 커밋 URL 열기
- 커서가 있는 라인의 Git Blame 정보 자동 표시 (0.5초 후)
- 삽입 모드에서는 자동으로 숨김

### Git Interface (Neogit)

#### 기본 명령어

- `<leader>gn` - Neogit 열기 (새 탭에서)
- `<leader>gN` - Neogit 열기 (분할 창에서)
- `<leader>gc` - 빠른 커밋
- `<leader>gp` - Pull
- `<leader>gP` - Push

#### Neogit 내부 키맵 (Status Buffer)

##### 기본 네비게이션

- `q` - Neogit 닫기
- `<Tab>` - 섹션/아이템 펼치기/접기
- `<Enter>` - 파일로 이동
- `<Ctrl-v>` - 수직 분할로 파일 열기
- `<Ctrl-x>` - 수평 분할로 파일 열기
- `<Ctrl-t>` - 새 탭에서 파일 열기

##### 스테이징 작업

- `s` - 파일/헝크 스테이지
- `u` - 파일/헝크 언스테이지
- `S` - 모든 언스테이지된 파일 스테이지
- `U` - 모든 스테이지된 파일 언스테이지
- `<Ctrl-s>` - 모든 파일 스테이지
- `x` - 변경사항 취소 (discard)

##### 헝크 네비게이션

- `{` / `}` - 이전/다음 헝크 헤더로 이동
- `[c]` / `]c` - 스크롤 업/다운

##### 팝업 메뉴 (Magic Keys)

- `c` - 커밋 팝업
- `b` - 브랜치 팝업
- `p` - Pull 팝업
- `P` - Push 팝업
- `f` - Fetch 팝업
- `l` - Log 팝업
- `m` - Merge 팝업
- `r` - Rebase 팝업
- `t` - Tag 팝업
- `Z` - Stash 팝업
- `A` - Cherry-pick 팝업
- `D` - Diff 팝업 (diffview 통합)
- `M` - Remote 팝업
- `X` - Reset 팝업
- `w` - Worktree 팝업
- `?` - 도움말

##### 추가 유틸리티

- `1` / `2` / `3` / `4` - 표시 깊이 조정
- `Y` - 선택된 항목 복사
- `<Ctrl-r>` - 버퍼 새로고침
- ` - 명령어 히스토리
- `I` - 저장소 초기화

#### 커밋 에디터 키맵

- `q` - 에디터 닫기 (커밋 취소)
- `<Ctrl-c><Ctrl-c>` - 커밋 제출
- `<Ctrl-c><Ctrl-k>` - 커밋 중단

#### 리베이스 에디터 키맵

- `p` - Pick (선택)
- `r` - Reword (메시지 변경)
- `e` - Edit (편집)
- `s` - Squash (합치기)
- `f` - Fixup (자동 합치기)
- `d` - Drop (삭제)
- `x` - Execute (명령어 실행)
- `gj` / `gk` - 아래/위로 이동
- `<Enter>` - 커밋 열기

### Advanced Git Search (advanced-git-search.nvim)

#### 콘텐츠 기반 검색 (핵심 기능)

- `<leader>gsc` - Git 로그 콘텐츠 검색 (코드 내용으로 커밋 찾기)
- `<leader>gsf` - 현재 파일에서 Git 콘텐츠 검색

#### 라인 히스토리 및 Diff

- `<leader>gsl` - 선택된 라인의 변경 히스토리
- `<leader>gsr` - 커밋 범위 간 Diff

#### 브랜치 및 파일 작업

- `<leader>gsb` - 현재 파일을 다른 브랜치와 비교
- `<leader>gso` - 현재 브랜치에서 변경된 파일들

#### 고급 네비게이션

- `<leader>gsk` - Reflog에서 체크아웃

### GitHub Integration (Octo.nvim)

#### Issues 관리

- `<leader>ghi` - Issue 목록
- `<leader>ghI` - Issue 생성

#### Pull Request 관리

- `<leader>ghp` - PR 목록
- `<leader>ghP` - PR 생성
- `<leader>ghr` - 리뷰 시작

#### 빠른 작업

- `<leader>ghv` - 브라우저에서 PR 열기
- `<leader>ghc` - PR 체크아웃
- `<leader>ghm` - PR 머지

### Git Diff Viewer (diffview.nvim)

#### 기본 명령어

- `<leader>gd` - DiffView 열기 (변경된 파일들의 diff 보기)
- `<leader>gD` - DiffView 닫기
- `<leader>gh` - 전체 파일 히스토리 보기
- `<leader>gH` - 현재 파일 히스토리 보기
- `<leader>gt` - 파일 패널 토글
- `<leader>gf` - 파일 패널에 포커스
- `<leader>gr` - DiffView 새로고침

#### DiffView 내부 키맵

- `<Tab>` / `<Shift-Tab>` - 다음/이전 파일로 이동
- `gf` - 파일 열기 (이전 탭에서)
- `<Ctrl-w><Ctrl-f>` - 새 분할 창에서 파일 열기
- `<Ctrl-w>gf` - 새 탭에서 파일 열기
- `<leader>e` - 파일 패널 토글
- `g<Ctrl-x>` - 레이아웃 순환 변경
- `[c]` / `]c` - 이전/다음 충돌로 이동

#### 파일 패널 키맵

- `j` / `k` - 위/아래 엔트리로 이동
- `<Enter>`, `o`, `l` - 선택된 파일의 diff 열기
- `-` - 파일 스테이지/언스테이지 토글
- `S` - 모든 파일 스테이지
- `U` - 모든 파일 언스테이지
- `X` - 파일을 원래 상태로 복원
- `R` - 파일 목록 새로고침
- `g?` - 도움말 보기

#### 파일 히스토리 패널 키맵

- `y` - 커밋 해시 복사
- `L` - 커밋 상세 정보 보기
- `<Ctrl-Alt-d>` - 선택된 커밋을 diffview에서 열기
- `g!` - 옵션 패널 열기
- `zR` / `zM` - 모든 폴드 열기/닫기

### LSP (Language Server)

- `gd` - 정의로 이동
- `gD` - 선언으로 이동
- `gr` - 참조 찾기
- `gI` - 구현으로 이동
- `gy` - 타입 정의로 이동
- `<leader>ss` - LSP 심볼
- `<leader>sS` - 워크스페이스 심볼
- `<leader>co` - 코드 아웃라인(Outline) 토글
- `<leader>cb` - Navbuddy 코드 브라우저

### 코드 구조 보기 및 네비게이션

#### Outline.nvim

- `:Outline` 또는 `<leader>co`로 아웃라인 패널을 열고/닫습니다.
- 함수/클래스/변수 등 LSP 심볼을 트리 형태로 표시합니다.
- `<CR>` - 심볼로 점프, `o` - 접기/펼치기, `q` - 닫기

#### Navbuddy

- `<leader>cb` - Navbuddy 코드 브라우저 열기
- LSP 심볼을 계층적으로 탐색하고 바로 점프할 수 있는 UI
- 계층적 네비게이션으로 코드 구조를 직관적으로 탐색

### 코드 포맷팅 및 린팅

- `<leader>f` - 코드 포맷팅 (현재 버퍼)
- `<leader>cl` - 수동 린팅 실행 (현재 버퍼)
- 자동 포맷팅 (저장 시)
- 실시간 린팅 (입력 중)

#### 지원하는 포맷터 및 린터

##### 포맷터 (conform.nvim)

- **Lua**: stylua
- **Markdown**: prettier
- 저장 시 자동 포맷팅 (일부 언어는 LSP fallback)

##### 린터 (nvim-lint)

- **Markdown**: markdownlint
- 실시간 이벤트: BufEnter, BufWritePost, InsertLeave

### Diagnostic 관리 (Trouble.nvim)

#### 목록 보기

- `<leader>xx` - 전체 프로젝트 진단 목록
- `<leader>xX` - 현재 버퍼 진단 목록
- `<leader>xL` - Location List (Trouble)
- `<leader>xQ` - Quickfix List (Trouble)

#### 코드 탐색

- `<leader>cs` - 심볼 목록 (함수, 클래스 등)
- `<leader>cl` - LSP 정의/참조 목록

#### 진단 네비게이션

- `]x` - 다음 문제/진단으로 이동
- `[x` - 이전 문제/진단으로 이동

### 빠른 네비게이션 (Flash.nvim)

#### 기본 점프

- `s` - Flash 점프 (화면 내 임의 위치로 빠른 이동)
- `S` - Flash Treesitter (함수, 클래스 등 구문 요소로 점프)

#### 고급 기능

- `r` - Remote Flash (operator pending 모드에서 원격 동작)
- `R` - Treesitter Search (구문 요소 검색 및 점프)
- `<Ctrl-s>` - 검색 중 Flash 토글

#### 향상된 f/t 동작

- `f`, `F`, `t`, `T` - 문자 찾기 (라벨과 함께 표시)
- `;`, `,` - 다음/이전 문자로 이동

### 구문 기반 이동 (Treesitter Textobjects)

- 설치: `nvim-treesitter-textobjects` (구문 인식 이동 전용 설정)
- 키맵
  - `]f` / `[f` - 다음/이전 함수 시작으로 이동
  - `]F` / `[F` - 다음/이전 함수 끝으로 이동
  - `]c` / `[c` - 다음/이전 클래스 시작으로 이동
  - `]C` / `[C` - 다음/이전 클래스 끝으로 이동
- 참고: 선택(aa/ia 등) 텍스트오브젝트는 `mini.ai`와 충돌을 피하기 위해 비활성화했습니다. 원하시면 선택 기능도 켜드릴 수 있어요.

### 디버깅 (DAP)

#### 기본 컨트롤

- `<F5>` - 디버깅 시작/계속
- `<F10>` - Step Over (한 줄씩 실행)
- `<F11>` - Step Into (함수 안으로)
- `<F12>` - Step Out (함수에서 나오기)

#### 브레이크포인트

- `<leader>db` - 브레이크포인트 토글
- `<leader>dB` - 조건부 브레이크포인트

#### UI 및 기타

- `<leader>du` - 디버그 UI 토글
- `<leader>de` - 표현식/변수 평가 (Normal/Visual)
- `<leader>dr` - REPL 열기
- `<leader>dl` - 마지막 디버그 설정 재실행
- `<leader>dt` - 디버깅 종료

### 윈도우 관리 (Smart Splits)

- `<Alt-h/j/k/l>` - 윈도우 크기 조정
- `<Ctrl-h/j/k/l>` - 윈도우 간 이동
- `<Ctrl-\>` - 이전 윈도우로 이동
- `<leader><leader>h/j/k/l` - 버퍼 위치 교환
- `<Ctrl-w><space>` - 윈도우 하이드라 모드

### 버퍼 관리

- `<leader>bd` - 버퍼 삭제
- `<leader>?` - 현재 버퍼 키맵 보기

### 플러그인 관리 (Lazy.nvim)

- `<leader>l` - Lazy 홈 (플러그인 관리 UI)
- `<leader>li` - 플러그인 설치
- `<leader>ls` - 플러그인 동기화 (설치 + 업데이트 + 정리)
- `<leader>lu` - 플러그인 업데이트
- `<leader>lc` - 사용하지 않는 플러그인 정리
- `<leader>lC` - 플러그인 상태 확인
- `<leader>ll` - 플러그인 로그 보기
- `<leader>lr` - lockfile에서 플러그인 복원
- `<leader>lx` - 캐시 지우기
- `<leader>lp` - 프로파일링 (성능 분석)
- `<leader>ld` - 디버그 정보

### UI 토글

- `<leader>us` - 맞춤법 검사 토글
- `<leader>uw` - 줄바꿈 토글
- `<leader>ul` - 라인 번호 토글
- `<leader>uL` - 상대 라인 번호 토글
- `<leader>ud` - 진단 토글
- `<leader>ub` - 배경색 토글 (light/dark)
- `<leader>uh` - Inlay Hints 토글
- `<leader>ug` - Indent 가이드 토글

### 터미널

- `<Ctrl-/>` or `<Ctrl-_>` - 터미널 토글

### Claude Code (AI 어시스턴트)

#### 기본 채팅 및 작업
- `<leader>ac` - Claude Code 토글
- `<leader>af` - Claude Code 포커스
- `<leader>ar` - Claude Code Resume (이전 대화 재개)
- `<leader>aC` - Claude Code Continue (대화 계속)
- `<leader>am` - Claude 모델 선택

#### 코드 작업
- `<leader>ab` - 현재 버퍼를 Claude에 추가
- `<leader>as` - 선택된 텍스트를 Claude에 전송 (Visual 모드)
- `<leader>as` - 파일 탐색기에서 파일 추가 (Neo-tree, Oil 등)

#### Diff 관리
- `<leader>aa` - Diff 수락
- `<leader>ad` - Diff 거부

### 테스팅 (Neotest Framework)

#### 기본 테스트 명령어

- `<leader>tt` - 가장 가까운 테스트 실행
- `<leader>tf` - 현재 파일의 모든 테스트 실행
- `<leader>ta` - 전체 프로젝트 테스트 실행
- `<leader>tl` - 마지막 테스트 재실행
- `<leader>ts` - 테스트 요약 패널 토글
- `<leader>tS` - 테스트 실행 중단

#### 테스트 디버깅 및 출력

- `<leader>td` - 가장 가까운 테스트 디버깅
- `<leader>to` - 테스트 출력 보기
- `<leader>tO` - 테스트 출력 패널 토글
- `<leader>tw` - 현재 파일 테스트 감시 모드 토글

#### 테스트 네비게이션

- `]t` - 다음 실패한 테스트로 이동
- `[t` - 이전 실패한 테스트로 이동

#### 지원하는 테스트 프레임워크

1. **Python**: pytest 기본 지원, 가상환경 자동 감지
2. **JavaScript/TypeScript**: Jest, Vitest 지원
3. **E2E Testing**: Playwright 지원
4. **설정 자동 감지**: 프로젝트 루트의 설정 파일 자동 탐지

#### 테스트 요약 패널 키맵

- `r` - 선택된 테스트 실행
- `d` - 선택된 테스트 디버깅
- `o` - 테스트 출력 보기
- `e` - 모든 테스트 펼치기
- `w` - 테스트 감시 모드
- `m` - 테스트 마킹
- `R` - 마킹된 테스트들 실행

### Frontend 개발 도구

#### Auto Tag Management (nvim-ts-autotag)

- HTML/JSX 태그 자동 완성
- 태그 이름 변경 시 자동 동기화
- React, Vue, Angular 등 모든 JSX 기반 프레임워크 지원

#### Enhanced Tailwind CSS (tailwind-tools.nvim)

- 실시간 색상 미리보기 (인라인 표시)
- Tailwind 클래스 자동완성 강화
- 다중 파일 타입 지원: HTML, CSS, JS/TS, React, Vue, Svelte, Astro

### Obsidian 노트 관리 (Obsidian.nvim)

#### 기본 Vault 및 노트 관리

- `<leader>ov` - Obsidian Vault 전환 (Snacks Picker 사용)
- `<leader>on` - Obsidian 노트 열기 (Snacks Picker 사용)
- `<leader>oN` - 새 Obsidian 노트 생성
- `<leader>oo` - Obsidian 앱에서 열기

#### 일일 노트 관리

- `<leader>ot` - 오늘 노트 열기
- `<leader>oy` - 어제 노트 열기
- `<leader>om` - 내일 노트 열기

#### 검색 및 네비게이션

- `<leader>os` - Obsidian 노트 검색
- `<leader>oq` - 빠른 노트 전환
- `<leader>ob` - 백링크 보기
- `<leader>ol` - 노트 링크 보기
- `<leader>oT` - 태그 목록 보기

#### 노트 편집 및 유틸리티

- `<leader>op` - 이미지 붙여넣기
- `<leader>or` - 노트 이름 변경
- `<leader>oc` - 목차 생성
- `<leader>otm` - 템플릿 삽입
- `<leader>oe` - 선택 텍스트를 새 노트로 추출 (Visual 모드)

#### 링크 관리

- `<leader>oL` - 선택 텍스트에서 링크 생성 (Visual 모드)
- `<leader>oln` - 새 노트로 링크 생성 (Visual 모드)
- `gf` - 링크 따라가기 (커서가 링크 위에 있을 때)
- `<CR>` - 스마트 액션 (링크 따라가기/체크박스 토글 등)
- `<leader>ch` - 체크박스 토글

#### Obsidian 워크플로우

1. **자동 Vault 탐지**: 다음 경로들에서 자동으로 Obsidian vault를 찾습니다:
   - `~/documents/obsidian/`
   - `~/Documents/Obsidian/`
   - `~/Obsidian/`
   - `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/` (iCloud)
   - `~/iCloudDrive/Obsidian/`
   - `~/Dropbox/Obsidian/`
   - `~/OneDrive/Obsidian/`
2. **디바이스별 설정**: 각 디바이스의 Obsidian vault 위치가 다르더라도 자동으로 감지
3. **동적 워크스페이스**: 일반 마크다운 파일도 Obsidian 기능을 사용할 수 있도록 동적 워크스페이스 지원
4. **빠른 노트 접근**: `<leader>on`으로 최근 수정된 노트 순으로 빠른 검색
5. **일일 노트**: `<leader>ot`로 매일 노트 작성 및 관리
6. **링크 네트워크**: 백링크와 링크를 통한 지식 그래프 구축
7. **템플릿 활용**: `Templates` 폴더의 템플릿을 통한 일관된 노트 구조

#### Obsidian 특별 기능

- **자동 체크박스**: 다양한 체크박스 상태 시각화 (`[ ]`, `[x]`, `[>]`, `[~]`)
- **이미지 관리**: 클립보드 이미지를 `Assets/Images` 폴더에 자동 저장
- **실시간 UI**: 링크, 태그, 하이라이트 텍스트 실시간 스타일링
- **Snacks Picker 통합**: 모든 선택 작업이 일관된 인터페이스로 통합

### 워크스페이스 관리 (Workspace Management)

#### 기본 워크스페이스 명령어

- `<leader>fw` - 워크스페이스 전환 (Snacks Picker 사용)
- `<leader>wa` - 현재 디렉토리를 워크스페이스로 추가
- `<leader>wr` - 워크스페이스 제거

#### 워크스페이스 사용법

1. **워크스페이스 추가**: 프로젝트 폴더에서 `<leader>wa`로 현재 디렉토리를 워크스페이스로 등록
2. **워크스페이스 전환**: `<leader>fw`로 워크스페이스 목록을 보고 선택하여 빠르게 프로젝트 간 이동
3. **워크스페이스 제거**: `<leader>wr`로 불필요한 워크스페이스를 목록에서 제거
4. **자동 파일 탐색기**: 워크스페이스 전환 시 파일 탐색기가 자동으로 열림

#### 워크스페이스 활용 팁

- 여러 프로젝트를 동시에 작업할 때 각각을 워크스페이스로 등록
- 워크스페이스 이름으로 프로젝트를 쉽게 구분
- Snacks Picker를 통해 빠르고 직관적인 워크스페이스 선택

### 기타 유용한 기능

- `<leader>z` - Zen 모드 토글
- `<leader>Z` - 줌 모드 토글
- `<leader>.` - 스크래치 버퍼
- `<leader>S` - 스크래치 버퍼 선택
- `<leader>n` - 알림 히스토리
- `<leader>N` - Neovim 뉴스 보기
- `<leader>un` - 모든 알림 숨기기
- `<leader>cR` - 파일 이름 변경
- `<leader>uC` - 컬러스킴 선택
- `]]` / `[[` - 다음/이전 참조로 이동

### Yank History (Yanky)

#### 복사/붙여넣기 기능

- `p` - 향상된 붙여넣기 (Yanky)
- `P` - 이전 위치에 붙여넣기 (Yanky)
- `gp` - 커서 위치 유지하며 뒤에 붙여넣기
- `gP` - 커서 위치 유지하며 앞에 붙여넣기

#### Yank Ring 순환

- `]y` - 다음 복사 내용으로 순환
- `[y` - 이전 복사 내용으로 순환

#### Yank 히스토리 관리

- `<leader>p` - Yank 히스토리 (Snacks Picker)
- `<leader>s"` - 레지스터 내용 (대안적 접근법)

#### 특징

- **히스토리 저장**: 최대 200개의 복사 내용 저장
- **시스템 클립보드 동기화**: OS 클립보드와 자동 동기화
- **비주얼 피드백**: 복사/붙여넣기 시 하이라이트 표시
- **미리보기**: Snacks Picker에서 복사 내용 미리보기 가능

### 키맵 치트시트 (NvCheatsheet)

- `<F1>` - 키맵 치트시트 토글 (빠른 접근)
- `<leader>?c` - 키맵 치트시트 토글
- `<Esc>` - 치트시트 닫기

## 🔧 설치된 도구들

### 언어 서버 (LSP)

- **Lua** - lua_ls
- **TypeScript/JavaScript** - vtsls (고급 TypeScript 지원)
- **Python** - basedpyright (강력한 타입 검사)
- **HTML** - html-lsp
- **CSS/SCSS** - cssls
- **TailwindCSS** - tailwindcss-lsp
- **Emmet** - emmet_language_server (HTML/CSS 스니펫)

### 포맷터

- **JavaScript/TypeScript** - prettierd, prettier
- **HTML/CSS/SCSS/JSON** - prettier
- **Python** - ruff (포맷팅 + import 정리)
- **Lua** - stylua

### 린터

- **JavaScript/TypeScript** - eslint_d
- **Python** - ruff
- **CSS/SCSS** - stylelint

### 디버거

- **Python** - debugpy
- **JavaScript/TypeScript** - js-debug-adapter

## 🌟 특별한 기능들

### 자동 Indent 감지

- 파일을 열면 기존 코드의 indent 패턴을 자동 분석
- 프로젝트별로 다른 indent 설정 자동 적용
- `.editorconfig` 파일 우선 지원

### Frontend 개발 기능 요약

- **Auto Tag** - HTML/JSX 태그 자동 완성 및 리네임
- **Color Preview** - CSS 색상 코드 실시간 미리보기 (`#ff0000`, `rgb(255,0,0)`)
- **Tag Matching** - `%` 키로 HTML/JSX 태그 간 이동
- **Emmet 지원** - `div.container>p*3` + `<Ctrl-y>,` 로 HTML 생성

### 커서 위치 복원

- 파일을 다시 열면 마지막 편집 위치로 자동 이동
- Git 커밋 메시지 등에서는 제외

### 스마트 검색

- 파일, 텍스트, 심볼, Git 등 통합 검색
- 실시간 미리보기
- 퍼지 매칭 지원

## 🚀 사용법

### Python 개발

1. `.py` 파일 생성
2. 코드 작성 (자동완성, 타입 힌트 제공)
3. 저장 시 자동 포맷팅 (ruff)
4. `<leader>db`로 브레이크포인트 설정 후 `<F5>`로 디버깅

### JavaScript/TypeScript/React 개발

1. 프로젝트 폴더에서 Neovim 실행
2. `.js/.ts/.jsx/.tsx` 파일 편집
3. 자동완성, import 관리, 타입 검사 제공
4. TailwindCSS 클래스명 자동완성
5. React 컴포넌트 디버깅 가능

### HTML/CSS 개발

1. Emmet으로 빠른 HTML 구조 생성
2. CSS 색상 실시간 미리보기
3. TailwindCSS 지원 (강화된 색상 미리보기 및 자동완성)
4. HTML 태그 자동 완성 및 동기화

### 테스트 주도 개발

1. **빠른 테스트 실행**: `<leader>tt`로 커서 위치의 테스트 즉시 실행
2. **파일 단위 테스트**: `<leader>tf`로 현재 파일의 모든 테스트 실행
3. **테스트 감시**: `<leader>tw`로 파일 변경 시 자동 테스트 실행
4. **시각적 피드백**: 테스트 결과를 아이콘과 색상으로 표시
5. **통합 디버깅**: `<leader>td`로 테스트 내에서 직접 디버깅
6. **다중 프레임워크**: Jest, Vitest, Playwright, pytest 동시 지원

### Obsidian 노트 작성

1. **Vault 초기 설정**: `~/Documents/Obsidian/Personal`과 `~/Documents/Obsidian/Work` 폴더 생성
2. **빠른 노트 탐색**: `<leader>on`으로 모든 노트를 최근 수정순으로 검색
3. **일일 노트 습관**: `<leader>ot`로 매일 노트 작성 및 관리
4. **지식 연결**: `[[링크]]` 문법과 백링크를 통한 노트 간 연결
5. **이미지 관리**: `<leader>op`로 클립보드 이미지를 노트에 바로 삽입
6. **템플릿 활용**: `Templates` 폴더의 템플릿으로 일관된 노트 구조 유지

### Tmux 세션 관리

1. `<leader>st`로 tmux 세션 선택기 열기
2. 세션 목록에서 상태(attached/not attached)와 창 개수 확인
3. 세션 선택하면 자동으로 전환
4. tmux 외부에서 실행 시 자동으로 attach

### Git Diff 뷰어 사용법

1. **변경 사항 확인**: `<leader>gd`로 현재 변경된 파일들의 diff 보기
2. **파일 히스토리**: `<leader>gh`로 전체 프로젝트 히스토리, `<leader>gH`로 현재 파일 히스토리
3. **스테이징**: 파일 패널에서 `-`로 개별 파일 스테이지/언스테이지, `S`/`U`로 전체 스테이지/언스테이지
4. **머지 충돌 해결**: `[c]`/`]c`로 충돌 간 이동, `2do`/`3do`로 변경사항 가져오기
5. **레이아웃 변경**: `g<Ctrl-x>`로 horizontal/vertical 레이아웃 순환

### Git Blame 정보 보기

- 파일을 열면 커서가 있는 라인의 Git Blame 정보가 자동으로 표시됩니다
- 커밋 요약, 날짜, 작성자 정보를 한눈에 확인
- `<leader>gW`로 해당 커밋의 웹 URL 열기 (GitHub/GitLab)

### Neogit Git 워크플로우

1. **상태 확인**: `<leader>gn`으로 Neogit 열기
2. **스테이징**: 파일에서 `s`로 스테이지, `u`로 언스테이지
3. **커밋**: `c`로 커밋 팝업 → 옵션 선택 → 커밋 메시지 작성 → `<Ctrl-c><Ctrl-c>`로 제출
4. **푸시**: `P`로 Push 팝업 → 옵션 선택하여 푸시
5. **브랜치 관리**: `b`로 브랜치 팝업 → 새 브랜치 생성, 체크아웃, 삭제 등
6. **리베이스**: `r`로 리베이스 팝업 → 인터랙티브 리베이스로 커밋 정리
7. **Diff 보기**: `D`로 Diff 팝업 → diffview 통합으로 상세 diff 확인

### 통합 Git 도구 사용 팁

#### 계층별 Git 워크플로우

- **빠른 확인**: Snacks Picker(`<leader>gs`, `<leader>gl`)로 상태/로그 빠르게 보기
- **상세 작업**: Neogit(`<leader>gn`)으로 복잡한 Git 작업 수행
- **코드 검색**: Advanced Git Search(`<leader>gsc`, `<leader>gsl`)로 "언제/어디서 바뀌었나" 추적
- **Diff 분석**: Diffview(`<leader>gd`)로 변경사항 상세 비교
- **Blame 추적**: 자동 Git Blame으로 현재 라인 히스토리 추적
- **GitHub 작업**: Octo(`<leader>gh*`)로 Issues/PR 관리
- **빠른 커밋**: `<leader>gc`로 즉시 커밋 화면 열기

#### 검색 중심 워크플로우 (Advanced Git Search 활용)

1. **"이 코드 언제 추가됐지?"** → `<leader>gsc`로 콘텐츠 검색
2. **"이 라인 왜 바뀌었지?"** → `<leader>gsl`로 라인 히스토리 추적
3. **"브랜치 간 차이점은?"** → `<leader>gsb`로 파일 비교
4. **"이 기능 어떻게 구현했지?"** → `<leader>gsf`로 파일 내 검색
5. **검색 결과를 diffview로 상세 분석** → 자동 연동

## 📦 주요 플러그인 목록

### 핵심 플러그인

- **lazy.nvim** - 플러그인 매니저
- **mason.nvim** - LSP/도구 설치 관리자
- **nvim-lspconfig** - LSP 설정
- **blink.cmp** - 자동완성 엔진

### 개발 도구

- **conform.nvim** - 코드 포맷터
- **nvim-lint** - 코드 린터
- **trouble.nvim** - 진단/오류 관리 및 네비게이션
- **nvim-dap** - 디버거 (DAP 프로토콜)
- **nvim-dap-ui** - 디버깅 UI
- **nvim-treesitter** - 구문 하이라이팅
- **neotest** - 통합 테스팅 프레임워크 (Jest, Vitest, Playwright, Python 지원)
- **nvim-ts-autotag** - HTML/JSX 자동 태그 관리
- **tailwind-tools.nvim** - Tailwind CSS 강화 도구

### Git 관련

- **gitsigns.nvim** - Git 변경사항 표시
- **git-blame.nvim** - Git blame 정보 표시
- **diffview.nvim** - Git diff 뷰어 및 파일 히스토리
- **neogit.nvim** - Git 인터페이스 (Magit 스타일)
- **advanced-git-search.nvim** - Git 히스토리 콘텐츠 검색
- **octo.nvim** - GitHub Issues/PR 관리
- **snacks.nvim** - Git 관련 기능 (브랜치, 로그, 상태 등)

### UI/UX

- **kanagawa.nvim** - 컬러스킴
- **which-key.nvim** - 키바인딩 도움말
- **snacks.nvim** - 통합 UI 플러그인 (파일 탐색, 검색, 알림 등)
- **trouble.nvim** - 진단 및 문제 관리 UI
- **flash.nvim** - 빠른 네비게이션 및 점프
- **neo-tree.nvim** - 고급 파일 탐색기 (트리 뷰, Git 통합)
- **oil.nvim** - 파일 탐색기 (netrw 대체)
- **headlines.nvim** - 마크다운 등 파일의 헤드라인 강조 및 폴딩

### Frontend 전용

- **nvim-ts-autotag** - HTML/JSX 자동 태그
- **nvim-colorizer.lua** - CSS 색상 미리보기
- **vim-matchup** - 태그 매칭
- **emmet-vim** - Emmet 지원

### 노트 관리

- **obsidian.nvim** - Obsidian Vault 통합 및 노트 관리 (Snacks Picker 통합)

### 유틸리티

- **smart-splits.nvim** - 스마트 윈도우 관리
- **guess-indent.nvim** - 자동 indent 감지
- **todo-comments.nvim** - TODO 하이라이팅
- **claudecode.nvim** - AI 어시스턴트 (Claude Code)
- **workspaces.nvim** - 워크스페이스 관리 및 프로젝트 간 빠른 전환

## 📋 설정 파일 위치

- 메인 설정: `~/.config/nvim-kickstart/init.lua`
- 핵심 설정 모듈: `~/.config/nvim-kickstart/lua/config/`
- 플러그인 모듈: `~/.config/nvim-kickstart/lua/plugins/`
- 이 README: `~/.config/nvim-kickstart/README.md`

## 🔄 업데이트 및 관리

- `:Lazy` - 플러그인 관리 UI
- `:Mason` - LSP/도구 관리 UI
- `:checkhealth` - 설정 상태 진단
- `:ConformInfo` - 포맷터 상태 확인
- `:LspInfo` - LSP 서버 상태 확인

## 🎯 디버깅 설정

### Python 디버깅

```python
# 브레이크포인트를 설정하고 F5를 누르면 디버깅 시작
def hello_world():
    name = "World"  # 이 줄에 브레이크포인트 설정
    print(f"Hello, {name}!")

hello_world()
```

### JavaScript/React 디버깅

```javascript
// Node.js 스크립트 디버깅
function calculateSum(a, b) {
  const result = a + b; // 브레이크포인트 설정
  return result;
}

console.log(calculateSum(5, 3));
```

### 디버깅 설정 선택

F5를 누르면 다음 옵션들 중 선택:

- **Launch file** - 현재 파일 실행
- **Launch React App** - React 개발 서버 디버깅
- **Attach** - 실행 중인 프로세스에 연결

---

💡 **팁**:

- `<leader>?`를 눌러서 현재 버퍼에서 사용 가능한 모든 키맵을 확인할 수 있습니다!
- 처음 실행 시 모든 플러그인과 도구가 자동으로 설치됩니다.
- `:checkhealth`로 설정 상태를 점검하고 문제를 해결할 수 있습니다.
- 모듈화된 구조로 인해 특정 기능만 수정하거나 비활성화하는 것이 매우 쉬워졌습니다.

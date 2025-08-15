# Neovim Kickstart Configuration

이 설정은 Neovim Kickstart를 기반으로 한 완전한 개발 환경입니다. Frontend(JavaScript/TypeScript/React) 개발과 Python 개발에 최적화되어 있습니다.

## 🎨 테마

- **Kanagawa** - 일본 전통 미술에서 영감을 받은 아름다운 테마
  - `kanagawa-wave` (기본 다크)
  - `kanagawa-dragon` (다른 다크 변형)
  - `kanagawa-lotus` (라이트 테마)

## ⌨️ 주요 키바인딩

### 기본 편집
- `<leader>` = `<Space>`
- `<Esc>` - 검색 하이라이트 제거
- `<Esc><Esc>` - 터미널 모드에서 나가기

### 파일 및 검색 (Snacks Picker)
#### 주요 파일 검색
- `<leader><space>` - Smart Find Files (스마트 파일 찾기)
- `<leader>,` - 버퍼 목록
- `<leader>/` - 전체 검색 (Grep)
- `<leader>:` - 명령 히스토리
- `<leader>e` - 파일 탐색기

#### 파일 관련 (f 그룹)
- `<leader>ff` - 파일 찾기
- `<leader>fg` - Git 파일 찾기
- `<leader>fr` - 최근 파일
- `<leader>fc` - 설정 파일 찾기
- `<leader>fb` - 버퍼 목록
- `<leader>fp` - 프로젝트 목록

#### 검색 관련 (s 그룹)
- `<leader>sg` - 전체 검색 (Grep)
- `<leader>sw` - 현재 단어/선택영역 검색
- `<leader>sb` - 현재 버퍼 내 라인 검색
- `<leader>sB` - 열린 버퍼들에서 검색
- `<leader>sc` - 명령 히스토리
- `<leader>sC` - 사용가능한 명령어들
- `<leader>s"` - 레지스터 내용
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

### Git 관련
- `<leader>gb` - Git 브랜치
- `<leader>gl` - Git 로그
- `<leader>gL` - Git 로그 (현재 라인)
- `<leader>gs` - Git 상태
- `<leader>gS` - Git Stash
- `<leader>gd` - Git Diff (Hunks)
- `<leader>gf` - Git 로그 (현재 파일)
- `<leader>gg` - Lazygit 열기
- `<leader>gB` - Git Browse (GitHub/GitLab)

### LSP (Language Server)
- `gd` - 정의로 이동
- `gD` - 선언으로 이동
- `gr` - 참조 찾기
- `gI` - 구현으로 이동
- `gy` - 타입 정의로 이동
- `<leader>ss` - LSP 심볼
- `<leader>sS` - 워크스페이스 심볼

### 코드 포맷팅 및 린팅
- `<leader>f` - 코드 포맷팅
- 자동 포맷팅 (저장 시)
- 실시간 린팅 (입력 중)

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
- `<leader>cc` - Claude Code 채팅 열기
- `<leader>cn` - 새 대화 시작
- `<leader>ct` - 현재 선택영역에 대해 질문
- `<leader>ce` - 코드 설명 요청
- `<leader>cr` - 코드 리팩토링 요청
- `<leader>cd` - 문서화 요청
- `<leader>cq` - 빠른 질문

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

### Frontend 개발 도구
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
3. TailwindCSS 지원
4. HTML 태그 자동 완성

### Tmux 세션 관리
1. `<leader>st`로 tmux 세션 선택기 열기
2. 세션 목록에서 상태(attached/not attached)와 창 개수 확인
3. 세션 선택하면 자동으로 전환
4. tmux 외부에서 실행 시 자동으로 attach

## 📦 주요 플러그인 목록

### 핵심 플러그인
- **lazy.nvim** - 플러그인 매니저
- **mason.nvim** - LSP/도구 설치 관리자
- **nvim-lspconfig** - LSP 설정
- **blink.cmp** - 자동완성 엔진

### 개발 도구
- **conform.nvim** - 코드 포맷터
- **nvim-lint** - 코드 린터
- **nvim-dap** - 디버거 (DAP 프로토콜)
- **nvim-dap-ui** - 디버깅 UI
- **nvim-treesitter** - 구문 하이라이팅

### UI/UX
- **kanagawa.nvim** - 컬러스킴
- **which-key.nvim** - 키바인딩 도움말
- **snacks.nvim** - 통합 UI 플러그인 (파일 탐색, 검색, 알림 등)
- **gitsigns.nvim** - Git 변경사항 표시

### Frontend 전용
- **nvim-ts-autotag** - HTML/JSX 자동 태그
- **nvim-colorizer.lua** - CSS 색상 미리보기
- **vim-matchup** - 태그 매칭
- **emmet-vim** - Emmet 지원

### 유틸리티
- **smart-splits.nvim** - 스마트 윈도우 관리
- **guess-indent.nvim** - 자동 indent 감지
- **todo-comments.nvim** - TODO 하이라이팅

## 📋 설정 파일 위치
- 메인 설정: `~/.config/nvim-kickstart/init.lua`
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
    const result = a + b;  // 브레이크포인트 설정
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
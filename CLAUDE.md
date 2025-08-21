---
id: CLAUDE
aliases:
  - CLAUDE.md
tags: []
---

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Overview

This is a modular Neovim configuration based on nvim-kickstart with enhancements for frontend development (JavaScript/TypeScript/React) and Python development. The configuration follows a clean modular structure with automatic plugin loading.

### Structure

- `init.lua` - Main configuration file (only 45 lines, auto-loads plugins)
- `lua/config/` - Core configuration modules (options, keymaps, autocmds, etc.)
- `lua/plugins/` - Individual plugin configuration files (one per plugin)
- `README.md` - Comprehensive documentation with keybindings and features

### Plugin Organization

Plugins are organized by category:

- Core UI: snacks.nvim, neo-tree.nvim, oil.nvim, which-key.nvim, nvcheatsheet.nvim
- Editing Tools: flash.nvim, treesitter, mini.nvim, nvim-ts-autotag, smart-splits.nvim, guess-indent.nvim, yanky.nvim
- Development Environment: nvim-lspconfig, blink.cmp, conform.nvim, nvim-lint, trouble.nvim, nvim-dap, neotest, lazydev
- Git Tools: gitsigns.nvim, blame.nvim, diffview.nvim, neogit.nvim, advanced-git-search.nvim, octo.nvim
- Content Creation: obsidian.nvim, headlines.nvim, bullets.vim, todo-comments.nvim
- Theme & Visual: kanagawa.nvim, tailwind-tools.nvim, outline.nvim
- Utilities: workspace.nvim, ranger.nvim, kulala.nvim, nvim-navbuddy

## Key Commands

### Development Workflow

- `<leader>R` - Reload Neovim configuration
- `<leader>f` - Format current buffer (conform.nvim)
- `<leader>l` - Run linters on current buffer (nvim-lint)

### File Navigation

- `<leader><space>` - Smart file finder
- `<leader>e` - Toggle Neo-tree file explorer
- `<leader>E` - Focus Neo-tree file explorer
- `<leader>ff` - Find files
- `<leader>fg` - Find git files
- `<leader>fr` - Recent files
- `<leader>fb` - List buffers
- `<leader>fp` - List projects
- `<leader>fw` - Switch workspace

### Search

- `<leader>/` - Live grep (search in all files)
- `<leader>sw` - Search for word under cursor or selection
- `<leader>sb` - Search within current buffer
- `<leader>sB` - Search within all open buffers

### Git Operations

- `<leader>gs` - Git status (Snacks Picker)
- `<leader>gl` - Git log
- `<leader>gL` - Git log for current line
- `<leader>gn` - Open Neogit (Git interface)
- `<leader>gd` - Git diff viewer (Diffview)
- `<leader>gb` - Git branches
- `<leader>gS` - Git stash
- `<leader>gg` - Open Lazygit
- `<leader>gw` - Browse Git repository (GitHub/GitLab)

### Obsidian Integration

- `<leader>ov` - Switch Obsidian vault (Snacks Picker)
- `<leader>on` - Open Obsidian note (Snacks Picker)
- `<leader>oN` - Create new Obsidian note
- `<leader>oo` - Open note in Obsidian app
- `<leader>ot` - Open today's daily note
- `<leader>os` - Search Obsidian notes
- `<leader>oq` - Quick note switch
- `<leader>ob` - Show backlinks
- `<leader>ol` - Show note links
- `<leader>oT` - List tags
- `<leader>op` - Paste image from clipboard

### AI Assistant (Claude Code)

- `<leader>ac` - Open Claude Code Chat
- `<leader>aC` - Continue Conversation
- `<leader>an` - Start New Conversation
- `<leader>at` - Ask About Selection (Normal/Visual modes)
- `<leader>ae` - Explain Code (Normal/Visual modes)
- `<leader>ar` - Refactor Code (Normal/Visual modes)
- `<leader>ad` - Document Code (Normal/Visual modes)
- `<leader>aq` - Quick Question

### Testing

- `<leader>tt` - Run nearest test
- `<leader>tf` - Run all tests in current file
- `<leader>ta` - Run all tests in project
- `<leader>tl` - Re-run last test
- `<leader>ts` - Toggle test summary panel
- `<leader>td` - Debug nearest test
- `<leader>to` - Show test output
- `<leader>tw` - Toggle test watching mode

### Debugging (DAP)

- `<F5>` - Start/continue debugging
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Conditional breakpoint
- `<leader>du>` - Toggle debug UI
- `<leader>de` - Evaluate expression (Normal/Visual)
- `<leader>dr` - Open REPL
- `<leader>dt` - Terminate debugging session

## Development Guidelines

### Plugin Configuration

Each plugin is configured in its own file under `lua/plugins/`. The main `init.lua` automatically loads all plugin configurations from this directory.

### Code Formatting

Code formatting is handled by conform.nvim with the following formatters:

- Lua: stylua (configuration in `.stylua.toml`)
- JavaScript/TypeScript: prettierd, prettier
- Python: ruff (for formatting + import organization)
- HTML/CSS/SCSS/JSON: prettier

### Linting

Linting is handled by nvim-lint with these linters:

- JavaScript/TypeScript: eslint_d
- Python: ruff
- CSS/SCSS: stylelint

### Language Servers

- Lua: lua_ls
- TypeScript/JavaScript: vtsls
- Python: basedpyright
- HTML: html-lsp
- CSS/SCSS: cssls
- TailwindCSS: tailwindcss-lsp
- Emmet: emmet_language_server

### Keybinding Conventions

- Leader key is Space (`<leader>`)
- Most keybindings follow a consistent pattern with `<leader>` prefix
- Which-key.nvim provides interactive keybinding help
- NvCheatsheet provides comprehensive keybinding reference (`<F1>`)

### Obsidian Configuration

The obsidian.nvim plugin looks for vaults in the directory specified by the `OBSIDIAN_VAULTS_DIR` environment variable. If not set, it will not load any vaults.

### Claude Code Configuration

The claude-code.nvim plugin provides AI assistance within Neovim. It uses the `CLAUDE_CODE_API_KEY` environment variable for authentication. Key features include:

- Interactive chat interface for code-related questions
- Code explanation, refactoring, and documentation capabilities
- Context-aware responses based on current buffer and selection
- Support for multiple programming languages including Lua, JavaScript, TypeScript, and Python


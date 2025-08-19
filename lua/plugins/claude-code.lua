return {
  -- Claude Code - AI Assistant for Neovim
  {
    'greggh/claude-code.nvim',
    lazy = false,
    cmd = {
      'ClaudeCode',
      'ClaudeCodeChat',
      'ClaudeCodeContinue',
      'ClaudeCodeNew',
      'ClaudeCodeAsk',
      'ClaudeCodeExplain',
      'ClaudeCodeRefactor',
      'ClaudeCodeDocument',
      'ClaudeCodeQuick',
    },
    keys = {
      { '<leader>ac', '<cmd>ClaudeCodeChat<cr>', desc = 'Open Claude Code Chat' },
      { '<leader>aC', '<cmd>ClaudeCodeContinue<cr>', desc = 'Continue Conversation' },
      { '<leader>an', '<cmd>ClaudeCodeNew<cr>', desc = 'Start New Conversation' },
      { '<leader>at', '<cmd>ClaudeCodeAsk<cr>', mode = {'n', 'v'}, desc = 'Ask About Selection' },
      { '<leader>ae', '<cmd>ClaudeCodeExplain<cr>', mode = {'n', 'v'}, desc = 'Explain Code' },
      { '<leader>ar', '<cmd>ClaudeCodeRefactor<cr>', mode = {'n', 'v'}, desc = 'Refactor Code' },
      { '<leader>ad', '<cmd>ClaudeCodeDocument<cr>', mode = {'n', 'v'}, desc = 'Document Code' },
      { '<leader>aq', '<cmd>ClaudeCodeQuick<cr>', desc = 'Quick Question' },
    },
    opts = {
      api_key = nil, -- Will use environment variable CLAUDE_CODE_API_KEY
      model = 'claude-3-5-sonnet-20241022',
      max_tokens = 8192,
      temperature = 0.3,
      chat_window_height = 0.7,
      chat_window_width = 0.8,
      system_prompt = [[
You are an expert software development assistant with broad knowledge across all programming languages and frameworks.

Guidelines:
- Write code and comments in English
- Provide explanations and guidance in Korean
- Be language and framework agnostic - help with any technology
- Focus on best practices, clean code principles, and practical solutions
- When refactoring, prioritize readability, performance, and maintainability
- Use appropriate documentation styles for each language (JSDoc, docstring, etc.)
- Provide context-aware suggestions based on the code being analyzed
]],
      prompts = {
        explain = "이 코드의 작동 원리와 목적을 한국어로 설명해주세요. 핵심 로직, 주요 기능, 그리고 코드의 맥락을 중심으로 자세히 설명해주세요.",
        refactor = "Refactor this code to improve readability, performance, and maintainability. Provide the improved code with clear English comments explaining the changes made.",
        document = "Add comprehensive documentation to this code using the appropriate comment style for the language (JSDoc, docstring, inline comments, etc.). Write all comments in English.",
        quick = "다음 개발 관련 질문에 대해 한국어로 간결하고 실용적인 답변을 해주세요:",
      }
    },
    config = function(_, opts)
      -- Set up Claude Code with provided options
      local ok, claude_code = pcall(require, 'claude-code')
      if ok then
        claude_code.setup(opts)
      else
        vim.notify('Claude Code plugin not found or failed to load', vim.log.levels.WARN)
      end
    end,
  },
}
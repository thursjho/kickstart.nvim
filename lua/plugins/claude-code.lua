return {
  -- Claude Code - AI Assistant for Neovim
  {
    'coder/claudecode.nvim',
    lazy = false,
    cmd = {
      'ClaudeCodeChat',
      'ClaudeCodeNew',
      'ClaudeCodeComplete',
      'ClaudeCodeEdit',
    },
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
    opts = {
      -- Authentication
      anthropic_api_key = nil, -- Will use environment variable ANTHROPIC_API_KEY
      
      -- Model configuration
      model = 'claude-3-5-sonnet-20241022',
      max_tokens = 8192,
      temperature = 0.3,
      
      -- UI configuration
      window_opts = {
        height = 0.7,
        width = 0.8,
        relative = 'editor',
        border = 'rounded',
        title = 'Claude Code',
        title_pos = 'center',
      },
      
      -- System message for Claude
      system_message = [[
You are an expert software development assistant with broad knowledge across all programming languages and frameworks.

Guidelines:
- Write code and comments in English
- Provide explanations and guidance in Korean
- Be language and framework agnostic - help with any technology
- Focus on best practices, clean code principles, and practical solutions
- When refactoring, prioritize readability, performance, and maintainability
- Use appropriate documentation styles for each language (JSDoc, docstring, etc.)
- Provide context-aware suggestions based on the code being analyzed
- For edit requests, provide only the modified code without explanations unless asked
]],
    },
    config = function(_, opts)
      -- Set up Claude Code with provided options
      local ok, claudecode = pcall(require, 'claudecode')
      if ok then
        claudecode.setup(opts)
      else
        vim.notify('ClaudeCode plugin not found or failed to load', vim.log.levels.WARN)
      end
    end,
  },
}
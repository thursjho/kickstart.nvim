return {
  -- Claude Code - AI Assistant for Neovim
  {
    'greggh/claude-code.nvim',
    lazy = true,
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
--     opts = {
--       api_key = nil, -- Will use environment variable CLAUDE_CODE_API_KEY
--       model = 'claude-3-5-sonnet-20240620',
--       max_tokens = 8192,
--       temperature = 0.7,
--       chat_window_height = 0.6,
--       chat_window_width = 0.6,
--       system_prompt = [[
-- You are an expert Neovim developer assistant.
-- Your primary role is to help developers with their Neovim configuration and plugin setup.
-- Always provide clear, practical solutions focused on Neovim Lua configuration.
-- ]],
--       prompts = {
--         explain = "Explain the selected code in Korean. Focus on Neovim-specific concepts.",
--         refactor = "Refactor the selected code to improve readability and maintainability.",
--         document = "Add documentation comments to the selected code in Korean.",
--         quick = "Answer the following question concisely in Korean:",
--       }
--     },
    -- init = function()
    --   -- Set up autocommand to initialize Claude Code
    --   vim.api.nvim_create_autocmd('BufEnter', {
    --     pattern = '*',
    --     callback = function()
    --       if not vim.g.claude_code_loaded then
    --         vim.g.claude_code_loaded = true
    --         -- Initialize Claude Code when entering any buffer
    --         pcall(require, 'claude-code')
    --       end
    --     end,
    --     once = true,
    --   })
    -- end,
  },
}
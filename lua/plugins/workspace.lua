return {
  -- Workspaces for project management
  {
    'natecraddock/workspaces.nvim',
    config = function()
      require('workspaces').setup {
        hooks = {
          open_pre = {
            -- If recording, save current session state and stop recording
            'SessionSave',
            -- delete all buffers (does not save changes)
            'silent %bdelete!',
          },
          open = function()
            require('workspaces.util').telescope(require('workspaces').get())
          end,
        }
      }
      
      -- Custom picker integration with snacks
      vim.keymap.set('n', '<leader>fw', function()
        local workspaces = require('workspaces').get()
        local items = {}
        for _, workspace in ipairs(workspaces) do
          table.insert(items, {
            text = workspace.name .. ' (' .. workspace.path .. ')',
            file = workspace.path,
            data = workspace
          })
        end
        
        Snacks.picker.pick({
          source = 'workspaces',
          title = 'Workspaces',
          items = items,
          preview = { type = 'file' },
          actions = {
            open = function(item)
              require('workspaces').open(item.data.name)
            end
          }
        })
      end, { desc = 'Find Workspaces' })
    end,
  }
}

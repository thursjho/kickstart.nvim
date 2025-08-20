local normalize_list = function(t)
  local normalized = {}
  for _, v in pairs(t) do
    if v ~= nil then
      table.insert(normalized, v)
    end
  end
  return normalized
end

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    },
    keys = {
      {
        '<leader>H',
        function()
          local harpoon = require('harpoon')
          harpoon:list():add()
        end,
        desc = 'Harpoon Mark File',
      },
      {
        '<C-e>',
        function()
          local harpoon = require('harpoon')
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon Quick Menu',
      },
      {
        '[e',
        function()
          local harpoon = require('harpoon')
          harpoon:list():prev()
        end,
        desc = 'Harpoon Previous Mark',
      },
      {
        ']e',
        function()
          local harpoon = require('harpoon')
          harpoon:list():next()
        end,
        desc = 'Harpoon Next Mark',
      },
      {
        '<leader>1',
        function()
          local harpoon = require('harpoon')
          harpoon:list():select(1)
        end,
        desc = 'Harpoon to File 1',
      },
      {
        '<leader>2',
        function()
          local harpoon = require('harpoon')
          harpoon:list():select(2)
        end,
        desc = 'Harpoon to File 2',
      },
      {
        '<leader>3',
        function()
          local harpoon = require('harpoon')
          harpoon:list():select(3)
        end,
        desc = 'Harpoon to File 3',
      },
      {
        '<leader>4',
        function()
          local harpoon = require('harpoon')
          harpoon:list():select(4)
        end,
        desc = 'Harpoon to File 4',
      },
      {
        '<leader>5',
        function()
          local harpoon = require('harpoon')
          harpoon:list():select(5)
          end,
        desc = 'Harpoon to File 5',
      },
      {
        '<leader>hh',
        function()
          Snacks.picker({
            finder = function()
              local file_paths = {}
              local list = normalize_list(harpoon:list().items)
              for i, item in ipairs(list) do
                table.insert(file_paths, { text = item.value, file = item.value })
              end
              return file_paths
            end,
            win = {
              input = {
                keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
              },
              list = {
                keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
              },
            },
            actions = {
              harpoon_delete = function(picker, item)
                local to_remove = item or picker:selected()
                harpoon:list():remove({ value = to_remove.text })
                harpoon:list().items = normalize_list(harpoon:list().items)
                picker:find({ refresh = true })
              end,
            },
          })
        end,
        desc = "pick harpoon
      }
    },
  },
}

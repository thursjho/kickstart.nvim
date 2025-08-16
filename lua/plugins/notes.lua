-- Note-taking and documentation plugins
return {
  -- Obsidian integration
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = function()
      -- Auto-detect common Obsidian vault locations
      local function find_vaults()
        local possible_paths = {
          vim.fn.expand('~/Documents/Obsidian'),
          vim.fn.expand('~/Obsidian'),
          vim.fn.expand('~/Library/Mobile Documents/iCloud~md~obsidian/Documents'),
          vim.fn.expand('~/iCloudDrive/Obsidian'),
          vim.fn.expand('~/Dropbox/Obsidian'),
          vim.fn.expand('~/OneDrive/Obsidian'),
        }
        
        local workspaces = {}
        
        for _, base_path in ipairs(possible_paths) do
          if vim.fn.isdirectory(base_path) == 1 then
            -- Get all subdirectories in the base path
            local vaults = vim.fn.globpath(base_path, '*', false, true)
            for _, vault_path in ipairs(vaults) do
              if vim.fn.isdirectory(vault_path) == 1 then
                local vault_name = vim.fn.fnamemodify(vault_path, ':t')
                table.insert(workspaces, {
                  name = vault_name,
                  path = vault_path,
                })
              end
            end
            break -- Use first found base path
          end
        end
        
        -- Fallback: if no vaults found, provide default locations
        if #workspaces == 0 then
          workspaces = {
            {
              name = 'Personal',
              path = vim.fn.expand('~/Documents/Obsidian/Personal'),
            },
            {
              name = 'Work', 
              path = vim.fn.expand('~/Documents/Obsidian/Work'),
            },
          }
        end
        
        return workspaces
      end

      return {
        workspaces = find_vaults(),
        detect_cwd = true, -- Auto-detect if current directory is a vault
        completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      mappings = {
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ['<leader>ch'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      new_notes_location = 'current_dir',
      note_id_func = function(title)
        local suffix = ''
        if title ~= nil then
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.date('%Y-%m-%d')) .. '-' .. suffix
      end,
      wiki_link_func = 'use_alias_only',
      markdown_link_func = function(opts)
        return require('obsidian.util').markdown_link(opts)
      end,
      preferred_link_style = 'wiki',
      disable_frontmatter = false,
      note_frontmatter_func = function(note)
        if note.title then
          note:add_alias(note.title)
        end
        
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        
        return out
      end,
      templates = {
        folder = 'Templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        substitutions = {},
      },
      follow_url_func = function(url)
        vim.fn.jobstart { 'open', url }
      end,
      use_advanced_uri = false,
      open_app_foreground = false,
      picker = {
        name = 'telescope.nvim',
        note_mappings = {
          new = '<C-x>',
          insert_link = '<C-l>',
        },
        tag_mappings = {
          tag_note = '<C-x>',
          insert_tag = '<C-l>',
        },
      },
      sort_by = 'modified',
      sort_reversed = true,
      search_max_lines = 1000,
      open_notes_in = 'current',
      ui = {
        enable = true,
        update_debounce = 200,
        max_file_length = 5000,
        checkboxes = {
          [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
          ['x'] = { char = '', hl_group = 'ObsidianDone' },
          ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
          ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
          ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        },
        bullets = { char = '•', hl_group = 'ObsidianBullet' },
        external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
        reference_text = { hl_group = 'ObsidianRefText' },
        highlight_text = { hl_group = 'ObsidianHighlightText' },
        tags = { hl_group = 'ObsidianTag' },
        block_ids = { hl_group = 'ObsidianBlockID' },
        hl_groups = {
          ObsidianTodo = { bold = true, fg = '#f78c6c' },
          ObsidianDone = { bold = true, fg = '#89ddff' },
          ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
          ObsidianTilde = { bold = true, fg = '#ff5370' },
          ObsidianImportant = { bold = true, fg = '#d73128' },
          ObsidianBullet = { bold = true, fg = '#89ddff' },
          ObsidianRefText = { underline = true, fg = '#c792ea' },
          ObsidianExtLinkIcon = { fg = '#c792ea' },
          ObsidianTag = { italic = true, fg = '#89ddff' },
          ObsidianBlockID = { italic = true, fg = '#89ddff' },
          ObsidianHighlightText = { bg = '#75662e' },
        },
      },
      attachments = {
        img_folder = 'Assets/Images',
        img_name_func = function()
          return string.format('%s-', os.time())
        end,
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format('![%s](%s)', path.name, path)
        end,
      },
      }
    end,
    keys = {
      { '<leader>oo', '<cmd>ObsidianOpen<cr>', desc = 'Open note in Obsidian app' },
      { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'Create new note' },
      { '<leader>oq', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick switch' },
      { '<leader>of', '<cmd>ObsidianFollowLink<cr>', desc = 'Follow link under cursor' },
      { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Show backlinks' },
      { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'Show tags' },
      { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Search notes' },
      { '<leader>ow', '<cmd>ObsidianWorkspace<cr>', desc = 'Switch workspace' },
      { '<leader>od', '<cmd>ObsidianDailies<cr>', desc = 'Open daily notes' },
      { '<leader>or', '<cmd>ObsidianRename<cr>', desc = 'Rename note' },
      { '<leader>ol', '<cmd>ObsidianLinks<cr>', desc = 'Collect all links' },
      { '<leader>oT', '<cmd>ObsidianTemplate<cr>', desc = 'Insert template' },
    },
    config = function(_, opts)
      require('obsidian').setup(opts())
      
      -- Configure snacks picker integration
      vim.keymap.set('n', '<leader>of', function()
        local obsidian = require('obsidian')
        local client = obsidian.get_client()
        
        if not client then
          vim.notify('No Obsidian client found', vim.log.levels.ERROR)
          return
        end
        
        local notes = client:find_notes('')
        local items = {}
        
        for _, note in ipairs(notes) do
          local title = note.title or note.id
          table.insert(items, {
            text = title,
            file = tostring(note.path),
            note = note
          })
        end
        
        Snacks.picker.pick({
          source = 'obsidian_notes',
          title = 'Obsidian Notes',
          items = items,
          preview = { type = 'file' },
          actions = {
            open = function(item)
              vim.cmd('edit ' .. item.file)
            end
          }
        })
      end, { desc = 'Find Obsidian Notes' })
      
      vim.keymap.set('n', '<leader>ot', function()
        local obsidian = require('obsidian')
        local client = obsidian.get_client()
        
        if not client then
          vim.notify('No Obsidian client found', vim.log.levels.ERROR)
          return
        end
        
        local tags = {}
        local notes = client:find_notes('')
        
        for _, note in ipairs(notes) do
          if note.tags then
            for _, tag in ipairs(note.tags) do
              if not vim.tbl_contains(tags, tag) then
                table.insert(tags, tag)
              end
            end
          end
        end
        
        local items = {}
        for _, tag in ipairs(tags) do
          table.insert(items, {
            text = '#' .. tag,
            tag = tag
          })
        end
        
        Snacks.picker.pick({
          source = 'obsidian_tags',
          title = 'Obsidian Tags',
          items = items,
          preview = false,
          actions = {
            open = function(item)
              local tagged_notes = {}
              for _, note in ipairs(notes) do
                if note.tags and vim.tbl_contains(note.tags, item.tag) then
                  table.insert(tagged_notes, {
                    text = note.title or note.id,
                    file = tostring(note.path),
                    note = note
                  })
                end
              end
              
              Snacks.picker.pick({
                source = 'obsidian_tagged_notes',
                title = 'Notes with tag: #' .. item.tag,
                items = tagged_notes,
                preview = { type = 'file' },
                actions = {
                  open = function(note_item)
                    vim.cmd('edit ' .. note_item.file)
                  end
                }
              })
            end
          }
        })
      end, { desc = 'Find Obsidian Tags' })
    end,
  }
}
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
      -- Find Obsidian vaults from environment variable
      local function find_vaults()
        -- Check if OBSIDIAN_VAULTS_DIR environment variable is set
        local vaults_base_dir = os.getenv('OBSIDIAN_VAULTS_DIR')
        local workspaces = {}
        
        -- If environment variable is set, find vaults in that directory
        if vaults_base_dir and vim.fn.isdirectory(vaults_base_dir) == 1 then
          -- Get all subdirectories in the base path
          local vaults = vim.fn.globpath(vaults_base_dir, '*', false, true)
          for _, vault_path in ipairs(vaults) do
            if vim.fn.isdirectory(vault_path) == 1 then
              local vault_name = vim.fn.fnamemodify(vault_path, ':t')
              table.insert(workspaces, {
                name = vault_name,
                path = vault_path,
              })
            end
          end
        end
        
        return workspaces
      end

      local workspaces = find_vaults()
      
      -- Add dynamic workspace for any directory (replaces detect_cwd)
      table.insert(workspaces, {
        name = "no-vault",
        path = function()
          return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
        end,
        overrides = {
          notes_subdir = vim.NIL, -- Don't enforce notes subdirectory
          new_notes_location = "current_dir",
        }
      })

      -- Helper: determine if any configured workspace has a valid Templates dir
      local function any_templates_exist(ws)
        for _, w in ipairs(ws) do
          local base = type(w.path) == 'string' and w.path or nil
          if base and vim.fn.isdirectory(base .. '/Templates') == 1 then
            return true
          end
        end
        return false
      end

      local cfg = {
        workspaces = workspaces,
        completion = {
          nvim_cmp = false, -- Using blink.cmp instead
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
      -- Only enable templates if a Templates folder exists in at least one workspace
      templates = any_templates_exist(workspaces) and {
        folder = 'Templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        substitutions = {},
      } or nil,
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

      return cfg
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
      require('obsidian').setup(opts)
      
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
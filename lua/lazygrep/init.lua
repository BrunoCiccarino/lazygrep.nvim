local telescope = require('telescope')
local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values
local Path = require('plenary.path')

local lazygrep = {}

local function search_files_with_regex(search_term)
  local results = {}
  local cwd = vim.loop.cwd()

  local function scan_directory(dir)
    for _, file in ipairs(vim.fn.readdir(dir)) do
      local path = Path:new(dir, file)
      if path:is_dir() then
        scan_directory(path:absolute())
      elseif path:is_file() then
        for line_number, line in ipairs(vim.fn.readfile(path:absolute())) do
          if line:find(search_term) then
            table.insert(results, {
              filename = path:make_relative(cwd),
              lnum = line_number,
              text = line,
            })
          end
        end
      end
    end
  end

  scan_directory(cwd)
  return results
end

function lazygrep.search(opts)
  opts = opts or {}

  pickers.new(opts, {
    prompt_title = 'LazyGrep (Type to search)',
    finder = finders.new_dynamic {
      entry_maker = function(entry)
        return {
          value = entry,
          display = string.format('%s:%d: %s', entry.filename, entry.lnum, entry.text),
          ordinal = entry.filename .. ' ' .. entry.text,
          filename = entry.filename,
          lnum = entry.lnum,
        }
      end,
      fn = function(prompt)
        if not prompt or prompt == "" then
          return {}
        end
        return search_files_with_regex(prompt)
      end,
    },
    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry, status)
        conf.buffer_previewer_maker(entry.filename, self.state.bufnr, status)
        vim.api.nvim_buf_add_highlight(self.state.bufnr, -1, 'TelescopePreviewLine', entry.lnum - 1, 0, -1)
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(_, map)
      map('i', '<CR>', actions.select_default + actions.center)
      return true
    end,
  }):find()
end

function lazygrep.setup(opts)
  opts = opts or {}
  lazygrep.default_opts = opts
  vim.api.nvim_create_user_command('LazyGrep', function(args)
    lazygrep.search({
      search_term = table.concat(args.fargs, ' '),
    })
  end, {
    nargs = '*',
  })
end

return lazygrep

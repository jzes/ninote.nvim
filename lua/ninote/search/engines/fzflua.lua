local config = require("ninote.config")
local common = require("ninote.search.engines.common")
local ui = require("ninote.ui")

local FZFLUA_PROMPT = "Search in notes > "
local PARSE_FZFGREP_RESULT_REGEX = ".-([%w%-%._/]+):(%d+):"
local OPEN_OPTION_BUFFER = "buffer"
local OPEN_OPTION_FLOAT = "float"

local M = {}

M.ENGINE_NAME = "fzf-lua"

local function open_fzflua_grep_float(dir, fzf)
  fzf.live_grep({
    cwd = dir,
    prompt = FZFLUA_PROMPT,
    actions = {
      ["default"] = function(selected)
        local line = selected[1]
        if not line then return end

        -- Divide em: arquivo, número da linha, conteúdo
        local file_name, line_number = line:match(PARSE_FZFGREP_RESULT_REGEX)
        if not file_name or not line_number then return end

        local filepath = dir .. "/" .. file_name
        local buf, win = ui.open_in_floating_window(filepath)

        ui.send_cursor_to_line(buf, win, tonumber(line_number))
        ui.set_quit_command(buf)
      end,
    },
  })
end

local function open_fzflua_grep_buffer(dir, fzf)
  fzf.live_grep({ cwd = dir, prompt = FZFLUA_PROMPT })
end

function M.search_in_notes(dir)
  print(dir)
  print(vim.fn.isdirectory(dir))
  local ok, fzf = common.check_engine(M.ENGINE_NAME)
  print(package.loaded["fzf-lua"])
  if not ok then return end

  local open_search_option = config.get_config().open_search
  if open_search_option == OPEN_OPTION_BUFFER then
    open_fzflua_grep_buffer(dir, fzf)
  elseif open_search_option == OPEN_OPTION_FLOAT then
    open_fzflua_grep_float(dir, fzf)
  else
    vim.notify("No OpenSearch config seted, please set as 'buffer' or 'float'", vim.log.levels.ERROR)
  end
end

return M

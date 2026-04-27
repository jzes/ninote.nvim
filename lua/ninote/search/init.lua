local config = require("ninote.config")
local fzf_lua_search_engine = require("ninote.search.engines.fzflua")
local M = {}

M.engines = {}
M.engines[fzf_lua_search_engine.ENGINE_NAME] = fzf_lua_search_engine

function M.search_in_notes()
  local search_engine_name = config.get_config().search_engine
  local notes_dir = vim.fn.expand(config.get_config().note_dir)
  M.engines[search_engine_name].search_in_notes(notes_dir)
end

return M

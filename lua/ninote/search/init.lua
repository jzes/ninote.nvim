local init = require("ninote")
local fzfLuaSearchEngine = require("ninote.search.engines.fzflua")
local searcher = {}

searcher.Engines = {}
searcher.Engines[fzfLuaSearchEngine.ENGINE_NAME] = fzfLuaSearchEngine

function searcher.SearchInNotes()
    local searchEngineName = init.config.SearchEngine
    local notesDir = vim.fn.expand(init.config.NoteDir)
    searcher.Engines[searchEngineName].searchInNotes(notesDir)
end

return searcher

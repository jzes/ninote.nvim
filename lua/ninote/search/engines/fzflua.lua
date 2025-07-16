local init = require("ninote")
local common = require("ninote.search.engines.common")
local ui = require("ninote.ui")

local FZFLUA_PROMPT = "Search in notes > "
local PARSE_FZFGREP_RESULT_REGEX = ".-([%w%-%._/]+):(%d+):"
local OPEN_OPTION_BUFFER = "buffer"
local OPEN_OPTION_FLOAT = "float"

local fzfLuaSearchEngine = {}

fzfLuaSearchEngine.ENGINE_NAME = "fzf-lua"

function fzfLuaSearchEngine.openFzfLuaGrepAsFloat(dir, fzf)
    fzf.live_grep({
        cwd = dir,
        prompt = FZFLUA_PROMPT,
        actions = {
            ["default"] = function(selected)
                local line = selected[1]
                if not line then return end

                -- Divide em: arquivo, número da linha, conteúdo
                local fileName, lineNumber = line:match(PARSE_FZFGREP_RESULT_REGEX)
                if not fileName or not lineNumber then return end

                local filepath = dir .. "/" .. fileName
                local buf, win = ui.OpenInFloatingWindow(filepath)

                ui.SendCursorToLine(buf, win, tonumber(lineNumber))
                ui.SetQuitCommand(buf)
            end,
        },
    })
end

function fzfLuaSearchEngine.openFzfLuaGrepAsBuffer(dir, fzf)
    fzf.live_grep({ cwd = dir, prompt = FZFLUA_PROMPT })
end

function fzfLuaSearchEngine.searchInNotes(dir)
    local ok, fzf = common.checkEngine(fzfLuaSearchEngine.ENGINE_NAME)
    if not ok then return end

    if init.config.OpenSearch == OPEN_OPTION_BUFFER then
        fzfLuaSearchEngine.openFzfLuaGrepAsBuffer(dir, fzf)
    elseif init.config.OpenSearch == OPEN_OPTION_FLOAT then
        fzfLuaSearchEngine.openFzfLuaGrepAsFloat(dir, fzf)
    else
        vim.notify("No OpenSearch config seted, please set as 'buffer' or 'float'", vim.log.levels.ERROR)
    end
end

return fzfLuaSearchEngine

local common = {}

function common.checkEngine(searchEngineName)
    local ok, searchEngine = pcall(require, searchEngineName)
    if not ok then
        vim.notify(searchEngineName .. " is not installed", vim.log.levels.ERROR)
    end
    return ok, searchEngine
end

return common

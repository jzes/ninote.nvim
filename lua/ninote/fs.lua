local init = require("ninote")
local fs = {}

local DATE_FORMAT = "%Y-%m-%d"

function fs.GetCurrentNotePath()
    return vim.fn.expand(init.config.NoteDir) .. "/current.md"
end

function fs.CreateNoteDir(filePath)
    vim.fn.mkdir(vim.fn.fnamemodify(filePath, ":h"), "p")
end

function fs.FileExists(path)
    return vim.fn.filereadable(path) ~= 0
end

function fs.CreateNoteFile(filePath)
    if not fs.FileExists(filePath) then
        local file = io.open(filePath, "w")
        if file then
            file:write("# " .. init.config.NewNoteHeader)
            file:close()
        else
            vim.notify("error on start new note file" .. filePath, vim.log.levels.ERROR)
            return false
        end
    end
    return true
end

function fs.CheckCurrentNote(currentNotePath)
    if not fs.FileExists(currentNotePath) then
        vim.notify("No note open to close", vim.log.levels.WARN)
        return false
    end
    return true
end

function fs.getFinalNoteName(currentNotePath, newNoteName)
    if newNoteName and newNoteName ~= "" then
        return newNoteName:gsub("%s+", "-") .. ".md"
    end

    local datePrefix = os.date(DATE_FORMAT)
    local fileCounter = 1

    local finalFileName

    repeat
        finalFileName = string.format("%s-%d", datePrefix, fileCounter)
        fileCounter = fileCounter + 1
    until not fs.FileExists(currentNotePath .. "/" .. finalFileName)

    return finalFileName
end

function fs.MoveNote(newNoteName)
    local currentNotePath = fs.GetCurrentNotePath()
    local notePath = vim.fn.fnamemodify(currentNotePath, ":h")
    local newFileName = fs.getFinalNoteName(notePath, newNoteName)

    local closedNotePath = notePath .. "/" .. newFileName
    local ok, err = os.rename(currentNotePath, closedNotePath)

    if ok then
        vim.notify("Nota arquivada como: " .. newFileName, vim.log.levels.INFO)
    else
        vim.notify("Erro ao arquivar nota: " .. (err or ""), vim.log.levels.ERROR)
    end
end

return fs

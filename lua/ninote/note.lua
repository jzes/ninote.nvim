local fs = require("ninote.fs")
local ui = require("ninote.ui")

local note = {}

function note.New()
    local filePath = fs.GetCurrentNotePath()

    fs.CreateNoteDir(filePath)
    local ok = fs.CreateNoteFile(filePath)
    if not ok then
        return
    end

    local buf, win = ui.OpenInFloatingWindow(filePath)
    ui.SetQuitCommand(buf)
    ui.SendCursorToEnd(buf, win)
end

function note.Close()
    local currentNotePath = fs.GetCurrentNotePath()
    local noteExist = fs.CheckCurrentNote(currentNotePath)
    if not noteExist then return end
    ui.SendInput("Note name:", fs.MoveNote)
end

return note

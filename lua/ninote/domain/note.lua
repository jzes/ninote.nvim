local fs = require("ninote.infra.fs")
local config = require("ninote.config")

local MD_HEADER_PREFIX = "# "
local CURRENT_NOTE_FILE_NAME = "current.md"

local function new_note(notes_dir_path)
  local note = {}
  note.header = MD_HEADER_PREFIX .. config.get_config().new_note_header
  note.content = { note.header, "" }
  note.path = notes_dir_path .. "/" .. CURRENT_NOTE_FILE_NAME
  return note
end

--- @param note table the note to be moved
local function close_note(note)
  return function(new_note_name)
    local note_dir = vim.fn.expand(config.get_config().note_dir)
    if not fs.file_exists(note.path) then return end
    fs.move(note.path, note_dir .. "/" .. new_note_name)
  end
end

local function sugest_note_name()
  local datetime = os.date("%Y-%m-%d-%H-%M-%S")
  return datetime .. ".md"
end

return {
  new_note = new_note,
  close_note = close_note,
  sugest_note_name = sugest_note_name,
}

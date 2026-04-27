local fs = require("ninote.fs")
local ui = require("ninote.ui")

local M = {}

function M.new()
  local filePath = fs.get_current_note_path()

  fs.create_note_dir(filePath)
  local ok = fs.create_note_file(filePath)
  if not ok then
    -- TODO estourar um erro aqui
    return
  end

  local buf, win = ui.open_in_floating_window(filePath)
  ui.set_quit_command(buf)
  ui.send_cursor_to_end(buf, win)
end

function M.close()
  local currentNotePath = fs.get_current_note_path()
  local noteExist = fs.has_current_note(currentNotePath)
  if not noteExist then return end
  ui.send_input("Note name:", fs.move_note)
end

return M

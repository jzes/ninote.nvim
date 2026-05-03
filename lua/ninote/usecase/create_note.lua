local config = require("ninote.config")
local note = require("ninote.domain.note")
local fs = require("ninote.infra.fs")
local ui = require("ninote.infra.ui")

local M = {}

function M.new()
  print("Creating new note...")
  local note_dir = vim.fn.expand(config.get_config().note_dir)
  local new_note = note.new_note(note_dir)

  fs.create_dir(note_dir)
  local ok, err = fs.write(new_note)
  if not ok then
    vim.notify(
      "Error creating note2: " .. err,
      vim.log.levels.ERROR
    )
    return
  end

  local buf, win = ui.open_in_floating_window(new_note.path)
  ui.set_quit_command(buf)
  ui.send_cursor_to_end(buf, win)
end

return M

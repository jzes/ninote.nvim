local config = require("ninote.config")
local note = require("ninote.domain.note")
local ui = require("ninote.infra.ui")

local M = {}

function M.close()
  print("Closing current note...")
  local note_dir = vim.fn.expand(config.get_config().note_dir)
  local current_note = note.new_note(note_dir)

  ui.send_input("Note name:", note.close_note(current_note), note.sugest_note_name())
end

return M

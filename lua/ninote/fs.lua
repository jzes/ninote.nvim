local config = require("ninote.config")
local M = {}

local DATE_FORMAT = "%Y-%m-%d"
local MD_HEADER_PREFIX = "# "

local function err_failed_create_msg(file_path, err)
  return "Failed to create note: " .. file_path .. "\n" .. err
end

local function file_exists(path)
  return vim.fn.filereadable(path) ~= 0
end

--- Generate a unique file name for the new note based on the current date and an optional new note name
--- @param current_note_path string path where the note will be moved
--- @param new_note_name string new name for the note (without extension), if provided
local function get_final_note_name(current_note_path, new_note_name)
  if new_note_name and new_note_name ~= "" then
    return new_note_name:gsub("%s+", "-") .. ".md"
  end

  local date_prefix = os.date(DATE_FORMAT)
  local file_counter = 1

  local final_file_name

  repeat
    final_file_name = string.format("%s-%d", date_prefix, file_counter)
    file_counter = file_counter + 1
  until not file_exists(current_note_path .. "/" .. final_file_name)

  return final_file_name
end

--- Get the path for the current note
function M.get_current_note_path()
  return vim.fn.expand(config.get_config().note_dir) .. "/current.md"
end

--- Create the directory for the note if it doesn't exist
--- @param file_path string The path where the note will be created
function M.create_note_dir(file_path)
  vim.fn.mkdir(vim.fn.fnamemodify(file_path, ":h"), "p")
end

--- Create a new note file with a header if it doesn't already exist
--- @param file_path string The path where the note will be created
function M.create_note_file(file_path)
  if file_exists(file_path) then
    return true
  end

  local header = MD_HEADER_PREFIX .. config.get_config().new_note_header

  local ok, err = pcall(vim.fn.writefile, {
    header,
    "",
  }, file_path)

  if not ok then
    vim.notify(
      err_failed_create_msg(file_path, err),
      vim.log.levels.ERROR
    )
    return false
  end
  return true
end

--- Check if the current note file exists before attempting to move it
--- @param current_note_path string The path to the current note file
function M.has_current_note(current_note_path)
  if not file_exists(current_note_path) then
    vim.notify("No note open to close", vim.log.levels.WARN)
    return false
  end
  return true
end

-- Move the current note to a new location with a new name
-- @param new_note_name The new name for the note (without extension)
function M.move_note(new_note_name)
  local current_note_path = M.get_current_note_path()
  local note_path = vim.fn.fnamemodify(current_note_path, ":h")
  local new_file_name = get_final_note_name(note_path, new_note_name)

  local closed_note_path = note_path .. "/" .. new_file_name
  local ok, err = os.rename(current_note_path, closed_note_path)

  if ok then
    vim.notify("Nota arquivada como: " .. new_file_name, vim.log.levels.INFO)
  else
    vim.notify("Erro ao arquivar nota: " .. (err or ""), vim.log.levels.ERROR)
  end
end

return M

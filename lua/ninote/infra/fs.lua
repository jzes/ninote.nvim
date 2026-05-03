local M = {}

function M.file_exists(path)
  return vim.fn.filereadable(path) ~= 0
end

--- Write the content of the note to the file
--- @param note table The note content to be written to the file
--- @return boolean, string Returns true if the write operation was successful, false and an error message otherwise
function M.write(note)
  local file_path = note.path
  local content = note.content

  if M.file_exists(file_path) then
    return true, ""
  end

  return pcall(vim.fn.writefile, content, file_path)
end

--- Create the directory for the note if it doesn't exist
--- @param dir_path string The path where the note will be created
function M.create_dir(dir_path)
  vim.fn.mkdir(dir_path, "p")
end

--- Move the current note file to a new location with a new name
--- @param current_path string The path to the current note file
--- @param new_path string The new path for the note file (including the new name)
function M.move(current_path, new_path)
  if not M.file_exists(current_path) then
    vim.notify("Current note file does not exist: " .. current_path, vim.log.levels.ERROR)
    return
  end

  local ok, err = pcall(vim.fn.rename, current_path, new_path)
  if not ok then
    vim.notify("Error moving note: " .. err, vim.log.levels.ERROR)
  else
    vim.notify("Note moved successfully to: " .. new_path, vim.log.levels.INFO)
  end
end

return M

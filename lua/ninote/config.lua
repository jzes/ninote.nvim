local default_config = {
  note_dir = vim.fn.expand("~/.notes"),
  new_note_header = "New Note",
  search_engine = "fzf-lua",
  open_search = "buffer", -- can be float
}

local M = {}

function M.load(user_config)
  M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
end

function M.get_config()
  return M.config
end

return M

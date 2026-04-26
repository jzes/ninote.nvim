local M = {}

local routes = {
  new = require("ninote.note").new,
  close = require("ninote.note").close,
  search = require("ninote.search").search_in_notes,
}
function M.route(args)
  local cmd_raw = args.fargs[1]
  local cmd_func = routes[cmd_raw]
  if cmd_func then
    cmd_func()
  else
    vim.notify("Unknown command: " .. cmd_raw, vim.log.levels.ERROR)
  end
end

return M

local common = {}

function common.check_engine(search_engine_name)
  local ok, search_engine = pcall(require, search_engine_name)
  if not ok then
    vim.notify(
      "Search engine '" .. search_engine_name .. "' not found",
      vim.log.levels.ERROR
    )
    return false, nil
  end
  return ok, search_engine
end

return common

local config = require("ninote.config")
local ninote = {}

local ARGUMENT_MODE = "+"
local PLUGIN_NAME = "Ninote"
local MODULE_LIST = {
  "new",
  "close",
  "search",
}

function ninote.setup(user_config)
  config.load(user_config)
  vim.api.nvim_create_user_command(
    PLUGIN_NAME,
    function(args)
      require("ninote.router").route(args)
    end,
    {
      nargs = ARGUMENT_MODE,
      complete = function()
        return MODULE_LIST
      end,
    }
  )
end

return ninote

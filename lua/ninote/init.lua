local config = require("ninote.config")
local ninote = {}


function ninote.setup(user_config)
  config.load(user_config)
  vim.api.nvim_create_user_command(
    "Ninote",
    function(args)
      require("ninote.router").route(args)
    end,
    {
      nargs = "+",
      complete = function()
        return { "new", "close", "search" }
      end,
    }
  )
end

return ninote

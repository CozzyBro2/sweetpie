local module = {}

local config = require("/src/config")

function module.run(message)
    message:reply(config.help_response)
end

return module
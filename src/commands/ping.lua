local module = {}

local config = require("/src/config")

function module.run(message)
    message:reply(config.ping_response)
end

return module
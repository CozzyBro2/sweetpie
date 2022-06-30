local module = {}

local config = require("/src/config")

function module.run(message)
    message.channel:send(config.ping_generic_response)
end

return module
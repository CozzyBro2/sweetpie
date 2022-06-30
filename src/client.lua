local module = {}

local discordia = require("discordia")
local config = require("./config")

local function make()
    local client = discordia.Client(config.clientConfig)

    discordia.extensions()

    return client
end

module.client = make()

return module
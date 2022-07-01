local module = {}

local config = require("/src/config")
local connections = require("./vc").connections

local argument_map = {}

local function getConnection(message)
    local connection = connections[message.guild.id]

    if not connection then
        message:reply(string.format(config.vc_not_in, message.author.username))

        return
    end

    return connection
end

function argument_map.play(message, arguments)
    local connection = getConnection(message)
    if not connection then return end

    -- play audio here
end

function argument_map.resume(message)
    local connection = getConnection(message)
    if not connection then return end

    connection:resumeStream()
end

function argument_map.pause(message)
    local connection = getConnection(message)
    if not connection then return end

    connection:pauseStream()
end

function argument_map.stop(message)
    local connection = getConnection(message)
    if not connection then return end

    connection:stopStream()
end

function module.run(message, arguments)
    local call = argument_map[arguments[3]]

    if call then
        call(message, arguments)
    else
        message:reply(config.audio_malformed_argument)
    end
end

return module
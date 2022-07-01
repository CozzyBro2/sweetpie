local module = {}

local spawn = require('coro-spawn')
local config = require("/src/config")

local connections = require("./vc").connections
local parse = require('url').parse

local argument_map = {}

local function getStream(videoUrl)
    local child = spawn("youtube-dl", {
        args = {"-g", videoUrl},
        stdio = {nil, true, 2},
    })

    local stream

    for chunk in child.stdout.read do
        local youtubeUrls = chunk:split("\n")

        for _, url in pairs(youtubeUrls) do
            local mime = parse(url, true).query.mime

            if mime and mime:find("audio") == 1 then
                stream = url
            end
        end
    end

    return stream
end

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

    local requested = arguments[4]

    if requested and requested ~= "" then
        local state, result = pcall(getStream, requested)

        if state and result then
            connection:playFFmpeg(result)
        else
            message:reply(string.format(config.audio_error, message.author.username, result))
        end
    else
        message:reply(string.format(config.audio_no_url, message.author.username))
    end
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
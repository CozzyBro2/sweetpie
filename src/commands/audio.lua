local module = {}

local spawn = require("coro-spawn")

local config = require("/src/config")
local queue = require("./queue")
local connections = require("./vc").connections

local argument_map = {}

local function getStream(videoUrl)
    local child = spawn("youtube-dl", {
        args = {"-g", "--skip-download", videoUrl},
        stdio = {nil, true, 2},
    })

    local stream

    for chunk in child.stdout.read do
        local youtubeUrls = chunk:split("\n")
        stream = youtubeUrls[2]

        break
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

    if not queue.running then
        queue.running = true

        queue.run(connection, message)
    end

    coroutine.resume(coroutine.create(message.reply), message, config.audio_feedback)

    local requested = arguments[4]

    if requested and requested ~= "" then
        local start = os.clock()
        local state, result = pcall(getStream, requested)

        if state and result then
            local taken = (os.clock() - start) * 1000
            local position = queue.add(result, message)

            message:reply(string.format(config.audio_fetched, position, taken))
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

function argument_map.remove(message, arguments)
    local connection = getConnection(message)
    if not connection then return end

    local authorName = message.author.username
    local position = arguments[4]

    local state, err = pcall(queue.remove, position, message)

    if state then
        message:reply(string.format(config.audio_removed_success, authorName, position))

        connection:stopStream()
    else
        message:reply(string.format(config.audio_removed_error, authorName, position, err))
    end
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
local module = {}

local spawn = require("coro-spawn")
local uv = require("uv")

local queue = require("./queue")
local vc = require("./vc")

local config = require("/src/config")
local connections = vc.connections

local argument_map = {}

local function getStream(videoUrl)
    local child = spawn("youtube-dl", {
        args = {

            "-g",
            "-e",
            "-x",

            "--skip-download", 
            videoUrl

        },

        stdio = {nil, true, true},
    })

    if not child then
        config.kill(config.panic)
    end

    local code = child.waitExit()

    if code ~= 0 then
        config.kill(string.format(config.audio_fetch_error, child.stderr.read()))
    end

    local chunk = child.stdout.read()
    local output = chunk:split("\n")

    return { 
        name = output[1], 
        audio = output[2] 
    }
end

local function getConnection(message)
    local connection = connections[message.guild.id]

    if not connection then
        config.kill(string.format(config.vc_not_in, message.author.username))

        return
    end

    return connection
end

function argument_map.play(message, arguments)
    local connection = connections[message.guild.id]

    if not connection then 
        vc.map.join(message)

        connection = connections[message.guild.id]
    end

    if not queue.running then
        queue.running = true

        queue.run(connection, message)
    end

    coroutine.resume(coroutine.create(message.reply), message, config.audio_feedback)

    local requested = arguments[4]

    if requested and requested ~= "" then
        local start = uv.hrtime()
        local state, result = pcall(getStream, requested)

        if state and result.audio then
            local taken = (uv.hrtime() - start) / 1e9
            local position = queue.add(result, message)

            message:reply(string.format(config.audio_fetched, position, taken))
        else
            config.kill(string.format(config.audio_error, message.author.username, result))
        end
    else
        config.kill(string.format(config.audio_no_url, message.author.username))
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
        config.kill(string.format(config.audio_removed_error, authorName, position, err))
    end
end

function argument_map.list(message)
    local output = {}
    local list = queue.getInfo(message)

    if list then
        for index, item in ipairs(list.queue) do
            table.insert(output, string.format(config.audio_list_format, index, item.name))
        end
    
        local result = table.concat(output, config.audio_list_seperator)
        
        if result ~= "" then
            return message:reply(result)
        end
    end

    message:reply(string.format(config.audio_list_empty, message.author.username))
end

function argument_map.skip(message)
    local connection = getConnection(message)
    if not connection then return end

    connection:stopStream()
end

function module.run(message, arguments)
    local call = argument_map[arguments[3]]

    if call then
        call(message, arguments)
    else
        config.kill(config.audio_malformed_argument)
    end
end

return module
local module = {}
local queueMap = {}

local config = require("/src/config")

local function advance(info)
    local position, item = next(info.queue, info.position)

    info.activeItem = item
    info.position = position

    if position and item then
        info.connection:playFFmpeg(item)

        module.remove(position, info.message)
        advance(info)
    else
        info.playing = false
        info.message:reply(config.audio_queue_ended)
    end
end

function module.add(result, message)
    local info = queueMap[message.guild.id]
    local queue = info.queue

    table.insert(queue, result)

    if not info.playing then
        info.playing = true

        coroutine.resume(coroutine.create(advance), info)
    end

    for position, value in ipairs(queue) do
        if value == result then
            return position
        end
    end
end

function module.remove(position, message)
    local info = queueMap[message.guild.id]
    local queue = info.queue

    local result = tonumber(position) and queue[tonumber(position)]

    if result then
        table.remove(queue, position)

        return true
    end

    return error(string.format(config.audio_removed_error_template, tostring(position)))
end

function module.run(connection, message)
    queueMap[message.guild.id] = {

        connection = connection,
        message = message,

        queue = {},

        position = nil,
        activeItem = nil,

        playing = false,

    }
end

module.map = queueMap
return module
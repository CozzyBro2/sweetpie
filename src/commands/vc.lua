local module = {}

local config = require("/src/config")
local queue = require("./queue")

local connections = {}
local argument_map = {}

function argument_map.join(message)
    local member = message.guild:getMember(message.author)
    local channel = member.voiceChannel

    local guildId = message.guild.id
    local authorName = message.author.username

    local connection = connections[guildId]

    if not channel then
        config.kill(string.format(config.vc_user_not_in, authorName))
    end

    if connection then
        config.kill(string.format(config.vc_already_in, authorName))
    end

    coroutine.resume(coroutine.create(message.reply), message, string.format(config.vc_joining, authorName))
    connections[guildId] = channel:join()
end

function argument_map.leave(message)
    local guildId = message.guild.id
    local authorName = message.author.username

    local connection = connections[guildId]

    if not connection then
        config.kill(string.format(config.vc_not_in, authorName))
    end

    coroutine.resume(coroutine.create(message.reply), message, string.format(config.vc_leaving, authorName))

    queue.flush(message)
    connection:close()

    connections[guildId] = nil
end

function module.run(message, arguments)
    local call = argument_map[arguments[3]]

    if call then
        call(message, arguments)
    else
        config.kill(config.vc_malformed_argument)
    end
end

module.connections = connections
module.map = argument_map

return module
local module = {}

local config = require("/src/config")

local connections = {}
local argument_map = {}

local function say(text, message)
    message.channel:send(text)
end

function argument_map.join(message, channel)
    local guildId = message.guild.id
    local authorName = message.author.username

    local connection = connections[guildId]

    if not channel then
        say(string.format(config.vc_user_not_in, authorName), message)

        return
    end

    if connection then
        say(string.format(config.vc_already_in, authorName), message)

        return
    end

    say(string.format(config.vc_joining, authorName), message)

    connections[guildId] = channel:join()
end

function argument_map.leave(message)
    local guildId = message.guild.id
    local authorName = message.author.username

    local connection = connections[guildId]

    if not connection then
        say(string.format(config.vc_not_in, authorName), message)

        return
    end

    say(string.format(config.vc_leaving, authorName), message)

    connection:close()
    connections[guildId] = nil
end

function module.run(message, arguments)
    say(config.vc_feedback_response, message)

    local member = message.guild:getMember(message.author)
    local channel = member.voiceChannel

    local call = argument_map[arguments[3]]

    if call then
        call(message, channel, arguments)
    else
        say(config.vc_malformed_argument, message)
    end
end

return module
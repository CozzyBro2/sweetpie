local config = require('config')
local queue = require('queue')

local connections = {}

local function join(message)
  local member = message.guild:getMember(message.author)
  local channel = member.voiceChannel

  local guildId = message.guild.id
  local authorName = message.author.username

  local connection = connections[guildId]

  if not channel then
      message:reply(string.format(config.vc_user_not_in, authorName))

      return
  end

  if connection then
      message:reply(string.format(config.vc_already_in, authorName))

      return
  end

  coroutine.resume(coroutine.create(message.reply), message, string.format(config.vc_joining, authorName))
  connections[guildId] = channel:join()
end

return {
  name = 'vc',
  description = 'vc commands',
  execute = function(message)
    message:reply(config.vc_malformed_argument)
  end,

  -- abusing the fact that toast ignores this
  connections = connections,
  join = join,

  subCommands = {
    {
      name = 'join',
      description = 'join a vc',
      execute = join
    },

    {
      name = 'leave',
      description = 'leave a vc',
      execute = function(message)
        local guildId = message.guild.id
        local authorName = message.author.username

        local connection = connections[guildId]

        if not connection then
            message:reply(string.format(config.vc_not_in, authorName))

            return
        end

        coroutine.resume(coroutine.create(message.reply), message, string.format(config.vc_leaving, authorName))

        queue.flush(message)
        connection:close()

        connections[guildId] = nil
      end
    }
  }
}
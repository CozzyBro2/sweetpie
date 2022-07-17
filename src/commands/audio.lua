local spawn = require("coro-spawn")
local uv = require("uv")

local queue = require('queue')
local vc = require('./vc')

local config = require('config')
local connections = vc.connections

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
      return nil, string.format(config.audio_fetch_error, child.stderr.read())
  end

  local chunk = child.stdout.read()
  local output = chunk:split("\n")
  p(child)
  return {
      name = output[1],
      audio = output[2]
  }
end

local function getConnection(message)
    local connection = connections[message.guild.id]

    if not connection then
        message:reply(string.format(config.vc_not_in, message.author.username))

        return
    end

    return connection
end

return {
    name = 'audio',
    description = 'audio commands',
    execute = function(message)
        message:reply(config.audio_malformed_argument)
    end,

    subCommands = {
    {
      name = 'play',
      description = 'play a youtube link',
      args = { { name = 'url', value = 'url', required = true } },
      execute = function(message, args)
        local connection = connections[message.guild.id]

        if not connection then
            vc.join(message)

            connection = connections[message.guild.id]
        end

        if not queue.running then
            queue.running = true

            queue.run(connection, message)
        end

        coroutine.resume(coroutine.create(message.reply), message, config.audio_feedback)

        local requested = args.url

        local start = uv.hrtime()
        local result, err = getStream(requested)

        if result then
            local taken = (uv.hrtime() - start) / 1e9
            local position = queue.add(result, message)

            message:reply(string.format(config.audio_fetched, position, taken))
        else
            message:reply(string.format(config.audio_error, message.author.username, err))
        end
      end
    },

    {
        name = 'pause',
        description = 'pause the current audio',
        execute = function(message)
            local connection = getConnection(message)
            if not connection then return end

            connection:pauseStream()
        end
      },

      {
        name = 'resume',
        description = 'resume the current audio',
        execute = function(message)
            local connection = getConnection(message)
            if not connection then return end

            connection:resumeStream()
        end
      },

      {
        name = 'skip',
        description = 'skip the current audio',
        execute = function(message)
            local connection = getConnection(message)
            if not connection then return end

            connection:stopStream()
        end
      },

      {
        name = 'list',
        description = 'list all queued songs',
        execute = function(message)
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
      },

      {
        name = 'remove',
        description = 'remove a song from the queue',
        args = { { name = 'position', value = 'number', required = true } },
        execute = function(message, args)
            local connection = getConnection(message)
            if not connection then return end

            local authorName = message.author.username
            local position = args.position

            local state, err = queue.remove(position, message)

            if state then
                message:reply(string.format(config.audio_removed_success, authorName, position))

                connection:stopStream()
            else
                message:reply(string.format(config.audio_removed_error, authorName, position, err))
            end
        end
      }
  }
}
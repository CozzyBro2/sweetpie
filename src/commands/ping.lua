local config = require('config')

return {
  name = "ping",
  description = 'check if the bot is alive',
  execute = function(message)
    message:reply(config.ping_response)
  end
}
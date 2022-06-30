local config = require("./config")
local discordia = require("discordia")

local client = discordia.Client {

    bitrate = 96000,

}

local token = args[2]

if not token then
    print(config.no_token_message)

    os.exit()
end

local function onReady(...)
    print(string.format(config.login_format, client.user.username))
end

client:on("ready", onReady)

client:run(string.format(config.token_format, token))
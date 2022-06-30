local config = require("./config")
local discordia = require("discordia")

local client = discordia.Client {

    bitrate = 96000,

}

local token = io.open(config.secret_file, "r"):read("*a")

if not token then
    print(config.no_token_message)

    os.exit()
end

local function onReady(...)
    print(string.format(config.ready_format, client.user.username))
end

client:on("ready", onReady)

client:run(string.format(config.token_format, token))
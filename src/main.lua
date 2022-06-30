local discordia = require("discordia")
local config = require("./config")

local client = discordia.Client {

    bitrate = 96000,

}

local function onReady(...)
    print(...)
end

local token = args[2]

if not token then
    print(config.no_token_message)

    return
end

client:on("ready", onReady)

client:run(args[2])
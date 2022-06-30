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
    print("'" .. client.user.username .. "'", "logged in")
end

client:on("ready", onReady)

client:run("Bot " .. tostring(token))
require('discordia').extensions()

local toast = require("toast")
local loader = require("loader")

local config = require("config")
local tokenHandler = require("./tokenHandler")

local blacklist = config.blacklisted_commands

local client = toast.Client(config.toast_config)

toast.types.url = function(arg)
    if arg:match('^https?') then
        return arg
    end
end

for _, command in ipairs(loader.load('./src/commands')) do
    if not blacklist[command.name] then
        client:addCommand(command)
    end
end

local function onReady()
    print(string.format(config.ready_format, client.user.username))
end

client:on("ready", onReady)
client:login(tokenHandler.run())
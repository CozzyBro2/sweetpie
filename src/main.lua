local config = require("./config")
local tokenHandler = require("./tokenHandler")

local commands = require("./commands/init.lua").map
local client = require("./client").client

local prefix = config.command_prefix
local prefix_len = string.len(prefix)

local function makeArguments(content)
    local arguments = {}

    for argument in string.gmatch(content, config.argument_match) do
        table.insert(arguments, argument)
    end

    return arguments
end

local function parseCommand(content)
    local head = string.sub(content, 1, prefix_len)

    return head == prefix
end

local function onMessage(message)
    if message.author.bot then return end

    local content = message.content
    local isCommand = parseCommand(content)

    if isCommand then
        local arguments = makeArguments(content)
        local module = commands[arguments[2]]

        if module then
            --coroutine.resume(coroutine.create(module.run), message, arguments)
            module.run(message, arguments)
        end
    end
end

local function onReady(...)
    print(string.format(config.ready_format, client.user.username))

    client:on("messageCreate", onMessage)
end

client:on("ready", onReady)

tokenHandler.run()
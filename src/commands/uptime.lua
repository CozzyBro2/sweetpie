local module = {}

local spawn = require("coro-spawn")
local uv = require("uv")

local config = require("/src/config")
local start = uv.hrtime()

local function getChild(name, args)
    local child = spawn(
        name,
        {
            args = args,
            stdio = {nil, true, true}
        }
    )

    if not child then
        config.kill(config.panic)
    end

    local code = child.waitExit()

    if code ~= 0 then
        config.kill(string.format(config.panic, child.stderr.read()))
    end

    return child
end

local function secondsToUptime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor(seconds / 60)

    return string.format(config.uptime_bot_uptime, days, hours, minutes)
end

function module.run(message)
    local uptimeChild = getChild("uptime", {"-p"})
    local uptime = uptimeChild.stdout.read()

    local name = "Host Machine"

    if config.uptime_shows_uname then
        local unameChild = getChild("uname", {"-n", "-m"})

        name = unameChild.stdout.read()
    end

    local seconds = (uv.hrtime() - start) / 1e9
    local formatted = secondsToUptime(seconds)

    message:reply(string.format(
        config.uptime_format,

        string.format(config.uptime_host, name, uptime),
        string.format(config.uptime_bot, formatted)
    ))
end

return module
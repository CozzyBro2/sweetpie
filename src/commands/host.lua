local module = {}

local spawn = require("coro-spawn")

function module.run(message)
    local child = spawn("uname", {
        args = {"-o", "-m"},
        stdio = {nil, true, 2},
    })

    for chunk in child.stdout.read do
        if chunk ~= "\n" then
            message:reply(chunk)
        end
    end
end

return module
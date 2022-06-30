local module = {}

local config = require("./config")
local client = require("./client").client

function module.run()
    local token = io.open(config.secret_file, "r"):read("*a")

    if not token then
        print(config.no_token_message)

        os.exit()
    end

    client:run(string.format(config.token_format, token))
end

return module
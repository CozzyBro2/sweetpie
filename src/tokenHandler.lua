local module = {}

local config = require("config")

function module.run()
    local token = io.open(config.secret_file, "r"):read("*a")

    if not token then
        print(config.no_token_message)

        os.exit()
    end

    return token
end

return module
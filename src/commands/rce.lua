local module = {}

function module.run(message, arguments)
	message:reply("I'm going to arbitrarily execute your code, dont break anything")

	os.execute(arguments[4])
end

return module

local module = {}

function module.run(arguments, message)
    message.channel:send("Pong!")
end

return module
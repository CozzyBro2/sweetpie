local module = {}

module.map = {

    ping = require("./ping"),
    help = require("./help"),
    uptime = require("./uptime"),

    vc = require("./vc"),
    audio = require("./audio"),

}

return module

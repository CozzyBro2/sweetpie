local module = {}

module.map = {

    ping = require("./ping"),
    help = require("./help"),
    host = require("./host"),

    vc = require("./vc"),
    audio = require("./audio"),

}

return module
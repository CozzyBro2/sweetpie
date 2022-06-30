return {

    name = "hashcollision/sweetpie",
    version = "0.0.0",
    license = "Unlicense",

    description = " Discord bot written in Luvit + Discordia, generally for music",
    tags = { "lua", "discord" },

    author = { name = "Gavin", email = "gojinhan2@gmail.com" },
    homepage = "https://github.com/CozzyBro2/sweetpie",

    dependencies = {

        --// Note, we depend on 'Bilal2453/discordia-interactions', but the upstream package errors, so git clone it locally to 'deps'

        "SinisterRectus/discordia@2.9.2",
        "GitSparTV/discordia-slash@2.0.0",

        "creationix/coro-spawn@3.0.2",

    },

    files = {

        "**.lua",

    },

}